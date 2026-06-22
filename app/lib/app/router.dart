import 'package:go_router/go_router.dart';

import '../features/favorite/favorite_page.dart';
import '../features/guidance/guidance_page.dart';
import '../features/history/history_page.dart';
import '../features/home/home_page.dart';
import '../features/person/person_page.dart';
import '../features/scene/scene_page.dart';
import '../features/style/style_page.dart';

/// 路由路径常量。核心流程：首页 → 风格 → 人物类型 → 场景 → 拍摄指导
/// （见 docs/prd.md §9.2）。
abstract final class Routes {
  static const home = '/';
  static const style = '/style';
  static const person = '/person';
  static const scene = '/scene';
  static const guidance = '/guidance';
  static const favorite = '/favorite';
  static const history = '/history';
}

final appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(path: Routes.home, builder: (_, _) => const HomePage()),
    GoRoute(path: Routes.style, builder: (_, _) => const StylePage()),
    GoRoute(path: Routes.person, builder: (_, _) => const PersonPage()),
    GoRoute(path: Routes.scene, builder: (_, _) => const ScenePage()),
    GoRoute(path: Routes.guidance, builder: (_, _) => const GuidancePage()),
    GoRoute(path: Routes.favorite, builder: (_, _) => const FavoritePage()),
    GoRoute(path: Routes.history, builder: (_, _) => const HistoryPage()),
  ],
);
