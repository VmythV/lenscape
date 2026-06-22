// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonTypeInfo _$PersonTypeInfoFromJson(Map<String, dynamic> json) =>
    _PersonTypeInfo(
      personType: json['person_type'] as String,
      personName: json['person_name'] as String,
      direction: json['direction'] as String,
      minPeople: (json['min_people'] as num?)?.toInt() ?? 1,
      maxPeople: (json['max_people'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$PersonTypeInfoToJson(_PersonTypeInfo instance) =>
    <String, dynamic>{
      'person_type': instance.personType,
      'person_name': instance.personName,
      'direction': instance.direction,
      'min_people': instance.minPeople,
      'max_people': instance.maxPeople,
    };
