import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';

/// 首页：快速进入拍摄指导流程（见 docs/prd.md §11.1）。
/// 不含拍照 / 上传 / 评分 / 作品管理入口。
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('镜界 Lenscape')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text('拍摄前，先知道怎么拍', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 4),
              Text(
                '选风格 → 选人物 → 选场景 → 获取图文拍摄指导',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.outline),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () => context.push(Routes.style),
                icon: const Icon(Icons.photo_camera_outlined),
                label: const Text('开始拍摄指导'),
              ),
              const SizedBox(height: 12),
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
      ),
    );
  }
}
