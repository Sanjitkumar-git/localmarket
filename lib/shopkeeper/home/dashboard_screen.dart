import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/controller/dashboard_controller.dart';
import 'package:localmarket/shopkeeper/routes/app_routes.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_radius.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ============================================================
      // APP BAR
      // ============================================================
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,

        iconTheme: IconThemeData(color: AppColors.white, size: 28),

        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.storefront_outlined,
              color: AppColors.primaryLight,
              size: 28,
            ),

            const SizedBox(width: 5),

            Text(
              AppLanguage.tr(en: 'NearShop', hi: 'नियरशॉप', ne: 'नियरसप'),
              style: TextStyle(
                color: AppColors.primaryLight,
                fontSize: AppTextSizes.h3,
                fontWeight: AppFontWeights.extraBold,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.support_agent_outlined,
              color: AppColors.white,
              size: 28,
            ),
          ),
        ],
      ),

      // ============================================================
      // DRAWER
      // ============================================================
      drawer: Drawer(
        backgroundColor: AppColors.background,

        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),

              child: Row(
                children: [
                  Icon(
                    Icons.storefront_outlined,
                    color: AppColors.primaryLight,
                    size: 22,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    AppLanguage.tr(en: 'NearShop', hi: 'नियरशॉप', ne: 'नियरसप'),
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Dashboard
            ListTile(
              leading: Icon(
                Icons.dashboard_outlined,
                color: AppColors.textPrimary,
              ),
              title: Text(
                AppLanguage.tr(
                  en: 'Dashboard',
                  hi: 'डैशबोर्ड',
                  ne: 'ड्यासबोर्ड',
                ),
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppTextSizes.button,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),

            // Profile
            ListTile(
              leading: Icon(
                Icons.person_outlined,
                color: AppColors.textPrimary,
              ),
              title: Text(
                AppLanguage.tr(en: 'Profile', hi: 'प्रोफ़ाइल', ne: 'प्रोफाइल'),
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppTextSizes.button,
                ),
              ),
              onTap: () {},
            ),

            // Language
            ListTile(
              leading: Icon(
                Icons.language_outlined,
                color: AppColors.textPrimary,
              ),
              title: Text(
                AppLanguage.tr(en: 'Language', hi: 'भाषा', ne: 'भाषा'),
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppTextSizes.button,
                ),
              ),
              onTap: () {},
            ),

            // Help
            ListTile(
              leading: Icon(Icons.help_outline, color: AppColors.textPrimary),
              title: Text(
                AppLanguage.tr(
                  en: 'Help and Support',
                  hi: 'सहायता और समर्थन',
                  ne: 'मद्दत र समर्थन',
                ),
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppTextSizes.button,
                ),
              ),
              onTap: () {},
            ),

            // Logout
            ListTile(
              leading: Icon(Icons.logout_outlined, color: AppColors.secondary),
              title: Text(
                AppLanguage.tr(en: 'Logout', hi: 'लॉग आउट', ne: 'लगआउट'),
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: AppTextSizes.button,
                ),
              ),
              onTap: () {
                controller.logout();
              },
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshDashboard,

          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            child: Column(
              children: [
                Padding(
                  padding: AppPadding.verticalMd,

                  child: Container(
                    height: 100,
                    width: double.infinity,

                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/shop/home.png'),
                        fit: BoxFit.fill,
                      ),
                    ),

                    child: Column(
                      children: [
                        Padding(
                          padding: AppPadding.horizontalMd,

                          child: Row(
                            children: [
                              Obx(
                                () => Text(
                                  controller.shopName.value,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: AppTextSizes.h5,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 4),

                        Padding(
                          padding: AppPadding.horizontalSm,

                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.black,
                                size: 20,
                              ),

                              const SizedBox(width: 4),

                              Expanded(
                                child: Obx(() {
                                  if (controller.isLoadingLocation.value) {
                                    return Text(
                                      AppLanguage.tr(
                                        en: 'Getting your location...',
                                        hi: 'आपका स्थान प्राप्त किया जा रहा है...',
                                        ne: 'तपाईंको स्थान प्राप्त गरिँदैछ...',
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: AppTextSizes.caption,
                                      ),
                                    );
                                  }

                                  return Text(
                                    controller.userLocation.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: AppTextSizes.caption,
                                      fontWeight: AppFontWeights.medium,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ==================================================
                // ADD PRODUCT
                // ==================================================
                _dashboardCard(
                  image: 'assets/shop/addproduct.png',

                  title: AppLanguage.tr(
                    en: 'Add Product',
                    hi: 'उत्पाद जोड़ें',
                    ne: 'सामान थप्नुहोस्',
                  ),

                  description: AppLanguage.tr(
                    en: 'Add new products to your shop\nand let people discover them.',
                    hi: 'अपनी दुकान में नए उत्पाद जोड़ें\nऔर लोगों को उन्हें खोजने दें।',
                    ne: 'तपाईंको पसलमा नयाँ सामानहरू थप्नुहोस्\nर मानिसहरूलाई ती खोज्न दिनुहोस्।',
                  ),

                  onTap: () {
                    Get.toNamed(AppRoutes.addProduct);
                  },
                ),

                const SizedBox(height: 10),

                // ==================================================
                // VIEW PRODUCT
                // ==================================================
                _dashboardCard(
                  image: 'assets/shop/viewproduct.png',

                  title: AppLanguage.tr(
                    en: 'View Product',
                    hi: 'उत्पाद देखें',
                    ne: 'सामान हेर्नुहोस्',
                  ),

                  description: AppLanguage.tr(
                    en: 'View all your added\nProduct in Your Shop',
                    hi: 'अपनी दुकान में जोड़े गए सभी\nउत्पाद देखें',
                    ne: 'तपाईंको पसलमा थपिएका सबै\nसामानहरू हेर्नुहोस्',
                  ),

                  onTap: () {},
                ),

                const SizedBox(height: 10),

                // ==================================================
                // OFFER PRODUCT
                // ==================================================
                _dashboardCard(
                  image: 'assets/shop/offer.png',

                  title: AppLanguage.tr(
                    en: 'Offer Product',
                    hi: 'ऑफ़र उत्पाद',
                    ne: 'अफर सामान',
                  ),

                  description: AppLanguage.tr(
                    en: 'Add product on offer\nand attract more customers',
                    hi: 'ऑफ़र पर उत्पाद जोड़ें\nऔर अधिक ग्राहकों को आकर्षित करें',
                    ne: 'अफरमा सामान थप्नुहोस्\nर थप ग्राहकहरू आकर्षित गर्नुहोस्',
                  ),

                  onTap: () {},
                ),

                const SizedBox(height: 5),

                // ==================================================
                // FOOTER
                // ==================================================
                Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: AppRadius.rounded,
                  ),

                  child: Image.asset(
                    'assets/shop/footer.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // REUSABLE DASHBOARD CARD
  // ==============================================================

  Widget _dashboardCard({
    required String image,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      focusColor: AppColors.primary,
      splashColor: AppColors.shophome,

      child: Container(
        width: double.infinity,
        height: 200,

        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: AppRadius.rounded,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Padding(
              padding: AppPadding.horizontalMd,

              child: Container(
                width: 150,
                height: 180,

                decoration: BoxDecoration(
                  color: AppColors.shophome,
                  borderRadius: AppRadius.rounded,
                ),

                child: Image.asset(image, fit: BoxFit.contain),
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: AppTextSizes.h6,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    description,
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.caption,
                      fontWeight: AppFontWeights.medium,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Container(
              width: 40,
              height: 40,

              decoration: BoxDecoration(
                color: AppColors.shophome,
                borderRadius: AppRadius.rounded,
              ),

              child: IconButton(
                onPressed: onTap,

                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
