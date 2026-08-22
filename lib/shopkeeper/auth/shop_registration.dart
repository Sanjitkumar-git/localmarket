import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localmarket/shopkeeper/home/dashboard_screen.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_radius.dart';

class ShopRegistrationPage extends StatefulWidget {
  final User user;

  const ShopRegistrationPage({super.key, required this.user});

  @override
  State<ShopRegistrationPage> createState() => _ShopRegistrationPageState();
}

class _ShopRegistrationPageState extends State<ShopRegistrationPage> {
  final TextEditingController storeNameController = TextEditingController();
  List<String> selectedCategories = [];
  bool _isLoading = false;

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

  @override
  void dispose() {
    storeNameController.dispose();
    super.dispose();
  }

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

  Future<void> _selectShopCategories() async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        List<String> tempSelected = [...selectedCategories];

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLanguage.tr(
                                en: 'Select Shop Categories',
                                hi: 'दुकान की श्रेणियाँ चुनें',
                                ne: 'पसलका वर्गहरू छान्नुहोस्',
                              ),
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppTextSizes.lg,
                                fontWeight: AppFontWeights.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLanguage.tr(
                            en: '${tempSelected.length} categories selected',
                            hi: '${tempSelected.length} श्रेणियाँ चुनी गईं',
                            ne: '${tempSelected.length} वर्गहरू चयन गरियो',
                          ),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextSizes.sm,
                            fontWeight: AppFontWeights.regular,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: shopCategories.length,
                          itemBuilder: (context, index) {
                            final category = shopCategories[index];
                            final String categoryEn = category['en']!;
                            final String categoryName = AppLanguage.tr(
                              en: category['en']!,
                              hi: category['hi']!,
                              ne: category['ne']!,
                            );
                            final bool isSelected = tempSelected.contains(
                              categoryEn,
                            );

                            return CheckboxListTile(
                              value: isSelected,
                              activeColor: AppColors.primary,
                              checkColor: AppColors.tertiary,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                categoryName,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: AppTextSizes.md,
                                  fontWeight: AppFontWeights.regular,
                                ),
                              ),
                              onChanged: (value) {
                                setModalState(() {
                                  if (value == true) {
                                    if (!tempSelected.contains(categoryEn)) {
                                      tempSelected.add(categoryEn);
                                    }
                                  } else {
                                    tempSelected.remove(categoryEn);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, tempSelected);
                          },
                          child: Text(
                            AppLanguage.tr(
                              en: 'Done',
                              hi: 'हो गया',
                              ne: 'सम्पन्न',
                            ),
                            style: TextStyle(
                              color: AppColors.tertiary,
                              fontSize: AppTextSizes.md,
                              fontWeight: AppFontWeights.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedCategories = result;
      });
    }
  }

  void _showMessage(String message, {bool isError = true}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Future<void> _registerShop() async {
    FocusScope.of(context).unfocus();

    // Validation
    if (storeNameController.text.trim().isEmpty) {
      _showMessage(
        AppLanguage.tr(
          en: 'Please enter store name',
          hi: 'कृपया दुकान का नाम दर्ज करें',
          ne: 'कृपया दुकानको नाम दर्ज गर्नुहोस्',
        ),
      );
      return;
    }

    if (selectedCategories.isEmpty) {
      _showMessage(
        AppLanguage.tr(
          en: 'Please select at least one category',
          hi: 'कृपया कम से कम एक श्रेणी चुनें',
          ne: 'कृपया कम्तीमा एक श्रेणी चयन गर्नुहोस्',
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Save shop details to Firestore
      await FirebaseFirestore.instance
          .collection('shopkeepers')
          .doc(widget.user.uid)
          .set({
            'fullName': widget.user.displayName ?? 'User',
            'email': widget.user.email,
            'storeName': storeNameController.text.trim(),
            'categories': selectedCategories,
            'role': 'partner',
            'createdAt': FieldValue.serverTimestamp(),
            'profileImage': widget.user.photoURL,
          });

      if (!mounted) return;

      _showMessage(
        AppLanguage.tr(
          en: 'Shop registered successfully',
          hi: 'दुकान सफलतापूर्वक पंजीकृत हुई',
          ne: 'दुकान सफलतापूर्वक दर्ता भयो',
        ),
        isError: false,
      );

      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } catch (error) {
      _showMessage(error.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    height: 68,
                    width: 68,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.storefront_outlined,
                      color: AppColors.primary,
                      size: 38,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLanguage.tr(
                      en: 'Complete Your Shop Setup',
                      hi: 'अपनी दुकान की स्थापना पूरी करें',
                      ne: 'आफ्नो दुकान सेटअप पूरा गर्नुहोस्',
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.h6,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLanguage.tr(
                      en: 'Please provide shop details to continue',
                      hi: 'जारी रखने के लिए कृपया दुकान का विवरण प्रदान करें',
                      ne: 'जारी राख्नको लागि कृपया दुकानको विवरण प्रदान गर्नुहोस्',
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextSizes.md,
                      fontWeight: AppFontWeights.regular,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.white.withOpacity(0.7)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 24,
                          spreadRadius: 1,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Display User Email
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  widget.user.email ?? 'No email',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: AppTextSizes.md,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Store Name
                        TextField(
                          controller: storeNameController,
                          style: TextStyle(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            labelText: AppLanguage.tr(
                              en: 'Store Name',
                              hi: 'स्टोर नाम',
                              ne: 'दुकानको नाम',
                            ),
                            labelStyle: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppTextSizes.md,
                            ),
                            prefixIcon: Icon(
                              Icons.storefront_outlined,
                              color: AppColors.primary,
                            ),
                            filled: true,
                            fillColor: AppColors.background,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Categories
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: _selectShopCategories,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: AppLanguage.tr(
                                en: 'Shop Categories',
                                hi: 'दुकान की श्रेणियाँ',
                                ne: 'पसलका वर्गहरू',
                              ),
                              labelStyle: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppTextSizes.md,
                              ),
                              prefixIcon: Icon(
                                Icons.category_outlined,
                                color: AppColors.primary,
                              ),
                              filled: true,
                              fillColor: AppColors.background,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                  width: 1.8,
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            child: selectedCategories.isEmpty
                                ? Text(
                                    AppLanguage.tr(
                                      en: 'Select Categories',
                                      hi: 'श्रेणियाँ चुनें',
                                      ne: 'वर्गहरू छान्नुहोस्',
                                    ),
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: AppTextSizes.md,
                                    ),
                                  )
                                : Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: selectedCategories.map((
                                      categoryEn,
                                    ) {
                                      return Chip(
                                        label: Text(
                                          getCategoryName(categoryEn),
                                          style: TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: AppTextSizes.sm,
                                          ),
                                        ),
                                        deleteIcon: const Icon(
                                          Icons.close,
                                          size: 16,
                                        ),
                                        onDeleted: () {
                                          setState(() {
                                            selectedCategories.remove(
                                              categoryEn,
                                            );
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _registerShop,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primary,
                              disabledBackgroundColor: AppColors.primary
                                  .withOpacity(0.65),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: _isLoading
                                  ? const SizedBox(
                                      key: ValueKey('loader'),
                                      width: 23,
                                      height: 23,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      AppLanguage.tr(
                                        en: 'Complete Setup',
                                        hi: 'सेटअप पूरा करें',
                                        ne: 'सेटअप पूरा गर्नुहोस्',
                                      ),
                                      key: const ValueKey('register_text'),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.tertiary,
                                        fontSize: AppTextSizes.xl,
                                        fontWeight: AppFontWeights.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
