import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'static_dataset.dart';

/// 资产根前缀（pubspec 中声明在 assets/ 下）。
const _assetsRoot = 'assets/';

/// 运行时从打包资产加载本地静态数据集。
Future<StaticDataset> loadStaticDatasetFromAssets() async {
  Future<String> read(String rel) => rootBundle.loadString('$_assetsRoot$rel');

  final results = await Future.wait([
    read('data/styles.json'),
    read('data/scenes.json'),
    read('data/person_types.json'),
    read('data/poses.json'),
  ]);

  return StaticDataset.fromJsonStrings(
    stylesJson: results[0],
    scenesJson: results[1],
    personTypesJson: results[2],
    posesJson: results[3],
  );
}

/// 全局静态数据集 provider（应用启动时加载一次）。
final staticDatasetProvider = FutureProvider<StaticDataset>((ref) {
  return loadStaticDatasetFromAssets();
});
