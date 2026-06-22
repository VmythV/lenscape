import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../placeholder_scaffold.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScaffold(
      title: '选择人物类型',
      nextLabel: '下一步：场景',
      onNext: () => context.push(Routes.scene),
    );
  }
}
