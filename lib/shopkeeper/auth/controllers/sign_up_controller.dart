import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/model/shopkeeper_model.dart';
import 'package:localmarket/widget/app_language.dart';

class PartnerSignUpController extends GetxController {
  // ============================================================
  // TEXT CONTROLLERS
  // ============================================================

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController storeNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // ============================================================
  // REACTIVE VARIABLES
  // ============================================================

  final RxList<String> selectedCategories = <String>[].obs;

  final RxBool isPasswordVisible = false.obs;

  final RxBool isLoading = false.obs;

  // ============================================================
  // SHOP CATEGORIES
  // ============================================================

  final List<Map<String, String>> shopCategories = [
    {
      'en': 'Grocery & General Store',
      'hi': 'किराना एवं जनरल स्टोर',
      'ne': 'किराना तथा जनरल स्टोर',
    },
    {
      'en': 'Fruits & Vegetables',
      'hi': 'फल एवं सब्ज़ियाँ',
      'ne': 'फलफूल तथा तरकारी',
    },
    {
      'en': 'Dairy & Milk Products',
      'hi': 'डेयरी एवं दूध उत्पाद',
      'ne': 'डेरी तथा दूधजन्य पदार्थ',
    },
    {'en': 'Bakery & Sweets', 'hi': 'बेकरी एवं मिठाई', 'ne': 'बेकरी तथा मिठाई'},
    {'en': 'Clothing & Fashion', 'hi': 'कपड़े एवं फैशन', 'ne': 'कपडा तथा फेसन'},
    {'en': 'Footwear', 'hi': 'जूते-चप्पल', 'ne': 'जुत्ता-चप्पल'},
    {
      'en': 'Pharmacy & Medical',
      'hi': 'दवा एवं मेडिकल',
      'ne': 'औषधि तथा मेडिकल',
    },
    {'en': 'Electronics', 'hi': 'इलेक्ट्रॉनिक्स', 'ne': 'इलेक्ट्रोनिक्स'},
    {
      'en': 'Mobile & Accessories',
      'hi': 'मोबाइल एवं एक्सेसरीज़',
      'ne': 'मोबाइल तथा एक्सेसरिज',
    },
    {
      'en': 'Hardware & Electrical',
      'hi': 'हार्डवेयर एवं इलेक्ट्रिकल',
      'ne': 'हार्डवेयर तथा विद्युतीय सामान',
    },
    {
      'en': 'Stationery & Books',
      'hi': 'स्टेशनरी एवं किताबें',
      'ne': 'स्टेशनरी तथा किताबहरू',
    },
    {
      'en': 'Cosmetics & Personal Care',
      'hi': 'कॉस्मेटिक्स एवं पर्सनल केयर',
      'ne': 'कस्मेटिक्स तथा व्यक्तिगत हेरचाह',
    },
    {
      'en': 'Home & Kitchen',
      'hi': 'घर एवं रसोई सामान',
      'ne': 'घर तथा भान्सा सामान',
    },
    {'en': 'Meat & Fish', 'hi': 'मांस एवं मछली', 'ne': 'मासु तथा माछा'},
    {'en': 'Toys & Gifts', 'hi': 'खिलौने एवं उपहार', 'ne': 'खेलौना तथा उपहार'},
    {'en': 'Flowers & Plants', 'hi': 'फूल एवं पौधे', 'ne': 'फूल तथा बिरुवा'},
    {'en': 'Other', 'hi': 'अन्य', 'ne': 'अन्य'},
  ];

  // ============================================================
  // PASSWORD VISIBILITY
  // ============================================================

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // ============================================================
  // CATEGORIES
  // ============================================================

  void setCategories(List<String> categories) {
    selectedCategories.assignAll(categories);
  }

  void removeCategory(String category) {
    selectedCategories.remove(category);
  }

  // ============================================================
  // CATEGORY NAME
  // ============================================================

  String getCategoryName(String categoryEn) {
    final category = shopCategories.firstWhere(
      (item) => item['en'] == categoryEn,
      orElse: () => {'en': categoryEn, 'hi': categoryEn, 'ne': categoryEn},
    );

    return AppLanguage.tr(
      en: category['en']!,
      hi: category['hi']!,
      ne: category['ne']!,
    );
  }

  // ============================================================
  // REGISTER SHOPKEEPER
  // ============================================================

  Future<String?> registerShopkeeper() async {
    // ----------------------------------------------------------
    // VALIDATION
    // ----------------------------------------------------------

    if (fullNameController.text.trim().isEmpty) {
      return AppLanguage.tr(
        en: 'Full name is required',
        hi: 'पूरा नाम आवश्यक है',
        ne: 'पूरा नाम आवश्यक छ',
      );
    }

    if (emailController.text.trim().isEmpty) {
      return AppLanguage.tr(
        en: 'Email is required',
        hi: 'ईमेल आवश्यक है',
        ne: 'इमेल आवश्यक छ',
      );
    }

    if (storeNameController.text.trim().isEmpty) {
      return AppLanguage.tr(
        en: 'Store name is required',
        hi: 'स्टोर का नाम आवश्यक है',
        ne: 'स्टोरको नाम आवश्यक छ',
      );
    }

    if (selectedCategories.isEmpty) {
      return AppLanguage.tr(
        en: 'Please select at least one category',
        hi: 'कृपया कम से कम एक श्रेणी चुनें',
        ne: 'कृपया कम्तीमा एउटा वर्ग छान्नुहोस्',
      );
    }

    if (passwordController.text.length < 8) {
      return AppLanguage.tr(
        en: 'Password must be at least 8 characters',
        hi: 'पासवर्ड कम से कम 8 अक्षरों का होना चाहिए',
        ne: 'पासवर्ड कम्तीमा ८ अक्षरको हुनुपर्छ',
      );
    }

    // ----------------------------------------------------------
    // LOADING
    // ----------------------------------------------------------

    isLoading.value = true;

    try {
      // --------------------------------------------------------
      // CREATE FIREBASE AUTH ACCOUNT
      // --------------------------------------------------------

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = credential.user;

      if (user == null) {
        return AppLanguage.tr(
          en: 'Unable to create account',
          hi: 'अकाउंट नहीं बनाया जा सका',
          ne: 'खाता सिर्जना गर्न सकिएन',
        );
      }

      // --------------------------------------------------------
      // CREATE SHOPKEEPER MODEL
      // --------------------------------------------------------

      final model = ShopkeeperModel(
        uid: user.uid,
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        storeName: storeNameController.text.trim(),
        categories: selectedCategories.toList(),
        role: 'partner',
      );

      // --------------------------------------------------------
      // SAVE TO FIRESTORE
      // --------------------------------------------------------

      await FirebaseFirestore.instance
          .collection('shopkeepers')
          .doc(user.uid)
          .set({...model.toMap(), 'createdAt': FieldValue.serverTimestamp()});

      return null;
    } on FirebaseAuthException catch (e) {
      // --------------------------------------------------------
      // FIREBASE AUTH ERRORS
      // --------------------------------------------------------

      switch (e.code) {
        case 'email-already-in-use':
          return AppLanguage.tr(
            en: 'This email is already registered.',
            hi: 'यह ईमेल पहले से पंजीकृत है।',
            ne: 'यो इमेल पहिले नै दर्ता गरिएको छ।',
          );

        case 'weak-password':
          return AppLanguage.tr(
            en: 'Password is too weak.',
            hi: 'पासवर्ड बहुत कमजोर है।',
            ne: 'पासवर्ड धेरै कमजोर छ।',
          );

        case 'invalid-email':
          return AppLanguage.tr(
            en: 'Invalid email address.',
            hi: 'अमान्य ईमेल पता।',
            ne: 'अमान्य इमेल ठेगाना।',
          );

        default:
          return e.message ??
              AppLanguage.tr(
                en: 'Registration failed',
                hi: 'पंजीकरण विफल रहा',
                ne: 'दर्ता असफल भयो',
              );
      }
    } catch (e) {
      return AppLanguage.tr(
        en: 'Something went wrong',
        hi: 'कुछ गलत हो गया',
        ne: 'केही गलत भयो',
      );
    } finally {
      // --------------------------------------------------------
      // STOP LOADING
      // --------------------------------------------------------

      isLoading.value = false;
    }
  }

  // ============================================================
  // CLEANUP
  // ============================================================

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    storeNameController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}
