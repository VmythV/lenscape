import 'package:flutter_test/flutter_test.dart';
import 'package:lenscape/data/remote/llm_gateway.dart';
import 'package:lenscape/domain/models/enums.dart';
import 'package:lenscape/domain/models/person_type.dart';
import 'package:lenscape/domain/models/pose_template.dart';
import 'package:lenscape/domain/models/scene.dart';
import 'package:lenscape/domain/models/style.dart';

class _FakeApi implements LlmApi {
  _FakeApi({this.styleResp, this.guidanceResp, this.throwError = false});
  final Map<String, dynamic>? styleResp;
  final Map<String, dynamic>? guidanceResp;
  final bool throwError;

  @override
  Future<Map<String, dynamic>> styleRecommend(Map<String, dynamic> body) async {
    if (throwError) throw Exception('network down');
    return styleResp!;
  }

  @override
  Future<Map<String, dynamic>> guidanceCopy(Map<String, dynamic> body) async {
    if (throwError) throw Exception('network down');
    return guidanceResp!;
  }
}

const _scene = Scene(
  sceneId: 'cafe',
  sceneName: '咖啡店',
  sceneDescription: '氛围感',
  recommendedOrientation: Orientation.vertical,
  recommendedFraming: Framing.halfBody,
);
const _person = PersonTypeInfo(personType: 'female', personName: '女生', direction: '');
const _style = Style(
  styleId: 'korean',
  styleName: '韩系风格',
  styleDescription: '',
  defaultOrientation: Orientation.vertical,
  defaultFraming: Framing.halfBody,
);
const _pose = PoseTemplate(
  poseId: 'p1',
  poseName: '坐姿',
  illustrationImage: 'a.png',
  poseOutlineImage: 'a_o.png',
  bodyInstruction: '靠窗坐',
  handInstruction: '手放桌面',
  faceInstruction: '脸朝窗',
  eyeInstruction: '看窗外',
  positionInstruction: '偏右',
  cameraPositionInstruction: '斜前方 45 度',
  cameraHeight: CameraHeight.chest,
  cameraAngle: CameraAngle.topDown,
  cameraDirection: CameraDirection.front45,
  cameraDistance: CameraDistance.near,
  subjectPosition: SubjectPosition.center,
  subjectRatio: SubjectRatio.subjectFirst,
  compositionInstruction: '竖屏保留窗户',
  tips: ['收走杂物'],
);

const _candidates = [
  StyleCandidate(styleId: 'korean', styleName: '韩系', baseScore: 3),
  StyleCandidate(styleId: 'japanese', styleName: '日系', baseScore: 8),
];

void main() {
  group('无后端模式', () {
    final gw = LlmGateway(null);
    test('风格推荐降级，按 baseScore 排序', () async {
      final r = await gw.recommendStyles(
        scene: _scene,
        person: _person,
        candidates: _candidates,
      );
      expect(r.degraded, isTrue);
      expect(r.recommendations.first.styleId, 'japanese');
    });

    test('指导文案降级，用模板字段拼步骤', () async {
      final r = await gw.generateGuidanceCopy(
        style: _style,
        person: _person,
        scene: _scene,
        pose: _pose,
      );
      expect(r.degraded, isTrue);
      expect(r.steps.first, '靠窗坐');
      expect(r.steps.length, greaterThanOrEqualTo(4));
    });
  });

  group('有后端', () {
    test('风格推荐成功返回后端排序与理由', () async {
      final gw = LlmGateway(_FakeApi(styleResp: {
        'degraded': false,
        'recommendations': [
          {'style_id': 'korean', 'reason': '咖啡店适合韩系'},
        ],
      }));
      final r = await gw.recommendStyles(
        scene: _scene,
        person: _person,
        candidates: _candidates,
      );
      expect(r.degraded, isFalse);
      expect(r.recommendations.single.reason, '咖啡店适合韩系');
    });

    test('指导文案成功返回后端生成的步骤', () async {
      final gw = LlmGateway(_FakeApi(guidanceResp: {
        'degraded': false,
        'steps': ['坐在靠窗位置', '一只手端起咖啡杯', '眼神看向窗外', '拍摄者斜前方 45 度'],
        'tips': ['收走桌面杂物'],
      }));
      final r = await gw.generateGuidanceCopy(
        style: _style,
        person: _person,
        scene: _scene,
        pose: _pose,
      );
      expect(r.degraded, isFalse);
      expect(r.steps.length, 4);
      expect(r.tips.single, '收走桌面杂物');
    });

    test('后端抛错时回退本地兜底', () async {
      final gw = LlmGateway(_FakeApi(throwError: true));
      final r = await gw.generateGuidanceCopy(
        style: _style,
        person: _person,
        scene: _scene,
        pose: _pose,
      );
      expect(r.degraded, isTrue);
      expect(r.steps.first, '靠窗坐');
    });
  });
}
