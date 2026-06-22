import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:lenscape/data/local/favorite_repository.dart';
import 'package:lenscape/data/local/history_repository.dart';
import 'package:lenscape/domain/models/history_entry.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('lenscape_hive_');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
    await tempDir.delete(recursive: true);
  });

  test('收藏：toggle 切换状态并按时间倒序列出', () async {
    final box = await Hive.openBox<String>(FavoriteRepository.boxName);
    final repo = FavoriteRepository(box);

    expect(repo.isFavorite('p1'), isFalse);
    expect(await repo.toggle('p1'), isTrue);
    expect(repo.isFavorite('p1'), isTrue);

    await repo.add('p2');
    final list = repo.list();
    expect(list.length, 2);
    expect(list.first.poseId, 'p2'); // 后加的在前

    expect(await repo.toggle('p1'), isFalse);
    expect(repo.isFavorite('p1'), isFalse);
  });

  test('历史：同一模板去重保留最近一次', () async {
    final box = await Hive.openBox<String>(HistoryRepository.boxName);
    final repo = HistoryRepository(box);
    const ctx = HistoryContext(styleId: 'street', personType: 'male', sceneId: 'street');

    await repo.record('p1', ctx);
    await Future<void>.delayed(const Duration(milliseconds: 2));
    await repo.record('p2', ctx);
    await Future<void>.delayed(const Duration(milliseconds: 2));
    await repo.record('p1', ctx); // 再看一次 p1

    final list = repo.list();
    expect(list.length, 2); // 去重
    expect(list.first.poseId, 'p1'); // 最近浏览的在前
  });

  test('历史：超过上限滚动淘汰最旧', () async {
    final box = await Hive.openBox<String>(HistoryRepository.boxName);
    final repo = HistoryRepository(box);
    const ctx = HistoryContext(styleId: 'street', personType: 'male', sceneId: 'street');

    for (var i = 0; i < HistoryRepository.maxEntries + 5; i++) {
      await repo.record('p$i', ctx);
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }

    expect(repo.list().length, HistoryRepository.maxEntries);
    // 最旧的 p0 已被淘汰
    expect(repo.list().any((e) => e.poseId == 'p0'), isFalse);
  });
}
