import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_entry.freezed.dart';
part 'history_entry.g.dart';

/// 浏览历史的上下文（产生该次浏览时的选择）。
@freezed
abstract class HistoryContext with _$HistoryContext {
  const factory HistoryContext({
    required String styleId,
    required String personType,
    required String sceneId,
  }) = _HistoryContext;

  factory HistoryContext.fromJson(Map<String, dynamic> json) =>
      _$HistoryContextFromJson(json);
}

/// 浏览历史（本地存储，见 docs/data-model.md §2.6）。
@freezed
abstract class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required String poseId,
    required HistoryContext context,
    required int viewedAt,
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$HistoryEntryFromJson(json);
}
