import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/static/asset_data_source.dart';
import '../../domain/recommendation/recommendation_engine.dart';

/// 贯穿拍摄指导流程的用户选择（风格 → 人物 → 场景）。
class ShootingSelection {
  const ShootingSelection({
    this.styleId,
    this.personType,
    this.sceneId,
    this.userNote,
  });

  final String? styleId;
  final String? personType;
  final String? sceneId;
  final String? userNote;

  ShootingSelection copyWith({
    String? styleId,
    String? personType,
    String? sceneId,
    String? userNote,
  }) {
    return ShootingSelection(
      styleId: styleId ?? this.styleId,
      personType: personType ?? this.personType,
      sceneId: sceneId ?? this.sceneId,
      userNote: userNote ?? this.userNote,
    );
  }
}

class SelectionNotifier extends Notifier<ShootingSelection> {
  @override
  ShootingSelection build() => const ShootingSelection();

  void setStyle(String styleId) => state = state.copyWith(styleId: styleId);
  void setPerson(String personType) =>
      state = state.copyWith(personType: personType);
  void setScene(String sceneId) => state = state.copyWith(sceneId: sceneId);
  void setNote(String note) => state = state.copyWith(userNote: note);
  void reset() => state = const ShootingSelection();
}

final selectionProvider =
    NotifierProvider<SelectionNotifier, ShootingSelection>(SelectionNotifier.new);

/// 推荐引擎 provider（数据集就绪后可用，否则为 null）。
final recommendationEngineProvider = Provider<RecommendationEngine?>((ref) {
  final dataset = ref.watch(staticDatasetProvider).valueOrNull;
  return dataset == null ? null : RecommendationEngine(dataset);
});
