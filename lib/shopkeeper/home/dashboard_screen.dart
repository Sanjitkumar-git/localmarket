import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_radius.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:localmarket/services/location_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userLocation = "Choose your location";
  bool isLoadingLocation = true;
  String shopName = 'My Store';

  Future<void> getUserLocation() async {
    try {
      final address = await LocationService.getCurrentAddress();
      print("Address result: $address"); // console mein dekh
      if (!mounted) return;
      setState(() {
        userLocation = address ?? "Not found / Null";
        isLoadingLocation = false;
      });
    } catch (e) {
      print("Location error: $e");
      setState(() => isLoadingLocation = false);
    }
  }

  Future<void> loadShopName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (!mounted) return;

      if (doc.exists) {
        setState(() {
          shopName = doc.data()?['storeName'] ?? 'My Store';
        });
      }
    } catch (e) {
      debugPrint('Shop name error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
    loadShopName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,

        iconTheme: IconThemeData(color: AppColors.white, size: 28),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),

          child: Row(
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
                    size: 18,
                  ),
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
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.dashboard_outlined,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppLanguage.tr(
                      en: 'Dashboard',
                      hi: 'डैशबोर्ड', // ya 'नियंत्रण कक्ष'
                      ne: 'ड्यासबोर्ड', // ya 'ड्यासबोर्ड'
                    ),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.regular,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.person_outlined,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppLanguage.tr(
                      en: 'Profile',
                      hi: 'प्रोफ़ाइल',
                      ne: 'प्रोफाइल',
                    ),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.regular,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.language_outlined,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppLanguage.tr(en: 'Language', hi: 'भाषा', ne: 'भाषा'),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.regular,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppLanguage.tr(
                      en: 'Help and Support',
                      hi: 'सहायता और समर्थन',
                      ne: 'मद्दत र समर्थन',
                    ),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.regular,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppLanguage.tr(en: 'Logout', hi: 'लॉग आउट', ne: 'लगआउट'),
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.regular,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: AppPadding.verticalMd,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
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
                            Text(
                              shopName,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppTextSizes.h5,
                                fontWeight: AppFontWeights.bold,
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
                              child: Text(
                                isLoadingLocation
                                    ? AppLanguage.tr(
                                        en: 'Getting your location...',
                                        hi: 'आपका स्थान प्राप्त किया जा रहा है...',
                                        ne: 'तपाईंको स्थान प्राप्त गरिँदैछ...',
                                      )
                                    : userLocation,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: AppTextSizes.caption,
                                  fontWeight: AppFontWeights.medium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                focusColor: AppColors.primary,
                splashColor: AppColors.shophome,
                onTap: () {},
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
                          child: Image.asset('assets/shop/addproduct.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLanguage.tr(
                              en: 'Add Product',
                              hi: 'उत्पाद जोड़ें',
                              ne: 'सामान थप्नुहोस्',
                            ),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: AppTextSizes.h6,
                              fontWeight: AppFontWeights.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            AppLanguage.tr(
                              en: 'Add new products to your shop\nand let people discover them.',
                              hi: 'अपनी दुकान में नए उत्पाद जोड़ें\nऔर लोगों को उन्हें खोजने दें।',
                              ne: 'तपाईंको पसलमा नयाँ सामानहरू थप्नुहोस्\nर मानिसहरूलाई ती खोज्न दिनुहोस्।',
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppTextSizes.caption,
                              fontWeight: AppFontWeights.medium,
                            ),
                          ),
                        ],
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                focusColor: AppColors.primary,
                splashColor: AppColors.shophome,
                onTap: () {},
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
                          child: Image.asset('assets/shop/viewproduct.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLanguage.tr(
                              en: 'View Product',
                              hi: 'उत्पाद देखें',
                              ne: 'सामान हेर्नुहोस्',
                            ),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: AppTextSizes.h6,
                              fontWeight: AppFontWeights.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            AppLanguage.tr(
                              en: 'View all your added \nProduct in Your Shop',
                              hi: 'अपनी दुकान में जोड़े गए सभी \nउत्पाद देखें',
                              ne: 'तपाईंको पसलमा थपिएका सबै \nसामानहरू हेर्नुहोस्',
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppTextSizes.caption,
                              fontWeight: AppFontWeights.medium,
                            ),
                          ),
                        ],
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                focusColor: AppColors.primary,
                splashColor: AppColors.shophome,
                onTap: () {},
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
                          child: Image.asset('assets/shop/offer.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLanguage.tr(
                              en: 'Offer Product',
                              hi: 'ऑफ़र उत्पाद',
                              ne: 'अफर सामान',
                            ),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: AppTextSizes.h6,
                              fontWeight: AppFontWeights.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            AppLanguage.tr(
                              en: 'Add product on offer \nand attract more customers',
                              hi: 'ऑफ़र पर उत्पाद जोड़ें \nऔर अधिक ग्राहकों को आकर्षित करें',
                              ne: 'अफरमा सामान थप्नुहोस् \nर थप ग्राहकहरू आकर्षित गर्नुहोस्',
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppTextSizes.caption,
                              fontWeight: AppFontWeights.medium,
                            ),
                          ),
                        ],
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,

                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: AppRadius.rounded,
                ),
                child: Image.asset('assets/shop/footer.png', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
