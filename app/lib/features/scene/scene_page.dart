import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../placeholder_scaffold.dart';

class ScenePage extends StatelessWidget {
  const ScenePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScaffold(
      title: '选择拍摄场景',
      nextLabel: '查看拍摄指导',
      onNext: () => context.push(Routes.guidance),
    );
  }
}
