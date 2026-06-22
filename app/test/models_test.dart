import 'package:flutter_test/flutter_test.dart';
import 'package:lenscape/domain/models/enums.dart';
import 'package:lenscape/domain/models/pose_template.dart';
import 'package:lenscape/domain/models/style.dart';
import 'package:lenscape/domain/models/history_entry.dart';

void main() {
  test('Style 从 snake_case JSON 解析并保留枚举与默认值', () {
    final style = Style.fromJson(const {
      'style_id': 'street',
      'style_name': '街拍风格',
      'style_description': '强调自然、松弛、氛围感。',
      'suitable_scenes': ['street', 'mall'],
      'suitable_person_types': ['male', 'female'],
      'default_orientation': 'vertical',
      'default_framing': 'full_body',
      'camera_rules': ['chest', 'bottom_up'],
      'sort_weight': 80,
    });

    expect(style.styleId, 'street');
    expect(style.defaultOrientation, Orientation.vertical);
    expect(style.defaultFraming, Framing.fullBody);
    expect(style.suitableScenes, ['street', 'mall']);
    expect(style.sampleImages, isEmpty); // 默认值
    expect(style.sortWeight, 80);
  });

  test('PoseTemplate 解析全部机位/构图枚举字段', () {
    final pose = PoseTemplate.fromJson(const {
      'pose_id': 'street_walking_001',
      'pose_name': '街边自然走路照',
      'style_ids': ['street'],
      'person_types': ['male'],
      'scene_types': ['street'],
      'illustration_image': 'images/poses/a.webp',
      'pose_outline_image': 'images/poses/a_outline.webp',
      'supports_orientation': ['vertical'],
      'supports_framing': ['full_body', 'half_body'],
      'body_instruction': '身体轻微侧向。',
      'hand_instruction': '一只手插兜。',
      'face_instruction': '脸朝前。',
      'eye_instruction': '看远处。',
      'position_instruction': '右三分之一。',
      'camera_position_instruction': '斜前方 3-5 米。',
      'camera_height': 'chest',
      'camera_angle': 'bottom_up',
      'camera_direction': 'front_45',
      'camera_distance': 'mid',
      'subject_position': 'right_third',
      'subject_ratio': 'balanced',
      'composition_instruction': '竖屏，保留背景。',
      'tips': ['避免背景杂乱'],
      'quality_score': 90,
      'is_reviewed': true,
    });

    expect(pose.cameraHeight, CameraHeight.chest);
    expect(pose.cameraAngle, CameraAngle.bottomUp);
    expect(pose.cameraDirection, CameraDirection.front45);
    expect(pose.subjectPosition, SubjectPosition.rightThird);
    expect(pose.supportsFraming, [Framing.fullBody, Framing.halfBody]);
    expect(pose.isReviewed, isTrue);
  });

  test('HistoryEntry 嵌套 context 往返序列化稳定', () {
    const entry = HistoryEntry(
      poseId: 'p1',
      context: HistoryContext(
        styleId: 'street',
        personType: 'male',
        sceneId: 'street',
      ),
      viewedAt: 1750560000000,
    );
    final round = HistoryEntry.fromJson(entry.toJson());
    expect(round, entry);
    expect(round.context.styleId, 'street');
  });
}
