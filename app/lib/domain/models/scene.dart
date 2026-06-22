import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'scene.freezed.dart';
part 'scene.g.dart';

/// 拍摄场景（见 docs/data-model.md §2.2）。
@freezed
abstract class Scene with _$Scene {
  const factory Scene({
    required String sceneId,
    required String sceneName,
    required String sceneDescription,
    @Default([]) List<String> exampleImages,
    @Default([]) List<String> suitableStyles,
    @Default([]) List<String> unsuitableStyles,
    required Orientation recommendedOrientation,
    required Framing recommendedFraming,
    @Default([]) List<String> recommendedCamera,
    @Default([]) List<String> foregroundHints,
    @Default([]) List<String> backgroundHints,
    @Default(true) bool keepBackground,
  }) = _Scene;

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
}
