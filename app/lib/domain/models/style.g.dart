// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Style _$StyleFromJson(Map<String, dynamic> json) => _Style(
  styleId: json['style_id'] as String,
  styleName: json['style_name'] as String,
  styleDescription: json['style_description'] as String,
  sampleImages:
      (json['sample_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  suitableScenes:
      (json['suitable_scenes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  suitablePersonTypes:
      (json['suitable_person_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  defaultOrientation: $enumDecode(
    _$OrientationEnumMap,
    json['default_orientation'],
  ),
  defaultFraming: $enumDecode(_$FramingEnumMap, json['default_framing']),
  compositionRules:
      (json['composition_rules'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  cameraRules:
      (json['camera_rules'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  sortWeight: (json['sort_weight'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$StyleToJson(_Style instance) => <String, dynamic>{
  'style_id': instance.styleId,
  'style_name': instance.styleName,
  'style_description': instance.styleDescription,
  'sample_images': instance.sampleImages,
  'suitable_scenes': instance.suitableScenes,
  'suitable_person_types': instance.suitablePersonTypes,
  'default_orientation': _$OrientationEnumMap[instance.defaultOrientation]!,
  'default_framing': _$FramingEnumMap[instance.defaultFraming]!,
  'composition_rules': instance.compositionRules,
  'camera_rules': instance.cameraRules,
  'sort_weight': instance.sortWeight,
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
