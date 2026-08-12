import 'package:flutter/material.dart';
import 'package:localmarket/widget/language_selection.dart';

void main() {
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
