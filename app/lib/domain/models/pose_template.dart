import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'pose_template.freezed.dart';
part 'pose_template.g.dart';

/// 姿势模板（核心实体，见 docs/data-model.md §2.4）。
@freezed
abstract class PoseTemplate with _$PoseTemplate {
  const factory PoseTemplate({
    required String poseId,
    required String poseName,
    @Default([]) List<String> styleIds,
    @Default([]) List<String> personTypes,
    @Default([]) List<String> sceneTypes,
    required String illustrationImage,
    required String poseOutlineImage,
    @Default([]) List<Orientation> supportsOrientation,
    @Default([]) List<Framing> supportsFraming,
    required String bodyInstruction,
    required String handInstruction,
    required String faceInstruction,
    required String eyeInstruction,
    required String positionInstruction,
    required String cameraPositionInstruction,
    required CameraHeight cameraHeight,
    required CameraAngle cameraAngle,
    required CameraDirection cameraDirection,
    required CameraDistance cameraDistance,
    required SubjectPosition subjectPosition,
    required SubjectRatio subjectRatio,
    required String compositionInstruction,
    @Default([]) List<String> tips,
    @Default(0) int qualityScore,
    @Default(false) bool isReviewed,
  }) = _PoseTemplate;

  factory PoseTemplate.fromJson(Map<String, dynamic> json) =>
      _$PoseTemplateFromJson(json);
}
