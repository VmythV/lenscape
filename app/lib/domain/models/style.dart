import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'style.freezed.dart';
part 'style.g.dart';

/// 拍摄风格（见 docs/data-model.md §2.1）。
@freezed
abstract class Style with _$Style {
  const factory Style({
    required String styleId,
    required String styleName,
    required String styleDescription,
    @Default([]) List<String> sampleImages,
    @Default([]) List<String> suitableScenes,
    @Default([]) List<String> suitablePersonTypes,
    required Orientation defaultOrientation,
    required Framing defaultFraming,
    @Default([]) List<String> compositionRules,
    @Default([]) List<String> cameraRules,
    @Default(0) int sortWeight,
  }) = _Style;

  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);
}
