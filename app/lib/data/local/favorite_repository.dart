import 'dart:convert';

import 'package:hive/hive.dart';

import '../../domain/models/favorite.dart';

/// 收藏仓库（本地 Hive，见 docs/data-model.md §2.5）。
/// 以 poseId 为 key 存储 JSON 字符串，天然去重。
class FavoriteRepository {
  FavoriteRepository(this._box);

  static const boxName = 'favorites';
  final Box<String> _box;

  bool isFavorite(String poseId) => _box.containsKey(poseId);

  Future<void> add(String poseId) {
    final fav = Favorite(poseId: poseId, createdAt: DateTime.now().millisecondsSinceEpoch);
    return _box.put(poseId, jsonEncode(fav.toJson()));
  }

  Future<void> remove(String poseId) => _box.delete(poseId);

  /// 切换收藏状态，返回切换后的状态（true=已收藏）。
  Future<bool> toggle(String poseId) async {
    if (isFavorite(poseId)) {
      await remove(poseId);
      return false;
    }
    await add(poseId);
    return true;
  }

  /// 按收藏时间倒序返回。
  List<Favorite> list() {
    final items = _box.values
        .map((s) => Favorite.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return items;
  }

  Future<void> clear() => _box.clear();
}
