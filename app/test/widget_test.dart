import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lenscape/app/app.dart';

void main() {
  testWidgets('首页渲染并展示开始入口', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: LenscapeApp()));
    await tester.pumpAndSettle();

    expect(find.text('镜界 Lenscape'), findsOneWidget);
    expect(find.text('开始拍摄指导'), findsOneWidget);
    expect(find.text('我的收藏'), findsOneWidget);
  });
}
