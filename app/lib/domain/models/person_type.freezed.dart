// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonTypeInfo {

 String get personType; String get personName; String get direction; int get minPeople; int get maxPeople;
/// Create a copy of PersonTypeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonTypeInfoCopyWith<PersonTypeInfo> get copyWith => _$PersonTypeInfoCopyWithImpl<PersonTypeInfo>(this as PersonTypeInfo, _$identity);

  /// Serializes this PersonTypeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonTypeInfo&&(identical(other.personType, personType) || other.personType == personType)&&(identical(other.personName, personName) || other.personName == personName)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.minPeople, minPeople) || other.minPeople == minPeople)&&(identical(other.maxPeople, maxPeople) || other.maxPeople == maxPeople));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personType,personName,direction,minPeople,maxPeople);

@override
String toString() {
  return 'PersonTypeInfo(personType: $personType, personName: $personName, direction: $direction, minPeople: $minPeople, maxPeople: $maxPeople)';
}


}

/// @nodoc
abstract mixin class $PersonTypeInfoCopyWith<$Res>  {
  factory $PersonTypeInfoCopyWith(PersonTypeInfo value, $Res Function(PersonTypeInfo) _then) = _$PersonTypeInfoCopyWithImpl;
@useResult
$Res call({
 String personType, String personName, String direction, int minPeople, int maxPeople
});




}
/// @nodoc
class _$PersonTypeInfoCopyWithImpl<$Res>
    implements $PersonTypeInfoCopyWith<$Res> {
  _$PersonTypeInfoCopyWithImpl(this._self, this._then);

  final PersonTypeInfo _self;
  final $Res Function(PersonTypeInfo) _then;

/// Create a copy of PersonTypeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personType = null,Object? personName = null,Object? direction = null,Object? minPeople = null,Object? maxPeople = null,}) {
  return _then(_self.copyWith(
personType: null == personType ? _self.personType : personType // ignore: cast_nullable_to_non_nullable
as String,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,minPeople: null == minPeople ? _self.minPeople : minPeople // ignore: cast_nullable_to_non_nullable
as int,maxPeople: null == maxPeople ? _self.maxPeople : maxPeople // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonTypeInfo].
extension PersonTypeInfoPatterns on PersonTypeInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonTypeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonTypeInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonTypeInfo value)  $default,){
final _that = this;
switch (_that) {
case _PersonTypeInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonTypeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PersonTypeInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String personType,  String personName,  String direction,  int minPeople,  int maxPeople)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonTypeInfo() when $default != null:
return $default(_that.personType,_that.personName,_that.direction,_that.minPeople,_that.maxPeople);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String personType,  String personName,  String direction,  int minPeople,  int maxPeople)  $default,) {final _that = this;
switch (_that) {
case _PersonTypeInfo():
return $default(_that.personType,_that.personName,_that.direction,_that.minPeople,_that.maxPeople);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String personType,  String personName,  String direction,  int minPeople,  int maxPeople)?  $default,) {final _that = this;
switch (_that) {
case _PersonTypeInfo() when $default != null:
return $default(_that.personType,_that.personName,_that.direction,_that.minPeople,_that.maxPeople);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonTypeInfo implements PersonTypeInfo {
  const _PersonTypeInfo({required this.personType, required this.personName, required this.direction, this.minPeople = 1, this.maxPeople = 1});
  factory _PersonTypeInfo.fromJson(Map<String, dynamic> json) => _$PersonTypeInfoFromJson(json);

@override final  String personType;
@override final  String personName;
@override final  String direction;
@override@JsonKey() final  int minPeople;
@override@JsonKey() final  int maxPeople;

/// Create a copy of PersonTypeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonTypeInfoCopyWith<_PersonTypeInfo> get copyWith => __$PersonTypeInfoCopyWithImpl<_PersonTypeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonTypeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonTypeInfo&&(identical(other.personType, personType) || other.personType == personType)&&(identical(other.personName, personName) || other.personName == personName)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.minPeople, minPeople) || other.minPeople == minPeople)&&(identical(other.maxPeople, maxPeople) || other.maxPeople == maxPeople));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personType,personName,direction,minPeople,maxPeople);

@override
String toString() {
  return 'PersonTypeInfo(personType: $personType, personName: $personName, direction: $direction, minPeople: $minPeople, maxPeople: $maxPeople)';
}


}

/// @nodoc
abstract mixin class _$PersonTypeInfoCopyWith<$Res> implements $PersonTypeInfoCopyWith<$Res> {
  factory _$PersonTypeInfoCopyWith(_PersonTypeInfo value, $Res Function(_PersonTypeInfo) _then) = __$PersonTypeInfoCopyWithImpl;
@override @useResult
$Res call({
 String personType, String personName, String direction, int minPeople, int maxPeople
});




}
/// @nodoc
class __$PersonTypeInfoCopyWithImpl<$Res>
    implements _$PersonTypeInfoCopyWith<$Res> {
  __$PersonTypeInfoCopyWithImpl(this._self, this._then);

  final _PersonTypeInfo _self;
  final $Res Function(_PersonTypeInfo) _then;

/// Create a copy of PersonTypeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personType = null,Object? personName = null,Object? direction = null,Object? minPeople = null,Object? maxPeople = null,}) {
  return _then(_PersonTypeInfo(
personType: null == personType ? _self.personType : personType // ignore: cast_nullable_to_non_nullable
as String,personName: null == personName ? _self.personName : personName // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,minPeople: null == minPeople ? _self.minPeople : minPeople // ignore: cast_nullable_to_non_nullable
as int,maxPeople: null == maxPeople ? _self.maxPeople : maxPeople // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
