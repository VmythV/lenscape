import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../core/widgets/app_image.dart';
import '../../data/local/local_storage.dart';
import '../../data/static/asset_data_source.dart';

/// 收藏页（见 docs/prd.md P1）。
class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final datasetAsync = ref.watch(staticDatasetProvider);
    final favorites = ref.read(favoriteRepositoryProvider).list();

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              tooltip: '清空收藏',
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                await ref.read(favoriteRepositoryProvider).clear();
                setState(() {});
              },
            ),
        ],
      ),
      body: datasetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('数据加载失败：$e')),
        data: (dataset) {
          if (favorites.isEmpty) {
            return const Center(child: Text('还没有收藏的拍摄模板'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final pose = dataset.posesById[favorites[i].poseId];
              if (pose == null) return const SizedBox.shrink();
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
