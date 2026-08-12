import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localmarket/widget/language_selection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await GoogleSignIn.instance.initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LanguageSelectionPage(),

      // ============================================================
      // LOGIN ROLE SWITCH
      // Uncomment ONLY the page you want to test.
      //
      // USER LOGIN:
      // SignInPage(),
      //
      // PARTNER LOGIN:
      // PartnerSignInPage(),
      //
      // Keep the other page commented out.
      // ============================================================

      // USER
      // SignInPage(),

      // PARTNER
    );
  }
}
