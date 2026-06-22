import 'dart:convert';

import '../../domain/models/person_type.dart';
import '../../domain/models/pose_template.dart';
import '../../domain/models/scene.dart';
import '../../domain/models/style.dart';

/// 本地静态数据集合：解析后的风格 / 场景 / 人物类型 / 姿势模板，
/// 以及按 id 建立的索引（见 docs/data-model.md）。
class StaticDataset {
  StaticDataset({
    required this.styles,
    required this.scenes,
    required this.personTypes,
    required this.poses,
  })  : stylesById = {for (final s in styles) s.styleId: s},
        scenesById = {for (final s in scenes) s.sceneId: s},
        personTypesById = {for (final p in personTypes) p.personType: p},
        posesById = {for (final p in poses) p.poseId: p};

  final List<Style> styles;
  final List<Scene> scenes;
  final List<PersonTypeInfo> personTypes;
  final List<PoseTemplate> poses;

  final Map<String, Style> stylesById;
  final Map<String, Scene> scenesById;
  final Map<String, PersonTypeInfo> personTypesById;
  final Map<String, PoseTemplate> posesById;

  /// 从四个 JSON 字符串解析（解析失败/枚举非法会抛出，由调用方处理）。
  factory StaticDataset.fromJsonStrings({
    required String stylesJson,
    required String scenesJson,
    required String personTypesJson,
    required String posesJson,
  }) {
    List<T> parse<T>(String src, T Function(Map<String, dynamic>) fromJson) {
      final list = jsonDecode(src) as List<dynamic>;
      return list
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    }

    return StaticDataset(
      styles: parse(stylesJson, Style.fromJson),
      scenes: parse(scenesJson, Scene.fromJson),
      personTypes: parse(personTypesJson, PersonTypeInfo.fromJson),
      poses: parse(posesJson, PoseTemplate.fromJson),
    );
  }
}
