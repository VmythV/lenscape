import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_type.freezed.dart';
part 'person_type.g.dart';

/// 人物类型（见 docs/data-model.md §2.3）。
@freezed
abstract class PersonTypeInfo with _$PersonTypeInfo {
  const factory PersonTypeInfo({
    required String personType,
    required String personName,
    required String direction,
    @Default(1) int minPeople,
    @Default(1) int maxPeople,
  }) = _PersonTypeInfo;

  factory PersonTypeInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonTypeInfoFromJson(json);
}
