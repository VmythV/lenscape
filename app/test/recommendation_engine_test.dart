import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lenscape/data/static/static_dataset.dart';
import 'package:lenscape/domain/models/enums.dart';
import 'package:lenscape/domain/recommendation/recommendation_engine.dart';

StaticDataset _loadDataset() {
  return StaticDataset.fromJsonStrings(
    stylesJson: File('assets/data/styles.json').readAsStringSync(),
    scenesJson: File('assets/data/scenes.json').readAsStringSync(),
    personTypesJson: File('assets/data/person_types.json').readAsStringSync(),
    posesJson: File('assets/data/poses.json').readAsStringSync(),
  );
}

void main() {
  late RecommendationEngine engine;

  setUp(() {
    engine = RecommendationEngine(_loadDataset());
  });

  group('能力 A：场景 → 风格推荐', () {
    test('咖啡店 + 女生：韩系/日系排在前，海边风格不出现在正分里', () {
      final result = engine.recommendStyles(sceneId: 'cafe', personType: 'female');
      expect(result, isNotEmpty);
      final top2 = result.take(2).map((s) => s.style.styleId).toSet();
      expect(top2.intersection({'korean', 'japanese'}), isNotEmpty);
      // 分数从高到低
      for (var i = 1; i < result.length; i++) {
        expect(result[i - 1].score, greaterThanOrEqualTo(result[i].score));
      }
    });

    test('unsuitable_styles 受到惩罚：海边场景下港风分数低于旅行', () {
      final result = engine.recommendStyles(sceneId: 'seaside', personType: 'female');
      final byId = {for (final s in result) s.style.styleId: s.score};
      // seaside.unsuitable_styles 含 hongkong/korean；travel 是 suitable
      expect(byId['travel'], greaterThan(byId['hongkong'] ?? -999));
    });

    test('未知场景也不返回空（回退全部风格）', () {
      final result = engine.recommendStyles(sceneId: 'unknown', personType: 'female');
      expect(result, isNotEmpty);
    });
  });

  group('能力 B：姿势模板推荐', () {
    test('精确命中：街拍 + 男生 + 街道 返回该组合模板', () {
      final r = engine.recommendPoses(
        styleId: 'street',
        personType: 'male',
        sceneId: 'street',
      );
      expect(r.templates, isNotEmpty);
      expect(r.relaxedScene, isFalse);
      expect(r.relaxedPerson, isFalse);
      // 命中的模板确实包含该三元组
      for (final t in r.templates) {
        expect(t.styleIds.contains('street'), isTrue);
        expect(t.personTypes.contains('male'), isTrue);
        expect(t.sceneTypes.contains('street'), isTrue);
      }
    });

    test('偏好加分：提供 framing=full_body 时全身模板排更前', () {
      final r = engine.recommendPoses(
        styleId: 'street',
        personType: 'male',
        sceneId: 'street',
        framing: Framing.fullBody,
      );
      expect(r.templates.first.supportsFraming, contains(Framing.fullBody));
    });

    test('放宽场景：街拍 + 男生 + 海边 无精确命中则放宽 scene', () {
      final r = engine.recommendPoses(
        styleId: 'street',
        personType: 'male',
        sceneId: 'seaside',
      );
      expect(r.templates, isNotEmpty);
      expect(r.relaxedScene, isTrue);
      for (final t in r.templates) {
        expect(t.styleIds.contains('street'), isTrue);
        expect(t.personTypes.contains('male'), isTrue);
      }
    });

    test('放宽人物：情侣风格下选了非情侣人物，逐级放宽仍有结果', () {
      final r = engine.recommendPoses(
        styleId: 'couple',
        personType: 'male',
        sceneId: 'indoor',
      );
      expect(r.templates, isNotEmpty);
      expect(r.relaxedPerson, isTrue);
    });

    test('结果按偏好分降序', () {
      final r = engine.recommendPoses(
        styleId: 'travel',
        personType: 'female',
        sceneId: 'seaside',
      );
      for (var i = 1; i < r.templates.length; i++) {
        expect(
          r.templates[i - 1].qualityScore,
          greaterThanOrEqualTo(r.templates[i].qualityScore),
        );
      }
    });
  });
}
