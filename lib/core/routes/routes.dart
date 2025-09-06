import 'package:go_router/go_router.dart';
import 'package:swap_ui/core/routes/routes_names.dart';
import 'package:swap_ui/features/main/presentation/page/main_app_screen.dart';

class Routes {
  static final routes = GoRouter(
    initialLocation: RoutesNames.main,
    routes: [
      GoRoute(
          path: RoutesNames.main,
          builder: (context, state) => const MainAppScreen()),
    ],
  );
}
