// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:localmarket/shopkeeper/home/controller/dashboard_controller.dart';
// import 'package:localmarket/widget/app_colors.dart';
// import 'package:localmarket/widget/app_font.dart';
// import 'package:localmarket/widget/app_fontweight.dart';
// import 'package:localmarket/widget/app_language.dart';
// import 'package:localmarket/widget/app_padding.dart';
// import 'package:localmarket/widget/app_radius.dart';
// import 'package:localmarket/widget/app_routes.dart';

// class DashboardView extends GetView<DashboardController> {
//   const DashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,

//       // ============================================================
//       // APP BAR
//       // ============================================================
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         centerTitle: true,

//         iconTheme: IconThemeData(color: AppColors.white, size: 28),

//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.storefront_outlined,
//               color: AppColors.primaryLight,
//               size: 28,
//             ),

//             const SizedBox(width: 5),

//             Text(
//               AppLanguage.tr(en: 'NearShop', hi: 'नियरशॉप', ne: 'नियरसप'),
//               style: TextStyle(
//                 color: AppColors.primaryLight,
//                 fontSize: AppTextSizes.h3,
//                 fontWeight: AppFontWeights.extraBold,
//               ),
//             ),
//           ],
//         ),

//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Icons.support_agent_outlined,
//               color: AppColors.white,
//               size: 28,
//             ),
//           ),
//         ],
//       ),

//       // ============================================================
//       // DRAWER
//       // ============================================================
//       drawer: Drawer(
//         backgroundColor: AppColors.background,

//         child: ListView(
//           padding: EdgeInsets.zero,

//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: AppColors.primary),

//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.storefront_outlined,
//                     color: AppColors.primaryLight,
//                     size: 22,
//                   ),

//                   const SizedBox(width: 6),

//                   Text(
//                     AppLanguage.tr(en: 'NearShop', hi: 'नियरशॉप', ne: 'नियरसप'),
//                     style: TextStyle(
//                       color: AppColors.primaryLight,
//                       fontSize: AppTextSizes.button,
//                       fontWeight: AppFontWeights.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Dashboard
//             ListTile(
//               leading: Icon(
//                 Icons.dashboard_outlined,
//                 color: AppColors.textPrimary,
//               ),
//               title: Text(
//                 AppLanguage.tr(
//                   en: 'Dashboard',
//                   hi: 'डैशबोर्ड',
//                   ne: 'ड्यासबोर्ड',
//                 ),
//                 style: TextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: AppTextSizes.button,
//                 ),
//               ),
//               onTap: () {
//                 Get.back();
//               },
//             ),

//             // Profile
//             ListTile(
//               leading: Icon(
//                 Icons.person_outlined,
//                 color: AppColors.textPrimary,
//               ),
//               title: Text(
//                 AppLanguage.tr(en: 'Profile', hi: 'प्रोफ़ाइल', ne: 'प्रोफाइल'),
//                 style: TextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: AppTextSizes.button,
//                 ),
//               ),
//               onTap: () {},
//             ),

//             // Language
//             ListTile(
//               leading: Icon(
//                 Icons.language_outlined,
//                 color: AppColors.textPrimary,
//               ),
//               title: Text(
//                 AppLanguage.tr(en: 'Language', hi: 'भाषा', ne: 'भाषा'),
//                 style: TextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: AppTextSizes.button,
//                 ),
//               ),
//               onTap: () {},
//             ),

//             // Help
//             ListTile(
//               leading: Icon(Icons.help_outline, color: AppColors.textPrimary),
//               title: Text(
//                 AppLanguage.tr(
//                   en: 'Help and Support',
//                   hi: 'सहायता और समर्थन',
//                   ne: 'मद्दत र समर्थन',
//                 ),
//                 style: TextStyle(
//                   color: AppColors.textPrimary,
//                   fontSize: AppTextSizes.button,
//                 ),
//               ),
//               onTap: () {},
//             ),

//             // Logout
//             ListTile(
//               leading: Icon(Icons.logout_outlined, color: AppColors.secondary),
//               title: Text(
//                 AppLanguage.tr(en: 'Logout', hi: 'लॉग आउट', ne: 'लगआउट'),
//                 style: TextStyle(
//                   color: AppColors.secondary,
//                   fontSize: AppTextSizes.button,
//                 ),
//               ),
//               onTap: () {
//                 controller.logout();
//               },
//             ),
//           ],
//         ),
//       ),

//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: controller.refreshDashboard,

//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),

//             child: Column(
//               children: [
//                 Padding(
//                   padding: AppPadding.verticalMd,

//                   child: Container(
//                     height: 100,
//                     width: double.infinity,

//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/shop/home.png'),
//                         fit: BoxFit.fill,
//                       ),
//                     ),

//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: AppPadding.horizontalMd,

//                           child: Row(
//                             children: [
//                               Obx(
//                                 () => Text(
//                                   controller.shopName.value,
//                                   style: TextStyle(
//                                     color: AppColors.textPrimary,
//                                     fontSize: AppTextSizes.h5,
//                                     fontWeight: AppFontWeights.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 4),

//                         Padding(
//                           padding: AppPadding.horizontalSm,

//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.location_on_outlined,
//                                 color: AppColors.black,
//                                 size: 20,
//                               ),

//                               const SizedBox(width: 4),

//                               Expanded(
//                                 child: Obx(() {
//                                   if (controller.isLoadingLocation.value) {
//                                     return Text(
//                                       AppLanguage.tr(
//                                         en: 'Getting your location...',
//                                         hi: 'आपका स्थान प्राप्त किया जा रहा है...',
//                                         ne: 'तपाईंको स्थान प्राप्त गरिँदैछ...',
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                         color: AppColors.textPrimary,
//                                         fontSize: AppTextSizes.caption,
//                                       ),
//                                     );
//                                   }

//                                   return Text(
//                                     controller.userLocation.value,
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       color: AppColors.textPrimary,
//                                       fontSize: AppTextSizes.caption,
//                                       fontWeight: AppFontWeights.medium,
//                                     ),
//                                   );
//                                 }),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 // ==================================================
//                 // ADD PRODUCT
//                 // ==================================================
//                 _dashboardCard(
//                   image: 'assets/shop/addproduct.png',

//                   title: AppLanguage.tr(
//                     en: 'Add Product',
//                     hi: 'उत्पाद जोड़ें',
//                     ne: 'सामान थप्नुहोस्',
//                   ),

//                   description: AppLanguage.tr(
//                     en: 'Add new products to your shop\nand let people discover them.',
//                     hi: 'अपनी दुकान में नए उत्पाद जोड़ें\nऔर लोगों को उन्हें खोजने दें।',
//                     ne: 'तपाईंको पसलमा नयाँ सामानहरू थप्नुहोस्\nर मानिसहरूलाई ती खोज्न दिनुहोस्।',
//                   ),

//                   onTap: () {
//                     Get.toNamed(AppRoutes.addProduct);
//                   },
//                 ),

//                 const SizedBox(height: 10),

//                 // ==================================================
//                 // VIEW PRODUCT
//                 // ==================================================
//                 _dashboardCard(
//                   image: 'assets/shop/viewproduct.png',

//                   title: AppLanguage.tr(
//                     en: 'View Product',
//                     hi: 'उत्पाद देखें',
//                     ne: 'सामान हेर्नुहोस्',
//                   ),

//                   description: AppLanguage.tr(
//                     en: 'View all your added\nProduct in Your Shop',
//                     hi: 'अपनी दुकान में जोड़े गए सभी\nउत्पाद देखें',
//                     ne: 'तपाईंको पसलमा थपिएका सबै\nसामानहरू हेर्नुहोस्',
//                   ),

//                   onTap: () {
//                     Get.toNamed(AppRoutes.viewProduct);
//                   },
//                 ),

//                 const SizedBox(height: 10),

//                 // ==================================================
//                 // OFFER PRODUCT
//                 // ==================================================
//                 _dashboardCard(
//                   image: 'assets/shop/offer.png',

//                   title: AppLanguage.tr(
//                     en: 'Offer Product',
//                     hi: 'ऑफ़र उत्पाद',
//                     ne: 'अफर सामान',
//                   ),

//                   description: AppLanguage.tr(
//                     en: 'Add product on offer\nand attract more customers',
//                     hi: 'ऑफ़र पर उत्पाद जोड़ें\nऔर अधिक ग्राहकों को आकर्षित करें',
//                     ne: 'अफरमा सामान थप्नुहोस्\nर थप ग्राहकहरू आकर्षित गर्नुहोस्',
//                   ),

//                   onTap: () {},
//                 ),

//                 const SizedBox(height: 5),

//                 // ==================================================
//                 // FOOTER
//                 // ==================================================
//                 Container(
//                   width: double.infinity,

//                   decoration: BoxDecoration(
//                     color: AppColors.card,
//                     borderRadius: AppRadius.rounded,
//                   ),

//                   child: Image.asset(
//                     'assets/shop/footer.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ==============================================================
//   // REUSABLE DASHBOARD CARD
//   // ==============================================================

//   Widget _dashboardCard({
//     required String image,
//     required String title,
//     required String description,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,

//       focusColor: AppColors.primary,
//       splashColor: AppColors.shophome,

//       child: Container(
//         width: double.infinity,
//         height: 200,

//         decoration: BoxDecoration(
//           color: AppColors.card,
//           borderRadius: AppRadius.rounded,
//         ),

//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,

//           children: [
//             Padding(
//               padding: AppPadding.horizontalMd,

//               child: Container(
//                 width: 150,
//                 height: 180,

//                 decoration: BoxDecoration(
//                   color: AppColors.shophome,
//                   borderRadius: AppRadius.rounded,
//                 ),

//                 child: Image.asset(image, fit: BoxFit.contain),
//               ),
//             ),

//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,

//                 children: [
//                   Text(
//                     title,
//                     textAlign: TextAlign.center,

//                     style: TextStyle(
//                       color: AppColors.primary,
//                       fontSize: AppTextSizes.h6,
//                       fontWeight: AppFontWeights.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   Text(
//                     description,
//                     textAlign: TextAlign.center,

//                     style: TextStyle(
//                       color: AppColors.textPrimary,
//                       fontSize: AppTextSizes.caption,
//                       fontWeight: AppFontWeights.medium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(width: 10),

//             Container(
//               width: 40,
//               height: 40,

//               decoration: BoxDecoration(
//                 color: AppColors.shophome,
//                 borderRadius: AppRadius.rounded,
//               ),

//               child: IconButton(
//                 onPressed: onTap,

//                 icon: Icon(
//                   Icons.arrow_forward_ios,
//                   color: AppColors.primary,
//                   size: 18,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/home/controller/dashboard_controller.dart';
import 'package:localmarket/shopkeeper/home/widget/language_dialoge.dart';
import 'package:localmarket/shopkeeper/profile/view/profile_view.dart';
import 'package:localmarket/shopkeeper/routes/app_routes.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_radius.dart';
import 'package:localmarket/widget/common_app_bar.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  // Card accent colors (green / blue / orange)
  static const _green = Color(0xFF1B7F3B);
  static const _greenBg = Color(0xFFE6F5EA);
  static const _blue = Color(0xFF1565D8);
  static const _blueBg = Color(0xFFE4F0FC);
  static const _orange = Color(0xFFF57C00);
  static const _orangeBg = Color(0xFFFFF1DF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(
        title: AppLanguage.tr(en: 'NearShop', hi: 'नियरशॉप', ne: 'नियरसप'),

        showDrawerButton: true,
        showBranding: true,
        showSupportButton: true,
        onSupportTap: () {
          // Support screen open
        },
      ),
      drawer: _buildDrawer(context),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primary,
          onRefresh: controller.refreshDashboard,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        const SizedBox(height: 14),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _shopHeaderCard(),
                        ),

                        const SizedBox(height: 16),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Expanded(
                                  child: _dashboardCard(
                                    context: context,
                                    image: 'assets/shop/addproduct.png',
                                    icon: Icons.shopping_basket_outlined,
                                    accent: _green,
                                    bg: _greenBg,
                                    title: AppLanguage.tr(
                                      en: 'Add Product',
                                      hi: 'उत्पाद जोड़ें',
                                      ne: 'सामान थप्नुहोस्',
                                    ),
                                    description: AppLanguage.tr(
                                      en: 'Add new products to your shop and let people discover them.',
                                      hi: 'अपनी दुकान में नए उत्पाद जोड़ें और लोगों को उन्हें खोजने दें।',
                                      ne: 'तपाईंको पसलमा नयाँ सामानहरू थप्नुहोस् र मानिसहरूलाई ती खोज्न दिनुहोस्।',
                                    ),
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.addProduct),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: _dashboardCard(
                                    context: context,
                                    image: 'assets/shop/viewproduct.png',
                                    icon: Icons.visibility_outlined,
                                    accent: _blue,
                                    bg: _blueBg,
                                    title: AppLanguage.tr(
                                      en: 'View Product',
                                      hi: 'उत्पाद देखें',
                                      ne: 'सामान हेर्नुहोस्',
                                    ),
                                    description: AppLanguage.tr(
                                      en: 'View all your added products in your shop.',
                                      hi: 'अपनी दुकान में जोड़े गए सभी उत्पाद देखें।',
                                      ne: 'तपाईंको पसलमा थपिएका सबै सामानहरू हेर्नुहोस्।',
                                    ),
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.viewProduct),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: _dashboardCard(
                                    context: context,
                                    image: 'assets/shop/offer.png',
                                    icon: Icons.card_giftcard_outlined,
                                    accent: _orange,
                                    bg: _orangeBg,
                                    title: AppLanguage.tr(
                                      en: 'Offer Product',
                                      hi: 'ऑफ़र उत्पाद',
                                      ne: 'अफर सामान',
                                    ),
                                    description: AppLanguage.tr(
                                      en: 'Add products on offer and attract more customers.',
                                      hi: 'ऑफ़र पर उत्पाद जोड़ें और अधिक ग्राहकों को आकर्षित करें।',
                                      ne: 'अफरमा सामान थप्नुहोस् र थप ग्राहकहरू आकर्षित गर्नुहोस्।',
                                    ),
                                    onTap: () {
                                      Get.toNamed(AppRoutes.offerProduct);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

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
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _shopHeaderCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B7F3B), Color(0xFF0F5A28)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: _green.withOpacity(0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -40,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            left: -25,
            bottom: -25,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Avatar with ring
                    Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/shop/homelogo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              AppLanguage.tr(
                                en: 'Welcome back 👋',
                                hi: 'वापसी पर स्वागत है 👋',
                                ne: 'फेरि स्वागत छ 👋',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppTextSizes.caption,
                                fontWeight: AppFontWeights.medium,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Obx(() {
                            final name = controller.shopName.value;
                            return Text(
                              name.isEmpty
                                  ? AppLanguage.tr(
                                      en: 'Your Shop',
                                      hi: 'आपकी दुकान',
                                      ne: 'तपाईंको पसल',
                                    )
                                  : name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppTextSizes.h5,
                                fontWeight: AppFontWeights.bold,
                                letterSpacing: 0.3,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Location pill (glass style)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(6, 6, 14, 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withOpacity(0.28)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: _green,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoadingLocation.value) {
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    AppLanguage.tr(
                                      en: 'Getting location...',
                                      hi: 'स्थान प्राप्त हो रहा है...',
                                      ne: 'स्थान प्राप्त हुँदैछ...',
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: AppTextSizes.caption,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Text(
                            controller.userLocation.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: AppTextSizes.caption,
                              fontWeight: AppFontWeights.medium,
                              height: 1.3,
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
        ],
      ),
    );
  }

  Widget _dashboardCard({
    required BuildContext context,
    required String image,
    required IconData icon,
    required Color accent,
    required Color bg,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    final imgWidth = MediaQuery.of(context).size.width * 0.30;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.14),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: accent.withOpacity(0.15),
          highlightColor: accent.withOpacity(0.06),
          child: Row(
            children: [
              // Image box
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: imgWidth,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Center(child: Image.asset(image, fit: BoxFit.contain)),
                ),
              ),

              // Text
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(icon, color: accent, size: 16),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: accent,
                                fontSize: AppTextSizes.button,
                                fontWeight: AppFontWeights.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppTextSizes.caption,
                        fontWeight: AppFontWeights.medium,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary),
            child: Row(
              children: [
                const Icon(
                  Icons.storefront_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLanguage.tr(en: 'NearShop', hi: 'नियरशॉप', ne: 'नियरसप'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppTextSizes.h5,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(
            Icons.dashboard_outlined,
            AppLanguage.tr(en: 'Dashboard', hi: 'डैशबोर्ड', ne: 'ड्यासबोर्ड'),
            () => Get.back(),
          ),
          _drawerItem(
            Icons.person_outline,
            AppLanguage.tr(en: 'Profile', hi: 'प्रोफ़ाइल', ne: 'प्रोफाइल'),
            () {
              // Navigate to profile screen
              Get.to(() => const ProfileView());
            },
          ),
          _drawerItem(
            Icons.translate_outlined,
            AppLanguage.tr(en: 'Language', hi: 'भाषा', ne: 'भाषा'),
            () {
              LanguageDialog.show(context);
            },
          ),
          _drawerItem(
            Icons.help_outline,
            AppLanguage.tr(
              en: 'Help and Support',
              hi: 'सहायता और समर्थन',
              ne: 'मद्दत र समर्थन',
            ),
            () {},
          ),
          const Divider(),
          _drawerItem(
            Icons.logout_outlined,
            AppLanguage.tr(en: 'Logout', hi: 'लॉग आउट', ne: 'लगआउट'),
            () => controller.logout(),
            color: AppColors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    IconData icon,
    String label,
    VoidCallback onTap, {
    Color? color,
  }) {
    final c = color ?? AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: c),
      title: Text(
        label,
        style: TextStyle(color: c, fontSize: AppTextSizes.button),
      ),
      onTap: onTap,
    );
  }
}
