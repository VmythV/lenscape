import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'favorite_repository.dart';
import 'history_repository.dart';

/// 在 runApp 之前初始化本地存储并打开所需的 box。
Future<void> initLocalStorage() async {
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox<String>(FavoriteRepository.boxName),
    Hive.openBox<String>(HistoryRepository.boxName),
  ]);
}

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository(Hive.box<String>(FavoriteRepository.boxName));
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(Hive.box<String>(HistoryRepository.boxName));
});
