// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scene.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Scene {

 String get sceneId; String get sceneName; String get sceneDescription; List<String> get exampleImages; List<String> get suitableStyles; List<String> get unsuitableStyles; Orientation get recommendedOrientation; Framing get recommendedFraming; List<String> get recommendedCamera; List<String> get foregroundHints; List<String> get backgroundHints; bool get keepBackground;
/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneCopyWith<Scene> get copyWith => _$SceneCopyWithImpl<Scene>(this as Scene, _$identity);

  /// Serializes this Scene to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Scene&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.sceneName, sceneName) || other.sceneName == sceneName)&&(identical(other.sceneDescription, sceneDescription) || other.sceneDescription == sceneDescription)&&const DeepCollectionEquality().equals(other.exampleImages, exampleImages)&&const DeepCollectionEquality().equals(other.suitableStyles, suitableStyles)&&const DeepCollectionEquality().equals(other.unsuitableStyles, unsuitableStyles)&&(identical(other.recommendedOrientation, recommendedOrientation) || other.recommendedOrientation == recommendedOrientation)&&(identical(other.recommendedFraming, recommendedFraming) || other.recommendedFraming == recommendedFraming)&&const DeepCollectionEquality().equals(other.recommendedCamera, recommendedCamera)&&const DeepCollectionEquality().equals(other.foregroundHints, foregroundHints)&&const DeepCollectionEquality().equals(other.backgroundHints, backgroundHints)&&(identical(other.keepBackground, keepBackground) || other.keepBackground == keepBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sceneId,sceneName,sceneDescription,const DeepCollectionEquality().hash(exampleImages),const DeepCollectionEquality().hash(suitableStyles),const DeepCollectionEquality().hash(unsuitableStyles),recommendedOrientation,recommendedFraming,const DeepCollectionEquality().hash(recommendedCamera),const DeepCollectionEquality().hash(foregroundHints),const DeepCollectionEquality().hash(backgroundHints),keepBackground);

@override
String toString() {
  return 'Scene(sceneId: $sceneId, sceneName: $sceneName, sceneDescription: $sceneDescription, exampleImages: $exampleImages, suitableStyles: $suitableStyles, unsuitableStyles: $unsuitableStyles, recommendedOrientation: $recommendedOrientation, recommendedFraming: $recommendedFraming, recommendedCamera: $recommendedCamera, foregroundHints: $foregroundHints, backgroundHints: $backgroundHints, keepBackground: $keepBackground)';
}


}

/// @nodoc
abstract mixin class $SceneCopyWith<$Res>  {
  factory $SceneCopyWith(Scene value, $Res Function(Scene) _then) = _$SceneCopyWithImpl;
@useResult
$Res call({
 String sceneId, String sceneName, String sceneDescription, List<String> exampleImages, List<String> suitableStyles, List<String> unsuitableStyles, Orientation recommendedOrientation, Framing recommendedFraming, List<String> recommendedCamera, List<String> foregroundHints, List<String> backgroundHints, bool keepBackground
});




}
/// @nodoc
class _$SceneCopyWithImpl<$Res>
    implements $SceneCopyWith<$Res> {
  _$SceneCopyWithImpl(this._self, this._then);

  final Scene _self;
  final $Res Function(Scene) _then;

/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sceneId = null,Object? sceneName = null,Object? sceneDescription = null,Object? exampleImages = null,Object? suitableStyles = null,Object? unsuitableStyles = null,Object? recommendedOrientation = null,Object? recommendedFraming = null,Object? recommendedCamera = null,Object? foregroundHints = null,Object? backgroundHints = null,Object? keepBackground = null,}) {
  return _then(_self.copyWith(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,sceneName: null == sceneName ? _self.sceneName : sceneName // ignore: cast_nullable_to_non_nullable
as String,sceneDescription: null == sceneDescription ? _self.sceneDescription : sceneDescription // ignore: cast_nullable_to_non_nullable
as String,exampleImages: null == exampleImages ? _self.exampleImages : exampleImages // ignore: cast_nullable_to_non_nullable
as List<String>,suitableStyles: null == suitableStyles ? _self.suitableStyles : suitableStyles // ignore: cast_nullable_to_non_nullable
as List<String>,unsuitableStyles: null == unsuitableStyles ? _self.unsuitableStyles : unsuitableStyles // ignore: cast_nullable_to_non_nullable
as List<String>,recommendedOrientation: null == recommendedOrientation ? _self.recommendedOrientation : recommendedOrientation // ignore: cast_nullable_to_non_nullable
as Orientation,recommendedFraming: null == recommendedFraming ? _self.recommendedFraming : recommendedFraming // ignore: cast_nullable_to_non_nullable
as Framing,recommendedCamera: null == recommendedCamera ? _self.recommendedCamera : recommendedCamera // ignore: cast_nullable_to_non_nullable
as List<String>,foregroundHints: null == foregroundHints ? _self.foregroundHints : foregroundHints // ignore: cast_nullable_to_non_nullable
as List<String>,backgroundHints: null == backgroundHints ? _self.backgroundHints : backgroundHints // ignore: cast_nullable_to_non_nullable
as List<String>,keepBackground: null == keepBackground ? _self.keepBackground : keepBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Scene].
extension ScenePatterns on Scene {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Scene value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Scene() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Scene value)  $default,){
final _that = this;
switch (_that) {
case _Scene():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Scene value)?  $default,){
final _that = this;
switch (_that) {
case _Scene() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sceneId,  String sceneName,  String sceneDescription,  List<String> exampleImages,  List<String> suitableStyles,  List<String> unsuitableStyles,  Orientation recommendedOrientation,  Framing recommendedFraming,  List<String> recommendedCamera,  List<String> foregroundHints,  List<String> backgroundHints,  bool keepBackground)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Scene() when $default != null:
return $default(_that.sceneId,_that.sceneName,_that.sceneDescription,_that.exampleImages,_that.suitableStyles,_that.unsuitableStyles,_that.recommendedOrientation,_that.recommendedFraming,_that.recommendedCamera,_that.foregroundHints,_that.backgroundHints,_that.keepBackground);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sceneId,  String sceneName,  String sceneDescription,  List<String> exampleImages,  List<String> suitableStyles,  List<String> unsuitableStyles,  Orientation recommendedOrientation,  Framing recommendedFraming,  List<String> recommendedCamera,  List<String> foregroundHints,  List<String> backgroundHints,  bool keepBackground)  $default,) {final _that = this;
switch (_that) {
case _Scene():
return $default(_that.sceneId,_that.sceneName,_that.sceneDescription,_that.exampleImages,_that.suitableStyles,_that.unsuitableStyles,_that.recommendedOrientation,_that.recommendedFraming,_that.recommendedCamera,_that.foregroundHints,_that.backgroundHints,_that.keepBackground);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sceneId,  String sceneName,  String sceneDescription,  List<String> exampleImages,  List<String> suitableStyles,  List<String> unsuitableStyles,  Orientation recommendedOrientation,  Framing recommendedFraming,  List<String> recommendedCamera,  List<String> foregroundHints,  List<String> backgroundHints,  bool keepBackground)?  $default,) {final _that = this;
switch (_that) {
case _Scene() when $default != null:
return $default(_that.sceneId,_that.sceneName,_that.sceneDescription,_that.exampleImages,_that.suitableStyles,_that.unsuitableStyles,_that.recommendedOrientation,_that.recommendedFraming,_that.recommendedCamera,_that.foregroundHints,_that.backgroundHints,_that.keepBackground);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Scene implements Scene {
  const _Scene({required this.sceneId, required this.sceneName, required this.sceneDescription, final  List<String> exampleImages = const [], final  List<String> suitableStyles = const [], final  List<String> unsuitableStyles = const [], required this.recommendedOrientation, required this.recommendedFraming, final  List<String> recommendedCamera = const [], final  List<String> foregroundHints = const [], final  List<String> backgroundHints = const [], this.keepBackground = true}): _exampleImages = exampleImages,_suitableStyles = suitableStyles,_unsuitableStyles = unsuitableStyles,_recommendedCamera = recommendedCamera,_foregroundHints = foregroundHints,_backgroundHints = backgroundHints;
  factory _Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);

@override final  String sceneId;
@override final  String sceneName;
@override final  String sceneDescription;
 final  List<String> _exampleImages;
@override@JsonKey() List<String> get exampleImages {
  if (_exampleImages is EqualUnmodifiableListView) return _exampleImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exampleImages);
}

 final  List<String> _suitableStyles;
@override@JsonKey() List<String> get suitableStyles {
  if (_suitableStyles is EqualUnmodifiableListView) return _suitableStyles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suitableStyles);
}

 final  List<String> _unsuitableStyles;
@override@JsonKey() List<String> get unsuitableStyles {
  if (_unsuitableStyles is EqualUnmodifiableListView) return _unsuitableStyles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unsuitableStyles);
}

@override final  Orientation recommendedOrientation;
@override final  Framing recommendedFraming;
 final  List<String> _recommendedCamera;
@override@JsonKey() List<String> get recommendedCamera {
  if (_recommendedCamera is EqualUnmodifiableListView) return _recommendedCamera;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recommendedCamera);
}

 final  List<String> _foregroundHints;
@override@JsonKey() List<String> get foregroundHints {
  if (_foregroundHints is EqualUnmodifiableListView) return _foregroundHints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_foregroundHints);
}

 final  List<String> _backgroundHints;
@override@JsonKey() List<String> get backgroundHints {
  if (_backgroundHints is EqualUnmodifiableListView) return _backgroundHints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backgroundHints);
}

@override@JsonKey() final  bool keepBackground;

/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneCopyWith<_Scene> get copyWith => __$SceneCopyWithImpl<_Scene>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Scene&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.sceneName, sceneName) || other.sceneName == sceneName)&&(identical(other.sceneDescription, sceneDescription) || other.sceneDescription == sceneDescription)&&const DeepCollectionEquality().equals(other._exampleImages, _exampleImages)&&const DeepCollectionEquality().equals(other._suitableStyles, _suitableStyles)&&const DeepCollectionEquality().equals(other._unsuitableStyles, _unsuitableStyles)&&(identical(other.recommendedOrientation, recommendedOrientation) || other.recommendedOrientation == recommendedOrientation)&&(identical(other.recommendedFraming, recommendedFraming) || other.recommendedFraming == recommendedFraming)&&const DeepCollectionEquality().equals(other._recommendedCamera, _recommendedCamera)&&const DeepCollectionEquality().equals(other._foregroundHints, _foregroundHints)&&const DeepCollectionEquality().equals(other._backgroundHints, _backgroundHints)&&(identical(other.keepBackground, keepBackground) || other.keepBackground == keepBackground));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sceneId,sceneName,sceneDescription,const DeepCollectionEquality().hash(_exampleImages),const DeepCollectionEquality().hash(_suitableStyles),const DeepCollectionEquality().hash(_unsuitableStyles),recommendedOrientation,recommendedFraming,const DeepCollectionEquality().hash(_recommendedCamera),const DeepCollectionEquality().hash(_foregroundHints),const DeepCollectionEquality().hash(_backgroundHints),keepBackground);

@override
String toString() {
  return 'Scene(sceneId: $sceneId, sceneName: $sceneName, sceneDescription: $sceneDescription, exampleImages: $exampleImages, suitableStyles: $suitableStyles, unsuitableStyles: $unsuitableStyles, recommendedOrientation: $recommendedOrientation, recommendedFraming: $recommendedFraming, recommendedCamera: $recommendedCamera, foregroundHints: $foregroundHints, backgroundHints: $backgroundHints, keepBackground: $keepBackground)';
}


}

/// @nodoc
abstract mixin class _$SceneCopyWith<$Res> implements $SceneCopyWith<$Res> {
  factory _$SceneCopyWith(_Scene value, $Res Function(_Scene) _then) = __$SceneCopyWithImpl;
@override @useResult
$Res call({
 String sceneId, String sceneName, String sceneDescription, List<String> exampleImages, List<String> suitableStyles, List<String> unsuitableStyles, Orientation recommendedOrientation, Framing recommendedFraming, List<String> recommendedCamera, List<String> foregroundHints, List<String> backgroundHints, bool keepBackground
});




}
/// @nodoc
class __$SceneCopyWithImpl<$Res>
    implements _$SceneCopyWith<$Res> {
  __$SceneCopyWithImpl(this._self, this._then);

  final _Scene _self;
  final $Res Function(_Scene) _then;

/// Create a copy of Scene
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sceneId = null,Object? sceneName = null,Object? sceneDescription = null,Object? exampleImages = null,Object? suitableStyles = null,Object? unsuitableStyles = null,Object? recommendedOrientation = null,Object? recommendedFraming = null,Object? recommendedCamera = null,Object? foregroundHints = null,Object? backgroundHints = null,Object? keepBackground = null,}) {
  return _then(_Scene(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as String,sceneName: null == sceneName ? _self.sceneName : sceneName // ignore: cast_nullable_to_non_nullable
as String,sceneDescription: null == sceneDescription ? _self.sceneDescription : sceneDescription // ignore: cast_nullable_to_non_nullable
as String,exampleImages: null == exampleImages ? _self._exampleImages : exampleImages // ignore: cast_nullable_to_non_nullable
as List<String>,suitableStyles: null == suitableStyles ? _self._suitableStyles : suitableStyles // ignore: cast_nullable_to_non_nullable
as List<String>,unsuitableStyles: null == unsuitableStyles ? _self._unsuitableStyles : unsuitableStyles // ignore: cast_nullable_to_non_nullable
as List<String>,recommendedOrientation: null == recommendedOrientation ? _self.recommendedOrientation : recommendedOrientation // ignore: cast_nullable_to_non_nullable
as Orientation,recommendedFraming: null == recommendedFraming ? _self.recommendedFraming : recommendedFraming // ignore: cast_nullable_to_non_nullable
as Framing,recommendedCamera: null == recommendedCamera ? _self._recommendedCamera : recommendedCamera // ignore: cast_nullable_to_non_nullable
as List<String>,foregroundHints: null == foregroundHints ? _self._foregroundHints : foregroundHints // ignore: cast_nullable_to_non_nullable
as List<String>,backgroundHints: null == backgroundHints ? _self._backgroundHints : backgroundHints // ignore: cast_nullable_to_non_nullable
as List<String>,keepBackground: null == keepBackground ? _self.keepBackground : keepBackground // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
