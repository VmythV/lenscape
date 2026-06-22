import 'package:flutter/material.dart';

/// 流程页面的临时占位骨架。真实实现见 TODOLIST #16–#19，
/// 在对应任务中替换为风格 / 人物 / 场景 / 指导等页面。
class PlaceholderScaffold extends StatelessWidget {
  const PlaceholderScaffold({
    super.key,
    required this.title,
    this.nextLabel,
    this.onNext,
  });

  final String title;
  final String? nextLabel;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('「$title」开发中', style: Theme.of(context).textTheme.titleMedium),
              if (onNext != null && nextLabel != null) ...[
                const SizedBox(height: 24),
                FilledButton(onPressed: onNext, child: Text(nextLabel!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
