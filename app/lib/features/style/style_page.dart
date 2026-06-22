import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import '../placeholder_scaffold.dart';

class StylePage extends StatelessWidget {
  const StylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderScaffold(
      title: '选择拍摄风格',
      nextLabel: '下一步：人物类型',
      onNext: () => context.push(Routes.person),
    );
  }
}
