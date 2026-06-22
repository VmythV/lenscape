import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/person_type.dart';
import '../../domain/models/pose_template.dart';
import '../../domain/models/scene.dart';
import '../../domain/models/style.dart';

/// 后端地址与应用级 token，通过 --dart-define 注入。
/// 未配置 base 时，网关进入纯本地模式（始终降级，使用本地兜底）。
const _apiBase = String.fromEnvironment('LENSCAPE_API_BASE', defaultValue: '');
const _apiToken = String.fromEnvironment('LENSCAPE_API_TOKEN', defaultValue: '');

/// 风格推荐候选（由本地推荐引擎能力 A 算出后传入）。
class StyleCandidate {
  const StyleCandidate({
    required this.styleId,
    required this.styleName,
    required this.baseScore,
  });
  final String styleId;
  final String styleName;
  final double baseScore;
}

class StyleRecommendation {
  const StyleRecommendation(this.styleId, this.reason);
  final String styleId;
  final String reason;
}

class StyleRecommendResult {
  const StyleRecommendResult(this.recommendations, {required this.degraded});
  final List<StyleRecommendation> recommendations;
  final bool degraded;
}

class GuidanceCopy {
  const GuidanceCopy(this.steps, this.tips, {required this.degraded});
  final List<String> steps;
  final List<String> tips;
  final bool degraded;
}

/// 后端两个接口的原始 HTTP 抽象，便于注入与测试。
abstract class LlmApi {
  Future<Map<String, dynamic>> styleRecommend(Map<String, dynamic> body);
  Future<Map<String, dynamic>> guidanceCopy(Map<String, dynamic> body);
}

class DioLlmApi implements LlmApi {
  DioLlmApi({required String baseUrl, required String token, Dio? dio})
      : _dio = (dio ?? Dio())
          ..options.baseUrl = baseUrl
          ..options.connectTimeout = const Duration(seconds: 3)
          ..options.receiveTimeout = const Duration(seconds: 10)
          ..options.headers['authorization'] = 'Bearer $token';

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> styleRecommend(Map<String, dynamic> body) async {
    final res = await _dio.post('/v1/style-recommend', data: body);
    return Map<String, dynamic>.from(res.data as Map);
  }

  @override
  Future<Map<String, dynamic>> guidanceCopy(Map<String, dynamic> body) async {
    final res = await _dio.post('/v1/guidance-copy', data: body);
    return Map<String, dynamic>.from(res.data as Map);
  }
}

/// 客户端 LLM 网关：调用后端增值能力，失败/降级时回退本地兜底
/// （见 docs/architecture.md §6.2 / §7）。
class LlmGateway {
  LlmGateway(this._api);

  /// [_api] 为 null 表示未配置后端，始终走本地兜底。
  final LlmApi? _api;

  bool get hasBackend => _api != null;

  Future<StyleRecommendResult> recommendStyles({
    required Scene scene,
    required PersonTypeInfo person,
    String? userNote,
    required List<StyleCandidate> candidates,
  }) async {
    if (_api == null) return _styleFallback(candidates);
    try {
      final data = await _api.styleRecommend({
        'scene_id': scene.sceneId,
        'scene_name': scene.sceneName,
        'scene_description': scene.sceneDescription,
        'person_type': person.personType,
        'person_name': person.personName,
        if (userNote != null && userNote.trim().isNotEmpty) 'user_note': userNote.trim(),
        'candidate_styles': [
          for (final c in candidates)
            {'style_id': c.styleId, 'style_name': c.styleName, 'base_score': c.baseScore},
        ],
      });
      final degraded = data['degraded'] == true;
      final recs = (data['recommendations'] as List<dynamic>? ?? [])
          .map((e) => StyleRecommendation(
                (e as Map)['style_id'] as String,
                (e['reason'] as String?) ?? '',
              ))
          .toList();
      if (recs.isEmpty) return _styleFallback(candidates);
      return StyleRecommendResult(recs, degraded: degraded);
    } catch (_) {
      return _styleFallback(candidates);
    }
  }

  Future<GuidanceCopy> generateGuidanceCopy({
    required Style style,
    required PersonTypeInfo person,
    required Scene scene,
    required PoseTemplate pose,
  }) async {
    if (_api == null) return _guidanceFallback(pose);
    try {
      final data = await _api.guidanceCopy({
        'style': {'style_id': style.styleId, 'style_name': style.styleName},
        'person': {'person_type': person.personType, 'person_name': person.personName},
        'scene': {
          'scene_id': scene.sceneId,
          'scene_name': scene.sceneName,
          'foreground_hints': scene.foregroundHints,
          'background_hints': scene.backgroundHints,
          'keep_background': scene.keepBackground,
        },
        'pose': _posePayload(pose),
      });
      final degraded = data['degraded'] == true;
      final steps = (data['steps'] as List<dynamic>? ?? []).cast<String>();
      final tips = (data['tips'] as List<dynamic>? ?? []).cast<String>();
      if (steps.isEmpty) return _guidanceFallback(pose);
      return GuidanceCopy(steps, tips, degraded: degraded);
    } catch (_) {
      return _guidanceFallback(pose);
    }
  }

  // ---- 本地兜底 ----

  StyleRecommendResult _styleFallback(List<StyleCandidate> candidates) {
    final sorted = [...candidates]..sort((a, b) => b.baseScore.compareTo(a.baseScore));
    return StyleRecommendResult(
      [for (final c in sorted) StyleRecommendation(c.styleId, '')],
      degraded: true,
    );
  }

  /// 用模板字段拼出兜底步骤（与后端 degrade 一致，见 llm-spec §4.4）。
  GuidanceCopy _guidanceFallback(PoseTemplate p) {
    final steps = <String>[
      p.bodyInstruction,
      p.handInstruction,
      '${p.faceInstruction} ${p.eyeInstruction}'.trim(),
      p.cameraPositionInstruction,
      p.compositionInstruction,
    ].where((s) => s.trim().isNotEmpty).toList();
    return GuidanceCopy(steps, p.tips, degraded: true);
  }

  Map<String, dynamic> _posePayload(PoseTemplate p) => {
        'pose_id': p.poseId,
        'pose_name': p.poseName,
        'body_instruction': p.bodyInstruction,
        'hand_instruction': p.handInstruction,
        'face_instruction': p.faceInstruction,
        'eye_instruction': p.eyeInstruction,
        'position_instruction': p.positionInstruction,
        'camera_position_instruction': p.cameraPositionInstruction,
        'camera_height': p.cameraHeight.name,
        'camera_angle': p.cameraAngle.name,
        'camera_direction': p.cameraDirection.name,
        'camera_distance': p.cameraDistance.name,
        'subject_position': p.subjectPosition.name,
        'subject_ratio': p.subjectRatio.name,
        'composition_instruction': p.compositionInstruction,
        'tips': p.tips,
      };
}

/// 全局网关 provider。未配置后端地址时进入纯本地兜底模式。
final llmGatewayProvider = Provider<LlmGateway>((ref) {
  if (_apiBase.isEmpty) return LlmGateway(null);
  return LlmGateway(DioLlmApi(baseUrl: _apiBase, token: _apiToken));
});
