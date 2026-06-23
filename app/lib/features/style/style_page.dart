import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../core/widgets/app_image.dart';
import '../../data/static/asset_data_source.dart';
import '../../domain/models/style.dart';
import '../session/selection_provider.dart';

/// 风格选择页（见 docs/prd.md §11.2）。
class StylePage extends ConsumerWidget {
  const StylePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datasetAsync = ref.watch(staticDatasetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('选择拍摄风格')),
      body: datasetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('数据加载失败：$e')),
        data: (dataset) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: dataset.styles.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final style = dataset.styles[i];
            return _StyleCard(
              style: style,
              onTap: () {
                ref.read(selectionProvider.notifier).setStyle(style.styleId);
                context.push(Routes.person);
              },
            );
          },
        ),
      ),
    );
  }
}

class _StyleCard extends StatelessWidget {
  const _StyleCard({required this.style, required this.onTap});
  final Style style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: style.sampleImages.isEmpty
                  ? const SizedBox()
                  : AppImage(style.sampleImages.first),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(style.styleName, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    style.styleDescription,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('查看拍摄指导', style: theme.textTheme.labelLarge),
                        const Icon(Icons.chevron_right, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
