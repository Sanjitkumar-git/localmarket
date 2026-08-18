import 'package:flutter/material.dart';
import 'package:localmarket/splash_screen.dart';

void main() {
  runApp(const MainApp());
}
//Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();

//   await GoogleSignIn.instance.initialize();

//   runApp(const MainApp());
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
