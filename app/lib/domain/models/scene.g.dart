// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scene.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Scene _$SceneFromJson(Map<String, dynamic> json) => _Scene(
  sceneId: json['scene_id'] as String,
  sceneName: json['scene_name'] as String,
  sceneDescription: json['scene_description'] as String,
  exampleImages:
      (json['example_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  suitableStyles:
      (json['suitable_styles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  unsuitableStyles:
      (json['unsuitable_styles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  recommendedOrientation: $enumDecode(
    _$OrientationEnumMap,
    json['recommended_orientation'],
  ),
  recommendedFraming: $enumDecode(
    _$FramingEnumMap,
    json['recommended_framing'],
  ),
  recommendedCamera:
      (json['recommended_camera'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  foregroundHints:
      (json['foreground_hints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  backgroundHints:
      (json['background_hints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  keepBackground: json['keep_background'] as bool? ?? true,
);

Map<String, dynamic> _$SceneToJson(_Scene instance) => <String, dynamic>{
  'scene_id': instance.sceneId,
  'scene_name': instance.sceneName,
  'scene_description': instance.sceneDescription,
  'example_images': instance.exampleImages,
  'suitable_styles': instance.suitableStyles,
  'unsuitable_styles': instance.unsuitableStyles,
  'recommended_orientation':
      _$OrientationEnumMap[instance.recommendedOrientation]!,
  'recommended_framing': _$FramingEnumMap[instance.recommendedFraming]!,
  'recommended_camera': instance.recommendedCamera,
  'foreground_hints': instance.foregroundHints,
  'background_hints': instance.backgroundHints,
  'keep_background': instance.keepBackground,
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
