import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/home/controller/shop_bottom_nav_controller.dart';
import 'package:localmarket/shopkeeper/home/dashboard_screen.dart';
import 'package:localmarket/shopkeeper/profile/view/profile_view.dart';

import 'package:localmarket/widget/app_colors.dart';

import 'package:localmarket/widget/app_language.dart';

class ShopkeeperBottomView extends GetView<ShopkeeperBottomController> {
  const ShopkeeperBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DashboardView(),

      const Center(
        child: Text(
          'Messages',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),

      const ProfileView(),
    ];

    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
      ),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,

          selectedItemColor: AppColors.primary,

          unselectedItemColor: AppColors.textSecondary,

          type: BottomNavigationBarType.fixed,

          onTap: controller.changeTab,

          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: AppLanguage.tr(en: 'Home', hi: 'होम', ne: 'होम'),
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.message_outlined),
              activeIcon: const Icon(Icons.message),
              label: AppLanguage.tr(
                en: 'Messages',
                hi: 'संदेश',
                ne: 'सन्देशहरू',
              ),
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: AppLanguage.tr(
                en: 'Profile',
                hi: 'प्रोफ़ाइल',
                ne: 'प्रोफाइल',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
