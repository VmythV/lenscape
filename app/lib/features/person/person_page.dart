import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../data/static/asset_data_source.dart';
import '../session/selection_provider.dart';

/// 人物类型选择页（见 docs/prd.md §11.3）。
class PersonPage extends ConsumerWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datasetAsync = ref.watch(staticDatasetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('选择人物类型')),
      body: datasetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('数据加载失败：$e')),
        data: (dataset) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: dataset.personTypes.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (_, i) {
            final p = dataset.personTypes[i];
            return Card(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(p.personName),
                subtitle: Text(p.direction),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ref.read(selectionProvider.notifier).setPerson(p.personType);
                  context.push(Routes.scene);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
