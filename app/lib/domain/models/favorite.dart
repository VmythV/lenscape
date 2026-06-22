import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

/// 收藏（本地存储，见 docs/data-model.md §2.5）。
@freezed
abstract class Favorite with _$Favorite {
  const factory Favorite({
    required String poseId,
    required int createdAt,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}
