// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pose_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PoseTemplate {

 String get poseId; String get poseName; List<String> get styleIds; List<String> get personTypes; List<String> get sceneTypes; String get illustrationImage; String get poseOutlineImage; List<Orientation> get supportsOrientation; List<Framing> get supportsFraming; String get bodyInstruction; String get handInstruction; String get faceInstruction; String get eyeInstruction; String get positionInstruction; String get cameraPositionInstruction; CameraHeight get cameraHeight; CameraAngle get cameraAngle; CameraDirection get cameraDirection; CameraDistance get cameraDistance; SubjectPosition get subjectPosition; SubjectRatio get subjectRatio; String get compositionInstruction; List<String> get tips; int get qualityScore; bool get isReviewed;
/// Create a copy of PoseTemplate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PoseTemplateCopyWith<PoseTemplate> get copyWith => _$PoseTemplateCopyWithImpl<PoseTemplate>(this as PoseTemplate, _$identity);

  /// Serializes this PoseTemplate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PoseTemplate&&(identical(other.poseId, poseId) || other.poseId == poseId)&&(identical(other.poseName, poseName) || other.poseName == poseName)&&const DeepCollectionEquality().equals(other.styleIds, styleIds)&&const DeepCollectionEquality().equals(other.personTypes, personTypes)&&const DeepCollectionEquality().equals(other.sceneTypes, sceneTypes)&&(identical(other.illustrationImage, illustrationImage) || other.illustrationImage == illustrationImage)&&(identical(other.poseOutlineImage, poseOutlineImage) || other.poseOutlineImage == poseOutlineImage)&&const DeepCollectionEquality().equals(other.supportsOrientation, supportsOrientation)&&const DeepCollectionEquality().equals(other.supportsFraming, supportsFraming)&&(identical(other.bodyInstruction, bodyInstruction) || other.bodyInstruction == bodyInstruction)&&(identical(other.handInstruction, handInstruction) || other.handInstruction == handInstruction)&&(identical(other.faceInstruction, faceInstruction) || other.faceInstruction == faceInstruction)&&(identical(other.eyeInstruction, eyeInstruction) || other.eyeInstruction == eyeInstruction)&&(identical(other.positionInstruction, positionInstruction) || other.positionInstruction == positionInstruction)&&(identical(other.cameraPositionInstruction, cameraPositionInstruction) || other.cameraPositionInstruction == cameraPositionInstruction)&&(identical(other.cameraHeight, cameraHeight) || other.cameraHeight == cameraHeight)&&(identical(other.cameraAngle, cameraAngle) || other.cameraAngle == cameraAngle)&&(identical(other.cameraDirection, cameraDirection) || other.cameraDirection == cameraDirection)&&(identical(other.cameraDistance, cameraDistance) || other.cameraDistance == cameraDistance)&&(identical(other.subjectPosition, subjectPosition) || other.subjectPosition == subjectPosition)&&(identical(other.subjectRatio, subjectRatio) || other.subjectRatio == subjectRatio)&&(identical(other.compositionInstruction, compositionInstruction) || other.compositionInstruction == compositionInstruction)&&const DeepCollectionEquality().equals(other.tips, tips)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&(identical(other.isReviewed, isReviewed) || other.isReviewed == isReviewed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,poseId,poseName,const DeepCollectionEquality().hash(styleIds),const DeepCollectionEquality().hash(personTypes),const DeepCollectionEquality().hash(sceneTypes),illustrationImage,poseOutlineImage,const DeepCollectionEquality().hash(supportsOrientation),const DeepCollectionEquality().hash(supportsFraming),bodyInstruction,handInstruction,faceInstruction,eyeInstruction,positionInstruction,cameraPositionInstruction,cameraHeight,cameraAngle,cameraDirection,cameraDistance,subjectPosition,subjectRatio,compositionInstruction,const DeepCollectionEquality().hash(tips),qualityScore,isReviewed]);

@override
String toString() {
  return 'PoseTemplate(poseId: $poseId, poseName: $poseName, styleIds: $styleIds, personTypes: $personTypes, sceneTypes: $sceneTypes, illustrationImage: $illustrationImage, poseOutlineImage: $poseOutlineImage, supportsOrientation: $supportsOrientation, supportsFraming: $supportsFraming, bodyInstruction: $bodyInstruction, handInstruction: $handInstruction, faceInstruction: $faceInstruction, eyeInstruction: $eyeInstruction, positionInstruction: $positionInstruction, cameraPositionInstruction: $cameraPositionInstruction, cameraHeight: $cameraHeight, cameraAngle: $cameraAngle, cameraDirection: $cameraDirection, cameraDistance: $cameraDistance, subjectPosition: $subjectPosition, subjectRatio: $subjectRatio, compositionInstruction: $compositionInstruction, tips: $tips, qualityScore: $qualityScore, isReviewed: $isReviewed)';
}


}

/// @nodoc
abstract mixin class $PoseTemplateCopyWith<$Res>  {
  factory $PoseTemplateCopyWith(PoseTemplate value, $Res Function(PoseTemplate) _then) = _$PoseTemplateCopyWithImpl;
@useResult
$Res call({
 String poseId, String poseName, List<String> styleIds, List<String> personTypes, List<String> sceneTypes, String illustrationImage, String poseOutlineImage, List<Orientation> supportsOrientation, List<Framing> supportsFraming, String bodyInstruction, String handInstruction, String faceInstruction, String eyeInstruction, String positionInstruction, String cameraPositionInstruction, CameraHeight cameraHeight, CameraAngle cameraAngle, CameraDirection cameraDirection, CameraDistance cameraDistance, SubjectPosition subjectPosition, SubjectRatio subjectRatio, String compositionInstruction, List<String> tips, int qualityScore, bool isReviewed
});




}
/// @nodoc
class _$PoseTemplateCopyWithImpl<$Res>
    implements $PoseTemplateCopyWith<$Res> {
  _$PoseTemplateCopyWithImpl(this._self, this._then);

  final PoseTemplate _self;
  final $Res Function(PoseTemplate) _then;

/// Create a copy of PoseTemplate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? poseId = null,Object? poseName = null,Object? styleIds = null,Object? personTypes = null,Object? sceneTypes = null,Object? illustrationImage = null,Object? poseOutlineImage = null,Object? supportsOrientation = null,Object? supportsFraming = null,Object? bodyInstruction = null,Object? handInstruction = null,Object? faceInstruction = null,Object? eyeInstruction = null,Object? positionInstruction = null,Object? cameraPositionInstruction = null,Object? cameraHeight = null,Object? cameraAngle = null,Object? cameraDirection = null,Object? cameraDistance = null,Object? subjectPosition = null,Object? subjectRatio = null,Object? compositionInstruction = null,Object? tips = null,Object? qualityScore = null,Object? isReviewed = null,}) {
  return _then(_self.copyWith(
poseId: null == poseId ? _self.poseId : poseId // ignore: cast_nullable_to_non_nullable
as String,poseName: null == poseName ? _self.poseName : poseName // ignore: cast_nullable_to_non_nullable
as String,styleIds: null == styleIds ? _self.styleIds : styleIds // ignore: cast_nullable_to_non_nullable
as List<String>,personTypes: null == personTypes ? _self.personTypes : personTypes // ignore: cast_nullable_to_non_nullable
as List<String>,sceneTypes: null == sceneTypes ? _self.sceneTypes : sceneTypes // ignore: cast_nullable_to_non_nullable
as List<String>,illustrationImage: null == illustrationImage ? _self.illustrationImage : illustrationImage // ignore: cast_nullable_to_non_nullable
as String,poseOutlineImage: null == poseOutlineImage ? _self.poseOutlineImage : poseOutlineImage // ignore: cast_nullable_to_non_nullable
as String,supportsOrientation: null == supportsOrientation ? _self.supportsOrientation : supportsOrientation // ignore: cast_nullable_to_non_nullable
as List<Orientation>,supportsFraming: null == supportsFraming ? _self.supportsFraming : supportsFraming // ignore: cast_nullable_to_non_nullable
as List<Framing>,bodyInstruction: null == bodyInstruction ? _self.bodyInstruction : bodyInstruction // ignore: cast_nullable_to_non_nullable
as String,handInstruction: null == handInstruction ? _self.handInstruction : handInstruction // ignore: cast_nullable_to_non_nullable
as String,faceInstruction: null == faceInstruction ? _self.faceInstruction : faceInstruction // ignore: cast_nullable_to_non_nullable
as String,eyeInstruction: null == eyeInstruction ? _self.eyeInstruction : eyeInstruction // ignore: cast_nullable_to_non_nullable
as String,positionInstruction: null == positionInstruction ? _self.positionInstruction : positionInstruction // ignore: cast_nullable_to_non_nullable
as String,cameraPositionInstruction: null == cameraPositionInstruction ? _self.cameraPositionInstruction : cameraPositionInstruction // ignore: cast_nullable_to_non_nullable
as String,cameraHeight: null == cameraHeight ? _self.cameraHeight : cameraHeight // ignore: cast_nullable_to_non_nullable
as CameraHeight,cameraAngle: null == cameraAngle ? _self.cameraAngle : cameraAngle // ignore: cast_nullable_to_non_nullable
as CameraAngle,cameraDirection: null == cameraDirection ? _self.cameraDirection : cameraDirection // ignore: cast_nullable_to_non_nullable
as CameraDirection,cameraDistance: null == cameraDistance ? _self.cameraDistance : cameraDistance // ignore: cast_nullable_to_non_nullable
as CameraDistance,subjectPosition: null == subjectPosition ? _self.subjectPosition : subjectPosition // ignore: cast_nullable_to_non_nullable
as SubjectPosition,subjectRatio: null == subjectRatio ? _self.subjectRatio : subjectRatio // ignore: cast_nullable_to_non_nullable
as SubjectRatio,compositionInstruction: null == compositionInstruction ? _self.compositionInstruction : compositionInstruction // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,isReviewed: null == isReviewed ? _self.isReviewed : isReviewed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PoseTemplate].
extension PoseTemplatePatterns on PoseTemplate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PoseTemplate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PoseTemplate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PoseTemplate value)  $default,){
final _that = this;
switch (_that) {
case _PoseTemplate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PoseTemplate value)?  $default,){
final _that = this;
switch (_that) {
case _PoseTemplate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String poseId,  String poseName,  List<String> styleIds,  List<String> personTypes,  List<String> sceneTypes,  String illustrationImage,  String poseOutlineImage,  List<Orientation> supportsOrientation,  List<Framing> supportsFraming,  String bodyInstruction,  String handInstruction,  String faceInstruction,  String eyeInstruction,  String positionInstruction,  String cameraPositionInstruction,  CameraHeight cameraHeight,  CameraAngle cameraAngle,  CameraDirection cameraDirection,  CameraDistance cameraDistance,  SubjectPosition subjectPosition,  SubjectRatio subjectRatio,  String compositionInstruction,  List<String> tips,  int qualityScore,  bool isReviewed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PoseTemplate() when $default != null:
return $default(_that.poseId,_that.poseName,_that.styleIds,_that.personTypes,_that.sceneTypes,_that.illustrationImage,_that.poseOutlineImage,_that.supportsOrientation,_that.supportsFraming,_that.bodyInstruction,_that.handInstruction,_that.faceInstruction,_that.eyeInstruction,_that.positionInstruction,_that.cameraPositionInstruction,_that.cameraHeight,_that.cameraAngle,_that.cameraDirection,_that.cameraDistance,_that.subjectPosition,_that.subjectRatio,_that.compositionInstruction,_that.tips,_that.qualityScore,_that.isReviewed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String poseId,  String poseName,  List<String> styleIds,  List<String> personTypes,  List<String> sceneTypes,  String illustrationImage,  String poseOutlineImage,  List<Orientation> supportsOrientation,  List<Framing> supportsFraming,  String bodyInstruction,  String handInstruction,  String faceInstruction,  String eyeInstruction,  String positionInstruction,  String cameraPositionInstruction,  CameraHeight cameraHeight,  CameraAngle cameraAngle,  CameraDirection cameraDirection,  CameraDistance cameraDistance,  SubjectPosition subjectPosition,  SubjectRatio subjectRatio,  String compositionInstruction,  List<String> tips,  int qualityScore,  bool isReviewed)  $default,) {final _that = this;
switch (_that) {
case _PoseTemplate():
return $default(_that.poseId,_that.poseName,_that.styleIds,_that.personTypes,_that.sceneTypes,_that.illustrationImage,_that.poseOutlineImage,_that.supportsOrientation,_that.supportsFraming,_that.bodyInstruction,_that.handInstruction,_that.faceInstruction,_that.eyeInstruction,_that.positionInstruction,_that.cameraPositionInstruction,_that.cameraHeight,_that.cameraAngle,_that.cameraDirection,_that.cameraDistance,_that.subjectPosition,_that.subjectRatio,_that.compositionInstruction,_that.tips,_that.qualityScore,_that.isReviewed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String poseId,  String poseName,  List<String> styleIds,  List<String> personTypes,  List<String> sceneTypes,  String illustrationImage,  String poseOutlineImage,  List<Orientation> supportsOrientation,  List<Framing> supportsFraming,  String bodyInstruction,  String handInstruction,  String faceInstruction,  String eyeInstruction,  String positionInstruction,  String cameraPositionInstruction,  CameraHeight cameraHeight,  CameraAngle cameraAngle,  CameraDirection cameraDirection,  CameraDistance cameraDistance,  SubjectPosition subjectPosition,  SubjectRatio subjectRatio,  String compositionInstruction,  List<String> tips,  int qualityScore,  bool isReviewed)?  $default,) {final _that = this;
switch (_that) {
case _PoseTemplate() when $default != null:
return $default(_that.poseId,_that.poseName,_that.styleIds,_that.personTypes,_that.sceneTypes,_that.illustrationImage,_that.poseOutlineImage,_that.supportsOrientation,_that.supportsFraming,_that.bodyInstruction,_that.handInstruction,_that.faceInstruction,_that.eyeInstruction,_that.positionInstruction,_that.cameraPositionInstruction,_that.cameraHeight,_that.cameraAngle,_that.cameraDirection,_that.cameraDistance,_that.subjectPosition,_that.subjectRatio,_that.compositionInstruction,_that.tips,_that.qualityScore,_that.isReviewed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PoseTemplate implements PoseTemplate {
  const _PoseTemplate({required this.poseId, required this.poseName, final  List<String> styleIds = const [], final  List<String> personTypes = const [], final  List<String> sceneTypes = const [], required this.illustrationImage, required this.poseOutlineImage, final  List<Orientation> supportsOrientation = const [], final  List<Framing> supportsFraming = const [], required this.bodyInstruction, required this.handInstruction, required this.faceInstruction, required this.eyeInstruction, required this.positionInstruction, required this.cameraPositionInstruction, required this.cameraHeight, required this.cameraAngle, required this.cameraDirection, required this.cameraDistance, required this.subjectPosition, required this.subjectRatio, required this.compositionInstruction, final  List<String> tips = const [], this.qualityScore = 0, this.isReviewed = false}): _styleIds = styleIds,_personTypes = personTypes,_sceneTypes = sceneTypes,_supportsOrientation = supportsOrientation,_supportsFraming = supportsFraming,_tips = tips;
  factory _PoseTemplate.fromJson(Map<String, dynamic> json) => _$PoseTemplateFromJson(json);

@override final  String poseId;
@override final  String poseName;
 final  List<String> _styleIds;
@override@JsonKey() List<String> get styleIds {
  if (_styleIds is EqualUnmodifiableListView) return _styleIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_styleIds);
}

 final  List<String> _personTypes;
@override@JsonKey() List<String> get personTypes {
  if (_personTypes is EqualUnmodifiableListView) return _personTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_personTypes);
}

 final  List<String> _sceneTypes;
@override@JsonKey() List<String> get sceneTypes {
  if (_sceneTypes is EqualUnmodifiableListView) return _sceneTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sceneTypes);
}

@override final  String illustrationImage;
@override final  String poseOutlineImage;
 final  List<Orientation> _supportsOrientation;
@override@JsonKey() List<Orientation> get supportsOrientation {
  if (_supportsOrientation is EqualUnmodifiableListView) return _supportsOrientation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportsOrientation);
}

 final  List<Framing> _supportsFraming;
@override@JsonKey() List<Framing> get supportsFraming {
  if (_supportsFraming is EqualUnmodifiableListView) return _supportsFraming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_supportsFraming);
}

@override final  String bodyInstruction;
@override final  String handInstruction;
@override final  String faceInstruction;
@override final  String eyeInstruction;
@override final  String positionInstruction;
@override final  String cameraPositionInstruction;
@override final  CameraHeight cameraHeight;
@override final  CameraAngle cameraAngle;
@override final  CameraDirection cameraDirection;
@override final  CameraDistance cameraDistance;
@override final  SubjectPosition subjectPosition;
@override final  SubjectRatio subjectRatio;
@override final  String compositionInstruction;
 final  List<String> _tips;
@override@JsonKey() List<String> get tips {
  if (_tips is EqualUnmodifiableListView) return _tips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tips);
}

@override@JsonKey() final  int qualityScore;
@override@JsonKey() final  bool isReviewed;

/// Create a copy of PoseTemplate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PoseTemplateCopyWith<_PoseTemplate> get copyWith => __$PoseTemplateCopyWithImpl<_PoseTemplate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PoseTemplateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PoseTemplate&&(identical(other.poseId, poseId) || other.poseId == poseId)&&(identical(other.poseName, poseName) || other.poseName == poseName)&&const DeepCollectionEquality().equals(other._styleIds, _styleIds)&&const DeepCollectionEquality().equals(other._personTypes, _personTypes)&&const DeepCollectionEquality().equals(other._sceneTypes, _sceneTypes)&&(identical(other.illustrationImage, illustrationImage) || other.illustrationImage == illustrationImage)&&(identical(other.poseOutlineImage, poseOutlineImage) || other.poseOutlineImage == poseOutlineImage)&&const DeepCollectionEquality().equals(other._supportsOrientation, _supportsOrientation)&&const DeepCollectionEquality().equals(other._supportsFraming, _supportsFraming)&&(identical(other.bodyInstruction, bodyInstruction) || other.bodyInstruction == bodyInstruction)&&(identical(other.handInstruction, handInstruction) || other.handInstruction == handInstruction)&&(identical(other.faceInstruction, faceInstruction) || other.faceInstruction == faceInstruction)&&(identical(other.eyeInstruction, eyeInstruction) || other.eyeInstruction == eyeInstruction)&&(identical(other.positionInstruction, positionInstruction) || other.positionInstruction == positionInstruction)&&(identical(other.cameraPositionInstruction, cameraPositionInstruction) || other.cameraPositionInstruction == cameraPositionInstruction)&&(identical(other.cameraHeight, cameraHeight) || other.cameraHeight == cameraHeight)&&(identical(other.cameraAngle, cameraAngle) || other.cameraAngle == cameraAngle)&&(identical(other.cameraDirection, cameraDirection) || other.cameraDirection == cameraDirection)&&(identical(other.cameraDistance, cameraDistance) || other.cameraDistance == cameraDistance)&&(identical(other.subjectPosition, subjectPosition) || other.subjectPosition == subjectPosition)&&(identical(other.subjectRatio, subjectRatio) || other.subjectRatio == subjectRatio)&&(identical(other.compositionInstruction, compositionInstruction) || other.compositionInstruction == compositionInstruction)&&const DeepCollectionEquality().equals(other._tips, _tips)&&(identical(other.qualityScore, qualityScore) || other.qualityScore == qualityScore)&&(identical(other.isReviewed, isReviewed) || other.isReviewed == isReviewed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,poseId,poseName,const DeepCollectionEquality().hash(_styleIds),const DeepCollectionEquality().hash(_personTypes),const DeepCollectionEquality().hash(_sceneTypes),illustrationImage,poseOutlineImage,const DeepCollectionEquality().hash(_supportsOrientation),const DeepCollectionEquality().hash(_supportsFraming),bodyInstruction,handInstruction,faceInstruction,eyeInstruction,positionInstruction,cameraPositionInstruction,cameraHeight,cameraAngle,cameraDirection,cameraDistance,subjectPosition,subjectRatio,compositionInstruction,const DeepCollectionEquality().hash(_tips),qualityScore,isReviewed]);

@override
String toString() {
  return 'PoseTemplate(poseId: $poseId, poseName: $poseName, styleIds: $styleIds, personTypes: $personTypes, sceneTypes: $sceneTypes, illustrationImage: $illustrationImage, poseOutlineImage: $poseOutlineImage, supportsOrientation: $supportsOrientation, supportsFraming: $supportsFraming, bodyInstruction: $bodyInstruction, handInstruction: $handInstruction, faceInstruction: $faceInstruction, eyeInstruction: $eyeInstruction, positionInstruction: $positionInstruction, cameraPositionInstruction: $cameraPositionInstruction, cameraHeight: $cameraHeight, cameraAngle: $cameraAngle, cameraDirection: $cameraDirection, cameraDistance: $cameraDistance, subjectPosition: $subjectPosition, subjectRatio: $subjectRatio, compositionInstruction: $compositionInstruction, tips: $tips, qualityScore: $qualityScore, isReviewed: $isReviewed)';
}


}

/// @nodoc
abstract mixin class _$PoseTemplateCopyWith<$Res> implements $PoseTemplateCopyWith<$Res> {
  factory _$PoseTemplateCopyWith(_PoseTemplate value, $Res Function(_PoseTemplate) _then) = __$PoseTemplateCopyWithImpl;
@override @useResult
$Res call({
 String poseId, String poseName, List<String> styleIds, List<String> personTypes, List<String> sceneTypes, String illustrationImage, String poseOutlineImage, List<Orientation> supportsOrientation, List<Framing> supportsFraming, String bodyInstruction, String handInstruction, String faceInstruction, String eyeInstruction, String positionInstruction, String cameraPositionInstruction, CameraHeight cameraHeight, CameraAngle cameraAngle, CameraDirection cameraDirection, CameraDistance cameraDistance, SubjectPosition subjectPosition, SubjectRatio subjectRatio, String compositionInstruction, List<String> tips, int qualityScore, bool isReviewed
});




}
/// @nodoc
class __$PoseTemplateCopyWithImpl<$Res>
    implements _$PoseTemplateCopyWith<$Res> {
  __$PoseTemplateCopyWithImpl(this._self, this._then);

  final _PoseTemplate _self;
  final $Res Function(_PoseTemplate) _then;

/// Create a copy of PoseTemplate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? poseId = null,Object? poseName = null,Object? styleIds = null,Object? personTypes = null,Object? sceneTypes = null,Object? illustrationImage = null,Object? poseOutlineImage = null,Object? supportsOrientation = null,Object? supportsFraming = null,Object? bodyInstruction = null,Object? handInstruction = null,Object? faceInstruction = null,Object? eyeInstruction = null,Object? positionInstruction = null,Object? cameraPositionInstruction = null,Object? cameraHeight = null,Object? cameraAngle = null,Object? cameraDirection = null,Object? cameraDistance = null,Object? subjectPosition = null,Object? subjectRatio = null,Object? compositionInstruction = null,Object? tips = null,Object? qualityScore = null,Object? isReviewed = null,}) {
  return _then(_PoseTemplate(
poseId: null == poseId ? _self.poseId : poseId // ignore: cast_nullable_to_non_nullable
as String,poseName: null == poseName ? _self.poseName : poseName // ignore: cast_nullable_to_non_nullable
as String,styleIds: null == styleIds ? _self._styleIds : styleIds // ignore: cast_nullable_to_non_nullable
as List<String>,personTypes: null == personTypes ? _self._personTypes : personTypes // ignore: cast_nullable_to_non_nullable
as List<String>,sceneTypes: null == sceneTypes ? _self._sceneTypes : sceneTypes // ignore: cast_nullable_to_non_nullable
as List<String>,illustrationImage: null == illustrationImage ? _self.illustrationImage : illustrationImage // ignore: cast_nullable_to_non_nullable
as String,poseOutlineImage: null == poseOutlineImage ? _self.poseOutlineImage : poseOutlineImage // ignore: cast_nullable_to_non_nullable
as String,supportsOrientation: null == supportsOrientation ? _self._supportsOrientation : supportsOrientation // ignore: cast_nullable_to_non_nullable
as List<Orientation>,supportsFraming: null == supportsFraming ? _self._supportsFraming : supportsFraming // ignore: cast_nullable_to_non_nullable
as List<Framing>,bodyInstruction: null == bodyInstruction ? _self.bodyInstruction : bodyInstruction // ignore: cast_nullable_to_non_nullable
as String,handInstruction: null == handInstruction ? _self.handInstruction : handInstruction // ignore: cast_nullable_to_non_nullable
as String,faceInstruction: null == faceInstruction ? _self.faceInstruction : faceInstruction // ignore: cast_nullable_to_non_nullable
as String,eyeInstruction: null == eyeInstruction ? _self.eyeInstruction : eyeInstruction // ignore: cast_nullable_to_non_nullable
as String,positionInstruction: null == positionInstruction ? _self.positionInstruction : positionInstruction // ignore: cast_nullable_to_non_nullable
as String,cameraPositionInstruction: null == cameraPositionInstruction ? _self.cameraPositionInstruction : cameraPositionInstruction // ignore: cast_nullable_to_non_nullable
as String,cameraHeight: null == cameraHeight ? _self.cameraHeight : cameraHeight // ignore: cast_nullable_to_non_nullable
as CameraHeight,cameraAngle: null == cameraAngle ? _self.cameraAngle : cameraAngle // ignore: cast_nullable_to_non_nullable
as CameraAngle,cameraDirection: null == cameraDirection ? _self.cameraDirection : cameraDirection // ignore: cast_nullable_to_non_nullable
as CameraDirection,cameraDistance: null == cameraDistance ? _self.cameraDistance : cameraDistance // ignore: cast_nullable_to_non_nullable
as CameraDistance,subjectPosition: null == subjectPosition ? _self.subjectPosition : subjectPosition // ignore: cast_nullable_to_non_nullable
as SubjectPosition,subjectRatio: null == subjectRatio ? _self.subjectRatio : subjectRatio // ignore: cast_nullable_to_non_nullable
as SubjectRatio,compositionInstruction: null == compositionInstruction ? _self.compositionInstruction : compositionInstruction // ignore: cast_nullable_to_non_nullable
as String,tips: null == tips ? _self._tips : tips // ignore: cast_nullable_to_non_nullable
as List<String>,qualityScore: null == qualityScore ? _self.qualityScore : qualityScore // ignore: cast_nullable_to_non_nullable
as int,isReviewed: null == isReviewed ? _self.isReviewed : isReviewed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
