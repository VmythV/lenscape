// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryContext _$HistoryContextFromJson(Map<String, dynamic> json) =>
    _HistoryContext(
      styleId: json['style_id'] as String,
      personType: json['person_type'] as String,
      sceneId: json['scene_id'] as String,
    );

Map<String, dynamic> _$HistoryContextToJson(_HistoryContext instance) =>
    <String, dynamic>{
      'style_id': instance.styleId,
      'person_type': instance.personType,
      'scene_id': instance.sceneId,
    };

_HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) =>
    _HistoryEntry(
      poseId: json['pose_id'] as String,
      context: HistoryContext.fromJson(json['context'] as Map<String, dynamic>),
      viewedAt: (json['viewed_at'] as num).toInt(),
    );

Map<String, dynamic> _$HistoryEntryToJson(_HistoryEntry instance) =>
    <String, dynamic>{
      'pose_id': instance.poseId,
      'context': instance.context.toJson(),
      'viewed_at': instance.viewedAt,
    };
