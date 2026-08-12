import 'package:flutter/material.dart';
import 'package:localmarket/shopkeeper/auth/sign_in.dart';
import 'package:localmarket/users/auth/sign_in.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
    
// ============================================================
// LOGIN ROLE SWITCH
// Uncomment ONLY the page you want to test.
//
// USER LOGIN:
// SignInPage(),

// PARTNER LOGIN:
// PartnerSignInPage(),
//
// Keep the other page commented out.
// ============================================================

// USER
SignInPage(),

// PARTNER
// PartnerSignInPage(),
    );

  }
}
