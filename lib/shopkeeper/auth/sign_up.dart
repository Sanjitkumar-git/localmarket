import 'package:flutter/material.dart';
import 'package:localmarket/shopkeeper/auth/sign_in.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_radius.dart';

class PartnerSignUpPage extends StatefulWidget {
  const PartnerSignUpPage({super.key});

  @override
  State<PartnerSignUpPage> createState() => _PartnerSignUpPageState();
}

class _PartnerSignUpPageState extends State<PartnerSignUpPage> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController storeNameController = TextEditingController();

  List<String> selectedCategories = [];

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

  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    storeNameController.dispose();
    _passwordController.dispose();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: AppPadding.card,
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: AppPadding.xs,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.storefront_outlined,
                                color: AppColors.primary,
                                size: 50,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            AppLanguage.tr(
                              en: 'Join NearShop',
                              hi: 'नियरशॉप से जुड़ें',
                              ne: 'नियरशपमा सामेल हुनुहोस्',
                            ),
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppTextSizes.h6,
                              fontWeight: AppFontWeights.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Padding(
                            padding: AppPadding.horizontalMd,
                            child: Text(
                              AppLanguage.tr(
                                en: 'Start managing your store today',
                                hi: 'आज ही अपने स्टोर को मैनेज करना शुरू करें।',
                                ne: 'आजै आफ्नो स्टोर व्यवस्थापन गर्न सुरु गर्नुहोस्।',
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppTextSizes.md,
                                fontWeight: AppFontWeights.regular,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Padding(
                            padding: AppPadding.horizontalMd,
                            child: TextField(
                              controller: fullNameController,
                              style: TextStyle(color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                labelText: AppLanguage.tr(
                                  en: 'Full Name',
                                  hi: 'पूरा नाम',
                                  ne: 'पुरा नाम',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Padding(
                            padding: AppPadding.horizontalMd,
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                labelText: AppLanguage.tr(
                                  en: 'Business Email',
                                  hi: 'बिज़नेस ईमेल',
                                  ne: 'व्यापार इमेल',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Padding(
                            padding: AppPadding.horizontalMd,
                            child: TextField(
                              controller: storeNameController,
                              style: TextStyle(color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                labelText: AppLanguage.tr(
                                  en: 'Store Name',
                                  hi: 'स्टोर नाम',
                                  ne: 'दुकानको नाम',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Padding(
                            padding: AppPadding.horizontalMd,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: _selectShopCategories,
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: AppLanguage.tr(
                                    en: 'Shop Categories',
                                    hi: 'दुकान की श्रेणियाँ',
                                    ne: 'पसलका वर्गहरू',
                                  ),
                                  labelStyle: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
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
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: AppPadding.horizontalMd,

                            child: TextFormField(
                              controller: _passwordController,

                              obscureText: !_isPasswordVisible,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLanguage.tr(
                                    en: 'Password is required',
                                    hi: 'पासवर्ड आवश्यक है',
                                    ne: 'पासवर्ड आवश्यक छ',
                                  );
                                }

                                if (value.length < 8) {
                                  return AppLanguage.tr(
                                    en: 'Password must be at least 8 characters',
                                    hi: 'पासवर्ड कम से कम 8 अक्षरों का होना चाहिए',
                                    ne: 'पासवर्ड कम्तीमा ८ अक्षरको हुनुपर्छ',
                                  );
                                }

                                return null;
                              },

                              style: TextStyle(color: AppColors.textPrimary),

                              decoration: InputDecoration(
                                labelText: AppLanguage.tr(
                                  en: 'Password',
                                  hi: 'पासवर्ड',
                                  ne: 'पासवर्ड',
                                ),

                                labelStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: AppRadius.medium,
                                ),

                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },

                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,

                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: AppPadding.horizontalMd,

                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLanguage.tr(
                                  en: 'Must be at least 8 characters',
                                  hi: 'कम से कम 8 कैरेक्टर होने चाहिए।',
                                  ne: 'कम्तीमा ८ अक्षरको हुनु पर्छ।',
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: 330,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                AppLanguage.tr(
                                  en: 'Register Store',
                                  hi: 'स्टोर रजिस्टर करें',
                                  ne: 'दर्ता पसल',
                                ),
                                style: TextStyle(
                                  color: AppColors.tertiary,
                                  fontSize: AppTextSizes.xl,
                                  fontWeight: AppFontWeights.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: AppColors.primary),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartnerSignInPage(),
                        ),
                      );
                    },
                    child: Text(
                      AppLanguage.tr(
                        en: 'Already have a store? Sign in',
                        hi: 'पहले से स्टोर है? साइन इन करें',
                        ne: 'पहिले नै स्टोर छ? साइन इन गर्नुहोस्',
                      ),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: AppTextSizes.md,
                        fontWeight: AppFontWeights.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
