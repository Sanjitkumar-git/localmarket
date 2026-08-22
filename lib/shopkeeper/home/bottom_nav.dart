import 'package:flutter/material.dart';
import 'package:localmarket/shopkeeper/home/dashboard_screen.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_language.dart';

class shopkeeperbottomApp extends StatelessWidget {
  const shopkeeperbottomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: shopkeeperbottom());
  }
}

class shopkeeperbottom extends StatefulWidget {
  const shopkeeperbottom({super.key});

  @override
  State<shopkeeperbottom> createState() => _shopkeeperbottomState();
}

class _shopkeeperbottomState extends State<shopkeeperbottom> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    Center(child: Text('Messages', style: optionStyle)),
    Center(child: Text('Profile', style: optionStyle)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLanguage.tr(en: 'Home', hi: 'होम', ne: 'होम'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: AppLanguage.tr(en: 'Messages', hi: 'संदेश', ne: 'सन्देशहरू'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLanguage.tr(
              en: 'Profile',
              hi: 'प्रोफ़ाइल',
              ne: 'प्रोफाइल',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
