import '../../data/static/static_dataset.dart';
import '../models/enums.dart';
import '../models/pose_template.dart';
import '../models/style.dart';

/// 风格推荐结果项（能力 A）。
class StyleScore {
  const StyleScore(this.style, this.score);
  final Style style;
  final double score;
}

/// 姿势模板推荐结果（能力 B）。
class PoseRecommendation {
  const PoseRecommendation({
    required this.templates,
    this.relaxedScene = false,
    this.relaxedPerson = false,
  });

  final List<PoseTemplate> templates;
  final bool relaxedScene; // 是否放宽了场景条件
  final bool relaxedPerson; // 是否放宽了人物类型条件
}

/// 规则推荐引擎（见 docs/data-model.md §3）。纯函数式，无 IO 依赖。
class RecommendationEngine {
  RecommendationEngine(this._data);

  final StaticDataset _data;

  // 能力 A 权重
  static const _wSceneSuit = 3.0;
  static const _wSceneUnsuit = 4.0;
  static const _wStyleScene = 2.0;
  static const _wPerson = 1.0;

  /// 能力 A：场景 → 风格推荐排序（本地兜底，§3.1）。
  List<StyleScore> recommendStyles({
    required String sceneId,
    required String personType,
  }) {
    final scene = _data.scenesById[sceneId];

    final scored = _data.styles.map((style) {
      double score = 0;
      if (scene != null) {
        if (scene.suitableStyles.contains(style.styleId)) score += _wSceneSuit;
        if (scene.unsuitableStyles.contains(style.styleId)) score -= _wSceneUnsuit;
      }
      if (style.suitableScenes.contains(sceneId)) score += _wStyleScene;
      if (style.suitablePersonTypes.contains(personType)) score += _wPerson;
      score += style.sortWeight / 100.0; // 同分平滑项
      return StyleScore(style, score);
    }).toList();

    final positive = scored.where((s) => s.score > 0).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    if (positive.isNotEmpty) return positive;

    // 全部被过滤 → 回退展示全部风格，按 sort_weight 排序
    return (_data.styles.toList()
          ..sort((a, b) => b.sortWeight.compareTo(a.sortWeight)))
        .map((s) => StyleScore(s, s.sortWeight / 100.0))
        .toList();
  }

  /// 能力 B：风格/人物/场景 → 姿势模板推荐（核心，§3.2）。
  PoseRecommendation recommendPoses({
    required String styleId,
    required String personType,
    required String sceneId,
    Orientation? orientation,
    Framing? framing,
  }) {
    int preferenceScore(PoseTemplate t) {
      var s = t.qualityScore;
      if (orientation != null && t.supportsOrientation.contains(orientation)) s += 10;
      if (framing != null && t.supportsFraming.contains(framing)) s += 10;
      return s;
    }

    List<PoseTemplate> sortByPref(Iterable<PoseTemplate> items) {
      final list = items.toList()
        ..sort((a, b) => preferenceScore(b).compareTo(preferenceScore(a)));
      return list;
    }

    final reviewed = _data.poses.where((p) => p.isReviewed);

    // 第一步：硬过滤
    final exact = reviewed.where((p) =>
        p.styleIds.contains(styleId) &&
        p.personTypes.contains(personType) &&
        p.sceneTypes.contains(sceneId));
    final exactList = sortByPref(exact);
    if (exactList.isNotEmpty) {
      return PoseRecommendation(templates: exactList);
    }

    // 兜底 1：放宽场景（style + person）
    final relaxScene = reviewed.where((p) =>
        p.styleIds.contains(styleId) && p.personTypes.contains(personType));
    final relaxSceneList = sortByPref(relaxScene);
    if (relaxSceneList.isNotEmpty) {
      return PoseRecommendation(templates: relaxSceneList, relaxedScene: true);
    }

    // 兜底 2：再放宽人物类型（仅 style）
    final relaxPerson = reviewed.where((p) => p.styleIds.contains(styleId));
    final relaxPersonList = sortByPref(relaxPerson);
    if (relaxPersonList.isNotEmpty) {
      return PoseRecommendation(
        templates: relaxPersonList,
        relaxedScene: true,
        relaxedPerson: true,
      );
    }

    // 兜底 3/4：该风格无任何模板 → 全库按质量分 Top N
    final globalTop = sortByPref(reviewed).take(8).toList();
    return PoseRecommendation(
      templates: globalTop,
      relaxedScene: true,
      relaxedPerson: true,
    );
  }
}
