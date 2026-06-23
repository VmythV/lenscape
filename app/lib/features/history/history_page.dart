import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../core/widgets/app_image.dart';
import '../../data/local/local_storage.dart';
import '../../data/static/asset_data_source.dart';

/// 最近浏览页（见 docs/prd.md P1）。
class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final datasetAsync = ref.watch(staticDatasetProvider);
    final history = ref.read(historyRepositoryProvider).list();

    return Scaffold(
      appBar: AppBar(
        title: const Text('最近浏览'),
        actions: [
          if (history.isNotEmpty)
            IconButton(
              tooltip: '清空记录',
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                await ref.read(historyRepositoryProvider).clear();
                setState(() {});
              },
            ),
        ],
      ),
      body: datasetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('数据加载失败：$e')),
        data: (dataset) {
          if (history.isEmpty) {
            return const Center(child: Text('还没有浏览记录'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: history.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final entry = history[i];
              final pose = dataset.posesById[entry.poseId];
              if (pose == null) return const SizedBox.shrink();
              final style = dataset.stylesById[entry.context.styleId]?.styleName;
              final scene = dataset.scenesById[entry.context.sceneId]?.sceneName;
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: AppImage(pose.illustrationImage),
                    ),
                  ),
                  title: Text(pose.poseName),
                  subtitle: Text([style, scene].whereType<String>().join(' · ')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      context.push('${Routes.guidance}?pose=${pose.poseId}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
