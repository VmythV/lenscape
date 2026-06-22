import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lenscape/data/static/dataset_validator.dart';
import 'package:lenscape/data/static/static_dataset.dart';

/// 构建期数据校验门禁（见 docs/data-model.md §4）。
/// 直接从磁盘读取 assets/data 与图片，校验数据一致性与资产存在性。
void main() {
  final dataDir = Directory('assets/data');
  final assetsDir = Directory('assets');

  test('本地静态数据解析、外键、文案与图片资产全部合法', () {
    final dataset = StaticDataset.fromJsonStrings(
      stylesJson: File('${dataDir.path}/styles.json').readAsStringSync(),
      scenesJson: File('${dataDir.path}/scenes.json').readAsStringSync(),
      personTypesJson:
          File('${dataDir.path}/person_types.json').readAsStringSync(),
      posesJson: File('${dataDir.path}/poses.json').readAsStringSync(),
    );

    final errors = DatasetValidator.validate(
      dataset,
      imageExists: (rel) => File('${assetsDir.path}/$rel').existsSync(),
    );

    expect(errors, isEmpty, reason: errors.join('\n'));
  });

  test('数据规模符合第一版范围（6 风格 / 8 场景 / 5 人物 / ≥24 模板）', () {
    final dataset = StaticDataset.fromJsonStrings(
      stylesJson: File('${dataDir.path}/styles.json').readAsStringSync(),
      scenesJson: File('${dataDir.path}/scenes.json').readAsStringSync(),
      personTypesJson:
          File('${dataDir.path}/person_types.json').readAsStringSync(),
      posesJson: File('${dataDir.path}/poses.json').readAsStringSync(),
    );

    expect(dataset.styles.length, 6);
    expect(dataset.scenes.length, 8);
    expect(dataset.personTypes.length, 5);
    expect(dataset.poses.length, greaterThanOrEqualTo(24));
  });
}
