import 'package:get/get.dart';
import 'package:localmarket/splash_screen.dart';
import 'package:localmarket/widget/role_selection.dart'; // timro actual path

class RootRoutes {
  RootRoutes._();

  static const splash = '/';
  static const roleSelect = '/role';
}

class RootPages {
  RootPages._();

  static final routes = [
    GetPage(
      name: RootRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RootRoutes.roleSelect,
      page: () => const RoleSelectionPage(),
    ),
  ];
}