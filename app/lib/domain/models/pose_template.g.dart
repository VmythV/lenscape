// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pose_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PoseTemplate _$PoseTemplateFromJson(
  Map<String, dynamic> json,
) => _PoseTemplate(
  poseId: json['pose_id'] as String,
  poseName: json['pose_name'] as String,
  styleIds:
      (json['style_ids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  personTypes:
      (json['person_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sceneTypes:
      (json['scene_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  illustrationImage: json['illustration_image'] as String,
  poseOutlineImage: json['pose_outline_image'] as String,
  supportsOrientation:
      (json['supports_orientation'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$OrientationEnumMap, e))
          .toList() ??
      const [],
  supportsFraming:
      (json['supports_framing'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$FramingEnumMap, e))
          .toList() ??
      const [],
  bodyInstruction: json['body_instruction'] as String,
  handInstruction: json['hand_instruction'] as String,
  faceInstruction: json['face_instruction'] as String,
  eyeInstruction: json['eye_instruction'] as String,
  positionInstruction: json['position_instruction'] as String,
  cameraPositionInstruction: json['camera_position_instruction'] as String,
  cameraHeight: $enumDecode(_$CameraHeightEnumMap, json['camera_height']),
  cameraAngle: $enumDecode(_$CameraAngleEnumMap, json['camera_angle']),
  cameraDirection: $enumDecode(
    _$CameraDirectionEnumMap,
    json['camera_direction'],
  ),
  cameraDistance: $enumDecode(_$CameraDistanceEnumMap, json['camera_distance']),
  subjectPosition: $enumDecode(
    _$SubjectPositionEnumMap,
    json['subject_position'],
  ),
  subjectRatio: $enumDecode(_$SubjectRatioEnumMap, json['subject_ratio']),
  compositionInstruction: json['composition_instruction'] as String,
  tips:
      (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  qualityScore: (json['quality_score'] as num?)?.toInt() ?? 0,
  isReviewed: json['is_reviewed'] as bool? ?? false,
);

Map<String, dynamic> _$PoseTemplateToJson(_PoseTemplate instance) =>
    <String, dynamic>{
      'pose_id': instance.poseId,
      'pose_name': instance.poseName,
      'style_ids': instance.styleIds,
      'person_types': instance.personTypes,
      'scene_types': instance.sceneTypes,
      'illustration_image': instance.illustrationImage,
      'pose_outline_image': instance.poseOutlineImage,
      'supports_orientation': instance.supportsOrientation
          .map((e) => _$OrientationEnumMap[e]!)
          .toList(),
      'supports_framing': instance.supportsFraming
          .map((e) => _$FramingEnumMap[e]!)
          .toList(),
      'body_instruction': instance.bodyInstruction,
      'hand_instruction': instance.handInstruction,
      'face_instruction': instance.faceInstruction,
      'eye_instruction': instance.eyeInstruction,
      'position_instruction': instance.positionInstruction,
      'camera_position_instruction': instance.cameraPositionInstruction,
      'camera_height': _$CameraHeightEnumMap[instance.cameraHeight]!,
      'camera_angle': _$CameraAngleEnumMap[instance.cameraAngle]!,
      'camera_direction': _$CameraDirectionEnumMap[instance.cameraDirection]!,
      'camera_distance': _$CameraDistanceEnumMap[instance.cameraDistance]!,
      'subject_position': _$SubjectPositionEnumMap[instance.subjectPosition]!,
      'subject_ratio': _$SubjectRatioEnumMap[instance.subjectRatio]!,
      'composition_instruction': instance.compositionInstruction,
      'tips': instance.tips,
      'quality_score': instance.qualityScore,
      'is_reviewed': instance.isReviewed,
    };

const _$OrientationEnumMap = {
  Orientation.vertical: 'vertical',
  Orientation.horizontal: 'horizontal',
};

const _$FramingEnumMap = {
  Framing.fullBody: 'full_body',
  Framing.halfBody: 'half_body',
  Framing.closeUp: 'close_up',
};

const _$CameraHeightEnumMap = {
  CameraHeight.eyeLevel: 'eye_level',
  CameraHeight.chest: 'chest',
  CameraHeight.waist: 'waist',
  CameraHeight.low: 'low',
  CameraHeight.high: 'high',
};

const _$CameraAngleEnumMap = {
  CameraAngle.level: 'level',
  CameraAngle.topDown: 'top_down',
  CameraAngle.bottomUp: 'bottom_up',
};

const _$CameraDirectionEnumMap = {
  CameraDirection.front: 'front',
  CameraDirection.front45: 'front_45',
  CameraDirection.side: 'side',
  CameraDirection.back: 'back',
};

const _$CameraDistanceEnumMap = {
  CameraDistance.near: 'near',
  CameraDistance.mid: 'mid',
  CameraDistance.far: 'far',
};

const _$SubjectPositionEnumMap = {
  SubjectPosition.center: 'center',
  SubjectPosition.leftThird: 'left_third',
  SubjectPosition.rightThird: 'right_third',
};

const _$SubjectRatioEnumMap = {
  SubjectRatio.subjectFirst: 'subject_first',
  SubjectRatio.balanced: 'balanced',
  SubjectRatio.sceneFirst: 'scene_first',
};
