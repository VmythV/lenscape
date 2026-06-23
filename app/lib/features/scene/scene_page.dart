import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../../data/remote/llm_gateway.dart';
import '../../data/static/asset_data_source.dart';
import '../../data/static/static_dataset.dart';
import '../session/selection_provider.dart';

/// 场景选择页（见 docs/prd.md §11.4）。
/// 支持手动选场景、可选文字描述，并可调用智能风格推荐（能力 A）。
class ScenePage extends ConsumerStatefulWidget {
  const ScenePage({super.key});

  @override
  ConsumerState<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends ConsumerState<ScenePage> {
  String? _sceneId;
  final _noteController = TextEditingController();
  bool _recommending = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final datasetAsync = ref.watch(staticDatasetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('选择拍摄场景')),
      body: datasetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('数据加载失败：$e')),
        data: (dataset) => _buildBody(dataset),
      ),
    );
  }

  Widget _buildBody(StaticDataset dataset) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text('当前场景'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in dataset.scenes)
                    ChoiceChip(
                      label: Text(s.sceneName),
                      selected: _sceneId == s.sceneId,
                      onSelected: (_) => setState(() => _sceneId = s.sceneId),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _noteController,
                maxLength: 200,
                minLines: 2,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: '补充描述场景（可选）',
                  hintText: '例如：想要安静、文艺一点的氛围',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _sceneId == null || _recommending
                    ? null
                    : () => _recommendStyles(dataset),
                icon: _recommending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.auto_awesome_outlined),
                label: const Text('智能推荐更适合的风格（可选）'),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: _sceneId == null
                  ? null
                  : () {
                      final notifier = ref.read(selectionProvider.notifier);
                      notifier.setScene(_sceneId!);
                      notifier.setNote(_noteController.text);
                      context.push(Routes.guidance);
                    },
              child: const Text('查看拍摄指导'),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _recommendStyles(StaticDataset dataset) async {
    final selection = ref.read(selectionProvider);
    final engine = ref.read(recommendationEngineProvider);
    final scene = dataset.scenesById[_sceneId];
    final person = dataset.personTypesById[selection.personType];
    if (engine == null || scene == null || person == null) return;

    setState(() => _recommending = true);
    final scores = engine.recommendStyles(
      sceneId: scene.sceneId,
      personType: person.personType,
    );
    final candidates = [
      for (final s in scores)
        StyleCandidate(
          styleId: s.style.styleId,
          styleName: s.style.styleName,
          baseScore: s.score,
        ),
    ];
    final result = await ref.read(llmGatewayProvider).recommendStyles(
          scene: scene,
          person: person,
          userNote: _noteController.text,
          candidates: candidates,
        );
    if (!mounted) return;
    setState(() => _recommending = false);

    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Text('推荐风格', style: Theme.of(ctx).textTheme.titleMedium),
                const SizedBox(width: 8),
                if (result.degraded)
                  Text('（基础排序）',
                      style: Theme.of(ctx).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            for (final rec in result.recommendations)
              ListTile(
                title: Text(dataset.stylesById[rec.styleId]?.styleName ?? rec.styleId),
                subtitle: rec.reason.isEmpty ? null : Text(rec.reason),
                trailing: const Icon(Icons.check_circle_outline),
                onTap: () {
                  ref.read(selectionProvider.notifier).setStyle(rec.styleId);
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '已切换到「${dataset.stylesById[rec.styleId]?.styleName ?? rec.styleId}」',
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
