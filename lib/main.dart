import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/firebase_options.dart';
import 'package:localmarket/shopkeeper/routes/shop_pages.dart' as shop;
import 'package:localmarket/splash_screen.dart';
import 'package:localmarket/users/routes/app_routes.dart' as user;
import 'package:localmarket/users/routes/root_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('ne')],
      path: 'assets/translations/user',
      fallbackLocale: const Locale('en'),
      // startLocale: const Locale('en'),
      saveLocale: true,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [...RootPages.routes, ...user.UserPages.routes, ...shop.routes],

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      home: const SplashScreen(),
    );
  }
}
