import 'dart:convert';

import 'package:hive/hive.dart';

import '../../domain/models/history_entry.dart';

/// 浏览历史仓库（本地 Hive，见 docs/data-model.md §2.6）。
/// 以 poseId 为 key 去重保留最近一次；超过上限滚动淘汰最旧记录。
class HistoryRepository {
  HistoryRepository(this._box);

  static const boxName = 'history';
  static const maxEntries = 50;
  final Box<String> _box;

  /// 记录一次浏览（覆盖同一模板的旧记录，更新时间戳）。
  Future<void> record(String poseId, HistoryContext context) async {
    final entry = HistoryEntry(
      poseId: poseId,
      context: context,
      viewedAt: DateTime.now().millisecondsSinceEpoch,
    );
    await _box.put(poseId, jsonEncode(entry.toJson()));
    await _enforceCap();
  }

  Future<void> _enforceCap() async {
    if (_box.length <= maxEntries) return;
    final sorted = _entries()..sort((a, b) => a.viewedAt.compareTo(b.viewedAt));
    final removeCount = _box.length - maxEntries;
    for (final e in sorted.take(removeCount)) {
      await _box.delete(e.poseId);
    }
  }

  /// 按浏览时间倒序返回。
  List<HistoryEntry> list() {
    return _entries()..sort((a, b) => b.viewedAt.compareTo(a.viewedAt));
  }

  List<HistoryEntry> _entries() => _box.values
      .map((s) => HistoryEntry.fromJson(jsonDecode(s) as Map<String, dynamic>))
      .toList();

  Future<void> clear() => _box.clear();
}
