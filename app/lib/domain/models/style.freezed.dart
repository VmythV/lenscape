// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Style {

 String get styleId; String get styleName; String get styleDescription; List<String> get sampleImages; List<String> get suitableScenes; List<String> get suitablePersonTypes; Orientation get defaultOrientation; Framing get defaultFraming; List<String> get compositionRules; List<String> get cameraRules; int get sortWeight;
/// Create a copy of Style
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StyleCopyWith<Style> get copyWith => _$StyleCopyWithImpl<Style>(this as Style, _$identity);

  /// Serializes this Style to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Style&&(identical(other.styleId, styleId) || other.styleId == styleId)&&(identical(other.styleName, styleName) || other.styleName == styleName)&&(identical(other.styleDescription, styleDescription) || other.styleDescription == styleDescription)&&const DeepCollectionEquality().equals(other.sampleImages, sampleImages)&&const DeepCollectionEquality().equals(other.suitableScenes, suitableScenes)&&const DeepCollectionEquality().equals(other.suitablePersonTypes, suitablePersonTypes)&&(identical(other.defaultOrientation, defaultOrientation) || other.defaultOrientation == defaultOrientation)&&(identical(other.defaultFraming, defaultFraming) || other.defaultFraming == defaultFraming)&&const DeepCollectionEquality().equals(other.compositionRules, compositionRules)&&const DeepCollectionEquality().equals(other.cameraRules, cameraRules)&&(identical(other.sortWeight, sortWeight) || other.sortWeight == sortWeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,styleId,styleName,styleDescription,const DeepCollectionEquality().hash(sampleImages),const DeepCollectionEquality().hash(suitableScenes),const DeepCollectionEquality().hash(suitablePersonTypes),defaultOrientation,defaultFraming,const DeepCollectionEquality().hash(compositionRules),const DeepCollectionEquality().hash(cameraRules),sortWeight);

@override
String toString() {
  return 'Style(styleId: $styleId, styleName: $styleName, styleDescription: $styleDescription, sampleImages: $sampleImages, suitableScenes: $suitableScenes, suitablePersonTypes: $suitablePersonTypes, defaultOrientation: $defaultOrientation, defaultFraming: $defaultFraming, compositionRules: $compositionRules, cameraRules: $cameraRules, sortWeight: $sortWeight)';
}


}

/// @nodoc
abstract mixin class $StyleCopyWith<$Res>  {
  factory $StyleCopyWith(Style value, $Res Function(Style) _then) = _$StyleCopyWithImpl;
@useResult
$Res call({
 String styleId, String styleName, String styleDescription, List<String> sampleImages, List<String> suitableScenes, List<String> suitablePersonTypes, Orientation defaultOrientation, Framing defaultFraming, List<String> compositionRules, List<String> cameraRules, int sortWeight
});




}
/// @nodoc
class _$StyleCopyWithImpl<$Res>
    implements $StyleCopyWith<$Res> {
  _$StyleCopyWithImpl(this._self, this._then);

  final Style _self;
  final $Res Function(Style) _then;

/// Create a copy of Style
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? styleId = null,Object? styleName = null,Object? styleDescription = null,Object? sampleImages = null,Object? suitableScenes = null,Object? suitablePersonTypes = null,Object? defaultOrientation = null,Object? defaultFraming = null,Object? compositionRules = null,Object? cameraRules = null,Object? sortWeight = null,}) {
  return _then(_self.copyWith(
styleId: null == styleId ? _self.styleId : styleId // ignore: cast_nullable_to_non_nullable
as String,styleName: null == styleName ? _self.styleName : styleName // ignore: cast_nullable_to_non_nullable
as String,styleDescription: null == styleDescription ? _self.styleDescription : styleDescription // ignore: cast_nullable_to_non_nullable
as String,sampleImages: null == sampleImages ? _self.sampleImages : sampleImages // ignore: cast_nullable_to_non_nullable
as List<String>,suitableScenes: null == suitableScenes ? _self.suitableScenes : suitableScenes // ignore: cast_nullable_to_non_nullable
as List<String>,suitablePersonTypes: null == suitablePersonTypes ? _self.suitablePersonTypes : suitablePersonTypes // ignore: cast_nullable_to_non_nullable
as List<String>,defaultOrientation: null == defaultOrientation ? _self.defaultOrientation : defaultOrientation // ignore: cast_nullable_to_non_nullable
as Orientation,defaultFraming: null == defaultFraming ? _self.defaultFraming : defaultFraming // ignore: cast_nullable_to_non_nullable
as Framing,compositionRules: null == compositionRules ? _self.compositionRules : compositionRules // ignore: cast_nullable_to_non_nullable
as List<String>,cameraRules: null == cameraRules ? _self.cameraRules : cameraRules // ignore: cast_nullable_to_non_nullable
as List<String>,sortWeight: null == sortWeight ? _self.sortWeight : sortWeight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Style].
extension StylePatterns on Style {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Style value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Style() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Style value)  $default,){
final _that = this;
switch (_that) {
case _Style():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Style value)?  $default,){
final _that = this;
switch (_that) {
case _Style() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String styleId,  String styleName,  String styleDescription,  List<String> sampleImages,  List<String> suitableScenes,  List<String> suitablePersonTypes,  Orientation defaultOrientation,  Framing defaultFraming,  List<String> compositionRules,  List<String> cameraRules,  int sortWeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Style() when $default != null:
return $default(_that.styleId,_that.styleName,_that.styleDescription,_that.sampleImages,_that.suitableScenes,_that.suitablePersonTypes,_that.defaultOrientation,_that.defaultFraming,_that.compositionRules,_that.cameraRules,_that.sortWeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String styleId,  String styleName,  String styleDescription,  List<String> sampleImages,  List<String> suitableScenes,  List<String> suitablePersonTypes,  Orientation defaultOrientation,  Framing defaultFraming,  List<String> compositionRules,  List<String> cameraRules,  int sortWeight)  $default,) {final _that = this;
switch (_that) {
case _Style():
return $default(_that.styleId,_that.styleName,_that.styleDescription,_that.sampleImages,_that.suitableScenes,_that.suitablePersonTypes,_that.defaultOrientation,_that.defaultFraming,_that.compositionRules,_that.cameraRules,_that.sortWeight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String styleId,  String styleName,  String styleDescription,  List<String> sampleImages,  List<String> suitableScenes,  List<String> suitablePersonTypes,  Orientation defaultOrientation,  Framing defaultFraming,  List<String> compositionRules,  List<String> cameraRules,  int sortWeight)?  $default,) {final _that = this;
switch (_that) {
case _Style() when $default != null:
return $default(_that.styleId,_that.styleName,_that.styleDescription,_that.sampleImages,_that.suitableScenes,_that.suitablePersonTypes,_that.defaultOrientation,_that.defaultFraming,_that.compositionRules,_that.cameraRules,_that.sortWeight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Style implements Style {
  const _Style({required this.styleId, required this.styleName, required this.styleDescription, final  List<String> sampleImages = const [], final  List<String> suitableScenes = const [], final  List<String> suitablePersonTypes = const [], required this.defaultOrientation, required this.defaultFraming, final  List<String> compositionRules = const [], final  List<String> cameraRules = const [], this.sortWeight = 0}): _sampleImages = sampleImages,_suitableScenes = suitableScenes,_suitablePersonTypes = suitablePersonTypes,_compositionRules = compositionRules,_cameraRules = cameraRules;
  factory _Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);

@override final  String styleId;
@override final  String styleName;
@override final  String styleDescription;
 final  List<String> _sampleImages;
@override@JsonKey() List<String> get sampleImages {
  if (_sampleImages is EqualUnmodifiableListView) return _sampleImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sampleImages);
}

 final  List<String> _suitableScenes;
@override@JsonKey() List<String> get suitableScenes {
  if (_suitableScenes is EqualUnmodifiableListView) return _suitableScenes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suitableScenes);
}

 final  List<String> _suitablePersonTypes;
@override@JsonKey() List<String> get suitablePersonTypes {
  if (_suitablePersonTypes is EqualUnmodifiableListView) return _suitablePersonTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suitablePersonTypes);
}

@override final  Orientation defaultOrientation;
@override final  Framing defaultFraming;
 final  List<String> _compositionRules;
@override@JsonKey() List<String> get compositionRules {
  if (_compositionRules is EqualUnmodifiableListView) return _compositionRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_compositionRules);
}

 final  List<String> _cameraRules;
@override@JsonKey() List<String> get cameraRules {
  if (_cameraRules is EqualUnmodifiableListView) return _cameraRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cameraRules);
}

@override@JsonKey() final  int sortWeight;

/// Create a copy of Style
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StyleCopyWith<_Style> get copyWith => __$StyleCopyWithImpl<_Style>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StyleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Style&&(identical(other.styleId, styleId) || other.styleId == styleId)&&(identical(other.styleName, styleName) || other.styleName == styleName)&&(identical(other.styleDescription, styleDescription) || other.styleDescription == styleDescription)&&const DeepCollectionEquality().equals(other._sampleImages, _sampleImages)&&const DeepCollectionEquality().equals(other._suitableScenes, _suitableScenes)&&const DeepCollectionEquality().equals(other._suitablePersonTypes, _suitablePersonTypes)&&(identical(other.defaultOrientation, defaultOrientation) || other.defaultOrientation == defaultOrientation)&&(identical(other.defaultFraming, defaultFraming) || other.defaultFraming == defaultFraming)&&const DeepCollectionEquality().equals(other._compositionRules, _compositionRules)&&const DeepCollectionEquality().equals(other._cameraRules, _cameraRules)&&(identical(other.sortWeight, sortWeight) || other.sortWeight == sortWeight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,styleId,styleName,styleDescription,const DeepCollectionEquality().hash(_sampleImages),const DeepCollectionEquality().hash(_suitableScenes),const DeepCollectionEquality().hash(_suitablePersonTypes),defaultOrientation,defaultFraming,const DeepCollectionEquality().hash(_compositionRules),const DeepCollectionEquality().hash(_cameraRules),sortWeight);

@override
String toString() {
  return 'Style(styleId: $styleId, styleName: $styleName, styleDescription: $styleDescription, sampleImages: $sampleImages, suitableScenes: $suitableScenes, suitablePersonTypes: $suitablePersonTypes, defaultOrientation: $defaultOrientation, defaultFraming: $defaultFraming, compositionRules: $compositionRules, cameraRules: $cameraRules, sortWeight: $sortWeight)';
}


}

/// @nodoc
abstract mixin class _$StyleCopyWith<$Res> implements $StyleCopyWith<$Res> {
  factory _$StyleCopyWith(_Style value, $Res Function(_Style) _then) = __$StyleCopyWithImpl;
@override @useResult
$Res call({
 String styleId, String styleName, String styleDescription, List<String> sampleImages, List<String> suitableScenes, List<String> suitablePersonTypes, Orientation defaultOrientation, Framing defaultFraming, List<String> compositionRules, List<String> cameraRules, int sortWeight
});




}
/// @nodoc
class __$StyleCopyWithImpl<$Res>
    implements _$StyleCopyWith<$Res> {
  __$StyleCopyWithImpl(this._self, this._then);

  final _Style _self;
  final $Res Function(_Style) _then;

/// Create a copy of Style
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? styleId = null,Object? styleName = null,Object? styleDescription = null,Object? sampleImages = null,Object? suitableScenes = null,Object? suitablePersonTypes = null,Object? defaultOrientation = null,Object? defaultFraming = null,Object? compositionRules = null,Object? cameraRules = null,Object? sortWeight = null,}) {
  return _then(_Style(
styleId: null == styleId ? _self.styleId : styleId // ignore: cast_nullable_to_non_nullable
as String,styleName: null == styleName ? _self.styleName : styleName // ignore: cast_nullable_to_non_nullable
as String,styleDescription: null == styleDescription ? _self.styleDescription : styleDescription // ignore: cast_nullable_to_non_nullable
as String,sampleImages: null == sampleImages ? _self._sampleImages : sampleImages // ignore: cast_nullable_to_non_nullable
as List<String>,suitableScenes: null == suitableScenes ? _self._suitableScenes : suitableScenes // ignore: cast_nullable_to_non_nullable
as List<String>,suitablePersonTypes: null == suitablePersonTypes ? _self._suitablePersonTypes : suitablePersonTypes // ignore: cast_nullable_to_non_nullable
as List<String>,defaultOrientation: null == defaultOrientation ? _self.defaultOrientation : defaultOrientation // ignore: cast_nullable_to_non_nullable
as Orientation,defaultFraming: null == defaultFraming ? _self.defaultFraming : defaultFraming // ignore: cast_nullable_to_non_nullable
as Framing,compositionRules: null == compositionRules ? _self._compositionRules : compositionRules // ignore: cast_nullable_to_non_nullable
as List<String>,cameraRules: null == cameraRules ? _self._cameraRules : cameraRules // ignore: cast_nullable_to_non_nullable
as List<String>,sortWeight: null == sortWeight ? _self.sortWeight : sortWeight // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
