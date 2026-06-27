import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/widgets/app_image.dart';
import '../../data/local/local_storage.dart';
import '../../data/remote/llm_gateway.dart';
import '../../data/static/asset_data_source.dart';
import '../../data/static/static_dataset.dart';
import '../../domain/models/history_entry.dart';
import '../../domain/models/person_type.dart';
import '../../domain/models/pose_template.dart';
import '../../domain/models/scene.dart';
import '../../domain/models/style.dart';
import '../session/selection_provider.dart';

/// 拍摄指导页（核心，见 docs/prd.md §11.5）。
/// [poseId] 非空时直接展示该模板（用于收藏/历史进入）；否则按当前选择推荐。
class GuidancePage extends ConsumerStatefulWidget {
  const GuidancePage({super.key, this.poseId});
  final String? poseId;

  @override
  ConsumerState<GuidancePage> createState() => _GuidancePageState();
}

class _GuidancePageState extends ConsumerState<GuidancePage> {
  int _index = 0;
  final _recorded = <String>{};
  final _copyFutures = <String, Future<GuidanceCopy>>{};

  @override
  Widget build(BuildContext context) {
    final datasetAsync = ref.watch(staticDatasetProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('拍摄指导')),
      body: datasetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('数据加载失败：$e')),
        data: (dataset) => _buildContent(dataset),
      ),
    );
  }

  Widget _buildContent(StaticDataset dataset) {
    final selection = ref.read(selectionProvider);
    final deepLink = widget.poseId != null;

    // 解析模板列表与放宽标记
    List<PoseTemplate> poses;
    var relaxedScene = false;
    var relaxedPerson = false;
    if (deepLink) {
      final p = dataset.posesById[widget.poseId];
      poses = p == null ? const [] : [p];
    } else {
      if (selection.styleId == null ||
          selection.personType == null ||
          selection.sceneId == null) {
        return const _Hint('请从首页开始选择风格、人物和场景。');
      }
      final engine = ref.read(recommendationEngineProvider)!;
      final rec = engine.recommendPoses(
        styleId: selection.styleId!,
        personType: selection.personType!,
        sceneId: selection.sceneId!,
      );
      poses = rec.templates;
      relaxedScene = rec.relaxedScene;
      relaxedPerson = rec.relaxedPerson;
    }

    if (poses.isEmpty) return const _Hint('暂无匹配的拍摄模板。');

    final current = poses[_index % poses.length];

    // 解析上下文（优先用当前选择，缺失则取模板自身关联）
    final style = dataset.stylesById[
        deepLink ? current.styleIds.first : (selection.styleId ?? current.styleIds.first)];
    final person = dataset.personTypesById[
        deepLink ? current.personTypes.first : (selection.personType ?? current.personTypes.first)];
    final scene = dataset.scenesById[
        deepLink ? current.sceneTypes.first : (selection.sceneId ?? current.sceneTypes.first)];

    _recordHistory(current, style, person, scene);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _contextChips(style, person, scene, poses.length),
        if (relaxedScene || relaxedPerson) ...[
          const SizedBox(height: 8),
          _relaxBanner(relaxedScene, relaxedPerson),
        ],
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(current.poseName,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            IconButton(
              tooltip: '分享这套拍摄指导',
              icon: const Icon(Icons.ios_share),
              onPressed: () => _share(current, style, person, scene),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _images(current),
        const SizedBox(height: 16),
        if (style != null && person != null && scene != null)
          _StepsSection(
            future: _copyFor(current, style, person, scene),
            initial: _templateCopy(current),
          )
        else
          _StepsList(
            steps: _templateCopy(current).steps,
            tips: current.tips,
            degraded: true,
          ),
        if (current.tips.isNotEmpty) ...[
          const SizedBox(height: 16),
          _tips(current),
        ],
        const SizedBox(height: 20),
        _actions(current, poses.length),
        const SizedBox(height: 12),
      ],
    );
  }

  Future<GuidanceCopy> _copyFor(
    PoseTemplate pose,
    Style style,
    PersonTypeInfo person,
    Scene scene,
  ) {
    return _copyFutures.putIfAbsent(
      pose.poseId,
      () => ref.read(llmGatewayProvider).generateGuidanceCopy(
            style: style,
            person: person,
            scene: scene,
            pose: pose,
          ),
    );
  }

  void _recordHistory(
    PoseTemplate pose,
    Style? style,
    PersonTypeInfo? person,
    Scene? scene,
  ) {
    if (_recorded.contains(pose.poseId)) return;
    _recorded.add(pose.poseId);
    final ctx = HistoryContext(
      styleId: style?.styleId ?? pose.styleIds.first,
      personType: person?.personType ?? pose.personTypes.first,
      sceneId: scene?.sceneId ?? pose.sceneTypes.first,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyRepositoryProvider).record(pose.poseId, ctx);
    });
  }

  Widget _contextChips(Style? s, PersonTypeInfo? p, Scene? sc, int count) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        if (s != null) Chip(label: Text(s.styleName)),
        if (p != null) Chip(label: Text(p.personName)),
        if (sc != null) Chip(label: Text(sc.sceneName)),
        if (count > 1) Chip(label: Text('$count 个姿势')),
      ],
    );
  }

  Widget _relaxBanner(bool scene, bool person) {
    final parts = [if (scene) '场景', if (person) '人物类型'];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('已为你放宽了 ${parts.join("、")} 条件以提供更多参考。'),
    );
  }

  Widget _images(PoseTemplate pose) {
    return Row(
      children: [
        Expanded(child: _imageCard('示意图', pose.illustrationImage)),
        const SizedBox(width: 12),
        Expanded(child: _imageCard('姿势轮廓', pose.poseOutlineImage)),
      ],
    );
  }

  Widget _imageCard(String label, String path) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(aspectRatio: 3 / 4, child: AppImage(path)),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }

  /// 分享当前这套拍摄指导（系统分享面板）。优先用已就绪的 LLM 文案，否则用模板兜底。
  Future<void> _share(
    PoseTemplate pose,
    Style? style,
    PersonTypeInfo? person,
    Scene? scene,
  ) async {
    final copy = await (_copyFutures[pose.poseId] ?? Future.value(_templateCopy(pose)));
    final context = [
      if (style != null) '风格：${style.styleName}',
      if (person != null) '人物：${person.personName}',
      if (scene != null) '场景：${scene.sceneName}',
    ].join('｜');
    final steps = [
      for (var i = 0; i < copy.steps.length; i++) '${i + 1}. ${copy.steps[i]}',
    ].join('\n');
    final tips = copy.tips.isEmpty
        ? ''
        : '\n\n注意事项：\n${copy.tips.map((t) => '· $t').join('\n')}';
    final text = '镜界 · ${pose.poseName}\n$context\n\n拍摄步骤：\n$steps$tips';
    await Share.share(text, subject: '镜界拍摄指导 · ${pose.poseName}');
  }

  /// 基于模板字段拼出的兜底文案（即时展示，待 LLM 文案就绪后替换）。
  GuidanceCopy _templateCopy(PoseTemplate p) {
    final steps = [
      p.bodyInstruction,
      p.handInstruction,
      '${p.faceInstruction} ${p.eyeInstruction}'.trim(),
      p.cameraPositionInstruction,
      p.compositionInstruction,
    ].where((s) => s.trim().isNotEmpty).toList();
    return GuidanceCopy(steps, p.tips, degraded: true);
  }

  Widget _tips(PoseTemplate pose) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('注意事项', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 6),
        for (final t in pose.tips)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text('· $t'),
          ),
      ],
    );
  }

  Widget _actions(PoseTemplate pose, int count) {
    final isFav = ref.read(favoriteRepositoryProvider).isFavorite(pose.poseId);
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              await ref.read(favoriteRepositoryProvider).toggle(pose.poseId);
              setState(() {});
            },
            icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_border),
            label: Text(isFav ? '已收藏' : '收藏'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.icon(
            onPressed: count > 1
                ? () => setState(() => _index = (_index + 1) % count)
                : null,
            icon: const Icon(Icons.swap_horiz),
            label: const Text('换个姿势'),
          ),
        ),
      ],
    );
  }
}

class _StepsSection extends StatelessWidget {
  const _StepsSection({required this.future, required this.initial});
  final Future<GuidanceCopy> future;
  final GuidanceCopy initial;

  @override
  Widget build(BuildContext context) {
    // 先用模板兜底文案即时渲染，LLM 文案就绪后无缝替换。
    return FutureBuilder<GuidanceCopy>(
      future: future,
      initialData: initial,
      builder: (context, snap) {
        final copy = snap.data ?? initial;
        return _StepsList(steps: copy.steps, tips: copy.tips, degraded: copy.degraded);
      },
    );
  }
}

class _StepsList extends StatelessWidget {
  const _StepsList({required this.steps, this.tips = const [], required this.degraded});
  final List<String> steps;
  final List<String> tips;
  final bool degraded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('拍摄步骤', style: theme.textTheme.titleSmall),
            const SizedBox(width: 8),
            if (degraded)
              Text('（基础指导）',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.outline)),
          ],
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 11,
                  child: Text('${i + 1}', style: theme.textTheme.labelSmall),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(steps[i])),
              ],
            ),
          ),
      ],
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(24), child: Text(text)),
    );
  }
}
