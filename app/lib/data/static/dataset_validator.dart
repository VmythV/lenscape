import 'static_dataset.dart';

/// 构建期数据校验（见 docs/data-model.md §2.4 / §4）。
/// 返回错误信息列表，空列表表示通过。可由 CI 测试调用作为合并门禁。
class DatasetValidator {
  /// 指导文案中禁止出现的泛泛占位词（对应 PRD 19.2）。
  static const blacklist = <String>[
    '自然一点',
    '找好角度',
    '注意构图',
    '随意一点',
    '好看一点',
    '放松一点点',
  ];

  /// 每个风格至少需要的已审核模板数。
  static const minReviewedPerStyle = 3;

  /// [imageExists] 给定资产相对路径（如 images/poses/a.png）返回该文件是否存在；
  /// 运行时可不传（仅校验数据一致性），CI 测试传入以校验图片资产。
  static List<String> validate(
    StaticDataset d, {
    bool Function(String assetRelPath)? imageExists,
  }) {
    final errors = <String>[];

    final styleIds = d.stylesById.keys.toSet();
    final sceneIds = d.scenesById.keys.toSet();
    final personIds = d.personTypesById.keys.toSet();

    void checkRefs(String ctx, Iterable<String> refs, Set<String> valid, String kind) {
      for (final r in refs) {
        if (!valid.contains(r)) errors.add('$ctx 引用了不存在的$kind: $r');
      }
    }

    // 风格外键
    for (final s in d.styles) {
      checkRefs('风格 ${s.styleId} 的 suitable_scenes', s.suitableScenes, sceneIds, '场景');
      checkRefs('风格 ${s.styleId} 的 suitable_person_types', s.suitablePersonTypes, personIds, '人物类型');
    }

    // 场景外键
    for (final s in d.scenes) {
      checkRefs('场景 ${s.sceneId} 的 suitable_styles', s.suitableStyles, styleIds, '风格');
      checkRefs('场景 ${s.sceneId} 的 unsuitable_styles', s.unsuitableStyles, styleIds, '风格');
    }

    // 模板外键 + 文案 + 图片
    final reviewedByStyle = <String, int>{};
    for (final p in d.poses) {
      checkRefs('模板 ${p.poseId} 的 style_ids', p.styleIds, styleIds, '风格');
      checkRefs('模板 ${p.poseId} 的 person_types', p.personTypes, personIds, '人物类型');
      checkRefs('模板 ${p.poseId} 的 scene_types', p.sceneTypes, sceneIds, '场景');

      if (p.styleIds.isEmpty) errors.add('模板 ${p.poseId} 未关联任何风格');
      if (p.personTypes.isEmpty) errors.add('模板 ${p.poseId} 未关联任何人物类型');
      if (p.sceneTypes.isEmpty) errors.add('模板 ${p.poseId} 未关联任何场景');

      // 文案非空 + 黑名单
      final texts = <String, String>{
        'body': p.bodyInstruction,
        'hand': p.handInstruction,
        'face': p.faceInstruction,
        'eye': p.eyeInstruction,
        'position': p.positionInstruction,
        'camera_position': p.cameraPositionInstruction,
        'composition': p.compositionInstruction,
      };
      texts.forEach((field, text) {
        if (text.trim().isEmpty) {
          errors.add('模板 ${p.poseId} 的 $field 文案为空');
        }
        for (final word in blacklist) {
          if (text.contains(word)) {
            errors.add('模板 ${p.poseId} 的 $field 含禁用占位词「$word」');
          }
        }
      });

      // 图片资产
      if (imageExists != null) {
        for (final img in [p.illustrationImage, p.poseOutlineImage]) {
          if (img.trim().isEmpty) {
            errors.add('模板 ${p.poseId} 缺少图片路径');
          } else if (!imageExists(img)) {
            errors.add('模板 ${p.poseId} 引用的图片不存在: $img');
          }
        }
      }

      if (p.isReviewed) {
        for (final sid in p.styleIds) {
          reviewedByStyle[sid] = (reviewedByStyle[sid] ?? 0) + 1;
        }
      }
    }

    // 每风格已审核模板数
    for (final sid in styleIds) {
      final n = reviewedByStyle[sid] ?? 0;
      if (n < minReviewedPerStyle) {
        errors.add('风格 $sid 只有 $n 个已审核模板，少于要求的 $minReviewedPerStyle 个');
      }
    }

    // 风格/场景图片
    if (imageExists != null) {
      for (final s in d.styles) {
        for (final img in s.sampleImages) {
          if (!imageExists(img)) errors.add('风格 ${s.styleId} 的示例图不存在: $img');
        }
      }
      for (final s in d.scenes) {
        for (final img in s.exampleImages) {
          if (!imageExists(img)) errors.add('场景 ${s.sceneId} 的示例图不存在: $img');
        }
      }
    }

    return errors;
  }
}
