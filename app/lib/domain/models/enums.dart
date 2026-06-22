import 'package:json_annotation/json_annotation.dart';

/// 受控枚举（见 docs/data-model.md §1.4）。
/// 每个枚举成员用 @JsonValue 绑定稳定的英文 code，与本地静态 JSON 一致。

/// 画幅
enum Orientation {
  @JsonValue('vertical')
  vertical,
  @JsonValue('horizontal')
  horizontal,
}

/// 取景
enum Framing {
  @JsonValue('full_body')
  fullBody,
  @JsonValue('half_body')
  halfBody,
  @JsonValue('close_up')
  closeUp,
}

/// 设备高度
enum CameraHeight {
  @JsonValue('eye_level')
  eyeLevel,
  @JsonValue('chest')
  chest,
  @JsonValue('waist')
  waist,
  @JsonValue('low')
  low,
  @JsonValue('high')
  high,
}

/// 设备角度
enum CameraAngle {
  @JsonValue('level')
  level,
  @JsonValue('top_down')
  topDown,
  @JsonValue('bottom_up')
  bottomUp,
}

/// 拍摄方向
enum CameraDirection {
  @JsonValue('front')
  front,
  @JsonValue('front_45')
  front45,
  @JsonValue('side')
  side,
  @JsonValue('back')
  back,
}

/// 拍摄距离
enum CameraDistance {
  @JsonValue('near')
  near,
  @JsonValue('mid')
  mid,
  @JsonValue('far')
  far,
}

/// 人物位置
enum SubjectPosition {
  @JsonValue('center')
  center,
  @JsonValue('left_third')
  leftThird,
  @JsonValue('right_third')
  rightThird,
}

/// 景物比例
enum SubjectRatio {
  @JsonValue('subject_first')
  subjectFirst,
  @JsonValue('balanced')
  balanced,
  @JsonValue('scene_first')
  sceneFirst,
}
