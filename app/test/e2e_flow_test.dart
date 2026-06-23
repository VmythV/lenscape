import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:lenscape/app/app.dart';
import 'package:lenscape/data/local/favorite_repository.dart';
import 'package:lenscape/data/local/history_repository.dart';
import 'package:lenscape/data/static/asset_data_source.dart';
import 'package:lenscape/data/static/static_dataset.dart';

/// 核心闭环端到端：首页 → 风格 → 人物 → 场景 → 拍摄指导（见 TODOLIST #20）。
/// 用磁盘加载的数据集覆盖 staticDatasetProvider，避免 widget 测试中 rootBundle 不可用；
/// 在 runAsync 中驱动，让图片解码与网关 Future 等真实异步得以完成。
StaticDataset _loadDataset() => StaticDataset.fromJsonStrings(
      stylesJson: File('assets/data/styles.json').readAsStringSync(),
      scenesJson: File('assets/data/scenes.json').readAsStringSync(),
      personTypesJson: File('assets/data/person_types.json').readAsStringSync(),
      posesJson: File('assets/data/poses.json').readAsStringSync(),
    );

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('lenscape_e2e_');
    Hive.init(tempDir.path);
    await Hive.openBox<String>(FavoriteRepository.boxName);
    await Hive.openBox<String>(HistoryRepository.boxName);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  testWidgets('走通核心闭环并展示拍摄步骤', (tester) async {
    final dataset = _loadDataset();

    // 放大测试视口，避免指导页较长内容因懒加载 ListView 落在视口外。
    tester.view.physicalSize = const Size(1080, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.runAsync(() async {
      // 让路由切换/动画与图片解码等真实异步完成后再断言（runAsync 内不能用 pumpAndSettle）。
      Future<void> settle() async {
        for (var i = 0; i < 6; i++) {
          await tester.pump(const Duration(milliseconds: 80));
          await Future<void>.delayed(const Duration(milliseconds: 40));
        }
      }

      Future<void> tap(Finder finder) async {
        await tester.tap(finder);
        await settle();
      }

      await tester.pumpWidget(
        ProviderScope(
          overrides: [staticDatasetProvider.overrideWith((ref) => dataset)],
          child: const LenscapeApp(),
        ),
      );
      await settle();

      // 首页 → 风格
      await tap(find.text('开始拍摄指导'));
      expect(find.text('选择拍摄风格'), findsOneWidget);

      // 选「韩系风格」→ 人物
      await tap(find.text('韩系风格'));
      expect(find.text('选择人物类型'), findsOneWidget);

      // 选「女生」→ 场景
      await tap(find.text('女生'));
      expect(find.text('选择拍摄场景'), findsOneWidget);

      // 选「咖啡店」场景并继续
      await tap(find.widgetWithText(ChoiceChip, '咖啡店'));
      await tap(find.widgetWithText(FilledButton, '查看拍摄指导'));

      // 已进入指导页
      expect(find.widgetWithText(AppBar, '拍摄指导'), findsOneWidget);

      // 指导页应展示步骤与操作
      expect(find.text('拍摄步骤'), findsOneWidget);
      expect(find.text('换个姿势'), findsOneWidget);
      expect(find.text('收藏'), findsOneWidget);

      // 收藏当前模板
      await tap(find.widgetWithText(OutlinedButton, '收藏'));
      expect(find.text('已收藏'), findsOneWidget);
    });
  }, timeout: const Timeout(Duration(seconds: 90)));
}
