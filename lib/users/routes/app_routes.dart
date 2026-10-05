import 'package:get/get.dart';
import 'package:localmarket/users/auth/bindings/sign_in_bindings.dart';
import 'package:localmarket/users/auth/bindings/sign_up_bindings.dart';
import 'package:localmarket/users/auth/view/fotgot_screen.dart';
import 'package:localmarket/users/auth/view/home_screen.dart';
import 'package:localmarket/users/auth/view/sign_in_screen.dart';
import 'package:localmarket/users/auth/view/sign_up_screen.dart';

class UserPages {
  UserPages._();

  static final routes = [
    GetPage(
      name: _Paths.SIGNINSCREEN,
      page: () => const SignInScreen(),
      binding: UserSignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUPSCREEN,
      page: () => const SignUpScreen(),
      binding: UserSignUpBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _Paths.FORGOTPAGE,
      page: () => const ForgotScreen(),
    ),
  ];
}

abstract class Routes {
  Routes._();

  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const SIGNINSCREEN = _Paths.SIGNINSCREEN;
  static const SIGNUPSCREEN = _Paths.SIGNUPSCREEN;
  static const FORGOTPAGE = _Paths.FORGOTPAGE;
}

abstract class _Paths {
  _Paths._();

  static const SPLASH = '/user/splash';
  static const HOME = '/user/home';
  static const SIGNINSCREEN = '/user/sign_in';
  static const SIGNUPSCREEN = '/user/sign_up';
  static const FORGOTPAGE = '/user/forgot';
}