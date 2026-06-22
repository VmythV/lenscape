// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Favorite _$FavoriteFromJson(Map<String, dynamic> json) => _Favorite(
  poseId: json['pose_id'] as String,
  createdAt: (json['created_at'] as num).toInt(),
);

Map<String, dynamic> _$FavoriteToJson(_Favorite instance) => <String, dynamic>{
  'pose_id': instance.poseId,
  'created_at': instance.createdAt,
};
