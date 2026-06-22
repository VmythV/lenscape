import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router.dart';
import 'theme.dart';

/// 应用根组件。第一版仅中文（见 docs/prd.md §14.4）。
class LenscapeApp extends StatelessWidget {
  const LenscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '镜界 Lenscape',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: appRouter,
      locale: const Locale('zh'),
      supportedLocales: const [Locale('zh'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
