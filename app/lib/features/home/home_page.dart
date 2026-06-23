import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../data/static/asset_data_source.dart';
import '../../data/static/static_dataset.dart';
import '../session/selection_provider.dart';

/// 首页：快速进入拍摄指导流程（见 docs/prd.md §11.1）。
/// 不含拍照 / 上传 / 评分 / 作品管理入口。
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final datasetAsync = ref.watch(staticDatasetProvider);

    void startFresh() {
      ref.read(selectionProvider.notifier).reset();
      context.push(Routes.style);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('镜界 Lenscape')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 8),
            Text('拍摄前，先知道怎么拍', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              '选风格 → 选人物 → 选场景 → 获取图文拍摄指导',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: startFresh,
              icon: const Icon(Icons.photo_camera_outlined),
              label: const Text('开始拍摄指导'),
            ),
            const SizedBox(height: 24),
            datasetAsync.maybeWhen(
              data: (dataset) => _QuickEntries(dataset: dataset),
              orElse: () => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(Routes.favorite),
                    icon: const Icon(Icons.bookmark_border),
                    label: const Text('我的收藏'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.push(Routes.history),
                    icon: const Icon(Icons.history),
                    label: const Text('最近浏览'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 热门风格 / 常用场景快捷入口（见 docs/prd.md §11.1）。
class _QuickEntries extends ConsumerWidget {
  const _QuickEntries({required this.dataset});
  final StaticDataset dataset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notifier = ref.read(selectionProvider.notifier);

    // 热门风格：按 sort_weight 取前若干
    final topStyles = ([...dataset.styles]
          ..sort((a, b) => b.sortWeight.compareTo(a.sortWeight)))
        .take(6)
        .toList();
    final commonScenes = dataset.scenes.take(6).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('热门风格', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in topStyles)
              ActionChip(
                label: Text(s.styleName),
                onPressed: () {
                  // 预选风格，跳过风格页直接进入人物选择
                  notifier.reset();
                  notifier.setStyle(s.styleId);
                  context.push(Routes.person);
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text('常用场景', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final s in commonScenes)
              ActionChip(
                label: Text(s.sceneName),
                onPressed: () {
                  // 预选场景，从风格页开始走流程（场景页会回填该场景）
                  notifier.reset();
                  notifier.setScene(s.sceneId);
                  context.push(Routes.style);
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
