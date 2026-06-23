import 'package:flutter/material.dart';

/// 渲染本地资产图片（路径相对 assets/，见 docs/data-model.md）。
/// 占位阶段为 1x1 灰图；加载失败时回退为柔和灰底，避免布局抖动。
class AppImage extends StatelessWidget {
  const AppImage(this.relativePath, {super.key, this.fit = BoxFit.cover});

  final String relativePath;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
    );
    return Image.asset(
      'assets/$relativePath',
      fit: fit,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => fallback,
    );
  }
}
