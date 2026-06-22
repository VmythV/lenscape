// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryContext {

 String get styleId; String get personType; String get sceneId;
/// Create a copy of HistoryContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryContextCopyWith<HistoryContext> get copyWith => _$HistoryContextCopyWithImpl<HistoryContext>(this as HistoryContext, _$identity);

  /// Serializes this HistoryContext to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryContext&&(identical(other.styleId, styleId) || other.styleId == styleId)&&(identical(other.personType, personType) || other.personType == personType)&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,styleId,personType,sceneId);

@override
String toString() {
  return 'HistoryContext(styleId: $styleId, personType: $personType, sceneId: $sceneId)';
}


}

/// @nodoc
abstract mixin class $HistoryContextCopyWith<$Res>  {
  factory $HistoryContextCopyWith(HistoryContext value, $Res Function(HistoryContext) _then) = _$HistoryContextCopyWithImpl;
@useResult
$Res call({
 String styleId, String personType, String sceneId
});




}
/// @nodoc
class _$HistoryContextCopyWithImpl<$Res>
    implements $HistoryContextCopyWith<$Res> {
  _$HistoryContextCopyWithImpl(this._self, this._then);

  final HistoryContext _self;
  final $Res Function(HistoryContext) _then;

/// Create a copy of HistoryContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? styleId = null,Object? personType = null,Object? sceneId = null,}) {
  return _then(_self.copyWith(
styleId: null == styleId ? _self.styleId : styleId // ignore: cast_nullable_to_non_nullable
as String,personType: null == personType ? _self.personType : personType // ignore: cast_nullable_to_non_nullable
as String,sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryContext].
extension HistoryContextPatterns on HistoryContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryContext value)  $default,){
final _that = this;
switch (_that) {
case _HistoryContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryContext value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String styleId,  String personType,  String sceneId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryContext() when $default != null:
return $default(_that.styleId,_that.personType,_that.sceneId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String styleId,  String personType,  String sceneId)  $default,) {final _that = this;
switch (_that) {
case _HistoryContext():
return $default(_that.styleId,_that.personType,_that.sceneId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String styleId,  String personType,  String sceneId)?  $default,) {final _that = this;
switch (_that) {
case _HistoryContext() when $default != null:
return $default(_that.styleId,_that.personType,_that.sceneId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryContext implements HistoryContext {
  const _HistoryContext({required this.styleId, required this.personType, required this.sceneId});
  factory _HistoryContext.fromJson(Map<String, dynamic> json) => _$HistoryContextFromJson(json);

@override final  String styleId;
@override final  String personType;
@override final  String sceneId;

/// Create a copy of HistoryContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryContextCopyWith<_HistoryContext> get copyWith => __$HistoryContextCopyWithImpl<_HistoryContext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryContext&&(identical(other.styleId, styleId) || other.styleId == styleId)&&(identical(other.personType, personType) || other.personType == personType)&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,styleId,personType,sceneId);

@override
String toString() {
  return 'HistoryContext(styleId: $styleId, personType: $personType, sceneId: $sceneId)';
}


}

/// @nodoc
abstract mixin class _$HistoryContextCopyWith<$Res> implements $HistoryContextCopyWith<$Res> {
  factory _$HistoryContextCopyWith(_HistoryContext value, $Res Function(_HistoryContext) _then) = __$HistoryContextCopyWithImpl;
@override @useResult
$Res call({
 String styleId, String personType, String sceneId
});




}
/// @nodoc
class __$HistoryContextCopyWithImpl<$Res>
    implements _$HistoryContextCopyWith<$Res> {
  __$HistoryContextCopyWithImpl(this._self, this._then);

  final _HistoryContext _self;
  final $Res Function(_HistoryContext) _then;

/// Create a copy of HistoryContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? styleId = null,Object? personType = null,Object? sceneId = null,}) {
  return _then(_HistoryContext(
styleId: null == styleId ? _self.styleId : styleId // ignore: cast_nullable_to_non_nullable
as String,personType: null == personType ? _self.personType : personType // ignore: cast_nullable_to_non_nullable
as String,sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HistoryEntry {

 String get poseId; HistoryContext get context; int get viewedAt;
/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryEntryCopyWith<HistoryEntry> get copyWith => _$HistoryEntryCopyWithImpl<HistoryEntry>(this as HistoryEntry, _$identity);

  /// Serializes this HistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryEntry&&(identical(other.poseId, poseId) || other.poseId == poseId)&&(identical(other.context, context) || other.context == context)&&(identical(other.viewedAt, viewedAt) || other.viewedAt == viewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poseId,context,viewedAt);

@override
String toString() {
  return 'HistoryEntry(poseId: $poseId, context: $context, viewedAt: $viewedAt)';
}


}

/// @nodoc
abstract mixin class $HistoryEntryCopyWith<$Res>  {
  factory $HistoryEntryCopyWith(HistoryEntry value, $Res Function(HistoryEntry) _then) = _$HistoryEntryCopyWithImpl;
@useResult
$Res call({
 String poseId, HistoryContext context, int viewedAt
});


$HistoryContextCopyWith<$Res> get context;

}
/// @nodoc
class _$HistoryEntryCopyWithImpl<$Res>
    implements $HistoryEntryCopyWith<$Res> {
  _$HistoryEntryCopyWithImpl(this._self, this._then);

  final HistoryEntry _self;
  final $Res Function(HistoryEntry) _then;

/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? poseId = null,Object? context = null,Object? viewedAt = null,}) {
  return _then(_self.copyWith(
poseId: null == poseId ? _self.poseId : poseId // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as HistoryContext,viewedAt: null == viewedAt ? _self.viewedAt : viewedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryContextCopyWith<$Res> get context {
  
  return $HistoryContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}


/// Adds pattern-matching-related methods to [HistoryEntry].
extension HistoryEntryPatterns on HistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _HistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String poseId,  HistoryContext context,  int viewedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
return $default(_that.poseId,_that.context,_that.viewedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String poseId,  HistoryContext context,  int viewedAt)  $default,) {final _that = this;
switch (_that) {
case _HistoryEntry():
return $default(_that.poseId,_that.context,_that.viewedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String poseId,  HistoryContext context,  int viewedAt)?  $default,) {final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
return $default(_that.poseId,_that.context,_that.viewedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryEntry implements HistoryEntry {
  const _HistoryEntry({required this.poseId, required this.context, required this.viewedAt});
  factory _HistoryEntry.fromJson(Map<String, dynamic> json) => _$HistoryEntryFromJson(json);

@override final  String poseId;
@override final  HistoryContext context;
@override final  int viewedAt;

/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryEntryCopyWith<_HistoryEntry> get copyWith => __$HistoryEntryCopyWithImpl<_HistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryEntry&&(identical(other.poseId, poseId) || other.poseId == poseId)&&(identical(other.context, context) || other.context == context)&&(identical(other.viewedAt, viewedAt) || other.viewedAt == viewedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,poseId,context,viewedAt);

@override
String toString() {
  return 'HistoryEntry(poseId: $poseId, context: $context, viewedAt: $viewedAt)';
}


}

/// @nodoc
abstract mixin class _$HistoryEntryCopyWith<$Res> implements $HistoryEntryCopyWith<$Res> {
  factory _$HistoryEntryCopyWith(_HistoryEntry value, $Res Function(_HistoryEntry) _then) = __$HistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String poseId, HistoryContext context, int viewedAt
});


@override $HistoryContextCopyWith<$Res> get context;

}
/// @nodoc
class __$HistoryEntryCopyWithImpl<$Res>
    implements _$HistoryEntryCopyWith<$Res> {
  __$HistoryEntryCopyWithImpl(this._self, this._then);

  final _HistoryEntry _self;
  final $Res Function(_HistoryEntry) _then;

/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? poseId = null,Object? context = null,Object? viewedAt = null,}) {
  return _then(_HistoryEntry(
poseId: null == poseId ? _self.poseId : poseId // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as HistoryContext,viewedAt: null == viewedAt ? _self.viewedAt : viewedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoryContextCopyWith<$Res> get context {
  
  return $HistoryContextCopyWith<$Res>(_self.context, (value) {
    return _then(_self.copyWith(context: value));
  });
}
}

// dart format on
