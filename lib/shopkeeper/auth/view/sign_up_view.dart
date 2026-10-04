import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/shopkeeper/auth/controllers/sign_up_controller.dart';
import 'package:localmarket/shopkeeper/auth/sign_in.dart';

import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_radius.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  Future<void> _selectShopCategories(
    BuildContext context,
    PartnerSignUpController controller,
  ) async {
    final List<String> tempSelected = List<String>.from(
      controller.selectedCategories,
    );

    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      builder: (context) {
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
                            onPressed: () => Navigator.pop(context),
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
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.shopCategories.length,
                          itemBuilder: (context, index) {
                            final category = controller.shopCategories[index];

                            final categoryEn = category['en']!;

                            final categoryName = AppLanguage.tr(
                              en: category['en']!,
                              hi: category['hi']!,
                              ne: category['ne']!,
                            );

                            final isSelected = tempSelected.contains(
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
      controller.setCategories(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PartnerSignUpController>();

    return Scaffold(
      backgroundColor: AppColors.background,

      // Full available screen
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),

              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),

                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // =========================
                        // HEADER IMAGE
                        // =========================
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: SizedBox(
                            width: double.infinity,
                            height: 290,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/shop/signup.jpg',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),

                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.05),
                                        Colors.black.withOpacity(0.45),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 18,
                                  left: 18,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.45),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.35),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.storefront_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),

                                        const SizedBox(width: 7),

                                        Text(
                                          AppLanguage.tr(
                                            en: 'Create Account',
                                            hi: 'खाता बनाएँ',
                                            ne: 'खाता सिर्जना गर्नुहोस्',
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppTextSizes.md,
                                            fontWeight: AppFontWeights.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // =========================
                        // FORM CARD
                        // =========================
                        Container(
                          margin: const EdgeInsets.only(top: 253),
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),

                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.7),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 24,
                                spreadRadius: 1,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),

                          child: Form(
                            child: Column(
                              children: [
                                // =========================
                                // ICON
                                // =========================
                                Icon(
                                  Icons.storefront_outlined,
                                  color: AppColors.primary,
                                  size: 50,
                                ),

                                const SizedBox(height: 10),

                                // =========================
                                // TITLE
                                // =========================
                                Text(
                                  AppLanguage.tr(
                                    en: 'Join NearShop',
                                    hi: 'नियरशॉप से जुड़ें',
                                    ne: 'नियरशपमा सामेल हुनुहोस्',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: AppTextSizes.h6,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  AppLanguage.tr(
                                    en: 'Start managing your store today',
                                    hi: 'आज ही अपने स्टोर को मैनेज करना शुरू करें।',
                                    ne: 'आजै आफ्नो स्टोर व्यवस्थापन गर्न सुरु गर्नुहोस्।',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: AppTextSizes.md,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // =========================
                                // FULL NAME
                                // =========================
                                TextField(
                                  controller: controller.fullNameController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLanguage.tr(
                                      en: 'Full Name',
                                      hi: 'पूरा नाम',
                                      ne: 'पुरा नाम',
                                    ),
                                    labelStyle: TextStyle(
                                      color: AppColors.textPrimary,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: AppColors.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 15),

                                // =========================
                                // EMAIL
                                // =========================
                                TextField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLanguage.tr(
                                      en: 'Business Email',
                                      hi: 'बिज़नेस ईमेल',
                                      ne: 'व्यापार इमेल',
                                    ),
                                    labelStyle: TextStyle(
                                      color: AppColors.textPrimary,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: AppColors.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 15),

                                // =========================
                                // STORE NAME
                                // =========================
                                TextField(
                                  controller: controller.storeNameController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLanguage.tr(
                                      en: 'Store Name',
                                      hi: 'स्टोर नाम',
                                      ne: 'दुकानको नाम',
                                    ),
                                    labelStyle: TextStyle(
                                      color: AppColors.textPrimary,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.store_outlined,
                                      color: AppColors.primary,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 15),

                                // =========================
                                // CATEGORIES
                                // =========================
                                // InkWell(
                                //   borderRadius: BorderRadius.circular(8),
                                //   onTap: () {
                                //     _selectShopCategories(context, controller);
                                //   },
                                //   child: InputDecorator(
                                //     decoration: InputDecoration(
                                //       labelText: AppLanguage.tr(
                                //         en: 'Shop Categories',
                                //         hi: 'दुकान की श्रेणियाँ',
                                //         ne: 'पसलका वर्गहरू',
                                //       ),
                                //       labelStyle: TextStyle(
                                //         color: AppColors.textPrimary,
                                //       ),
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(8),
                                //       ),
                                //       suffixIcon: Icon(
                                //         Icons.arrow_drop_down,
                                //         color: AppColors.textPrimary,
                                //       ),
                                //     ),
                                //     child: controller.selectedCategories.isEmpty
                                //         ? Text(
                                //             AppLanguage.tr(
                                //               en: 'Select Categories',
                                //               hi: 'श्रेणियाँ चुनें',
                                //               ne: 'वर्गहरू छान्नुहोस्',
                                //             ),
                                //             style: TextStyle(
                                //               color: AppColors.textSecondary,
                                //               fontSize: AppTextSizes.md,
                                //             ),
                                //           )
                                //         : Wrap(
                                //             spacing: 6,
                                //             runSpacing: 6,
                                //             children: controller
                                //                 .selectedCategories
                                //                 .map((categoryEn) {
                                //                   return Chip(
                                //                     label: Text(
                                //                       controller
                                //                           .getCategoryName(
                                //                             categoryEn,
                                //                           ),
                                //                       style: TextStyle(
                                //                         color: AppColors
                                //                             .textPrimary,
                                //                         fontSize:
                                //                             AppTextSizes.sm,
                                //                       ),
                                //                     ),
                                //                     deleteIcon: const Icon(
                                //                       Icons.close,
                                //                       size: 16,
                                //                     ),
                                //                     onDeleted: () {
                                //                       controller.removeCategory(
                                //                         categoryEn,
                                //                       );
                                //                     },
                                //                   );
                                //                 })
                                //                 .toList(),
                                //           ),
                                //   ),
                                // ),
                                Obx(
                                  () => InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      _selectShopCategories(
                                        context,
                                        controller,
                                      );
                                    },
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
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),

                                      child:
                                          controller.selectedCategories.isEmpty
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
                                              children: controller
                                                  .selectedCategories
                                                  .map((categoryEn) {
                                                    return Chip(
                                                      label: Text(
                                                        controller
                                                            .getCategoryName(
                                                              categoryEn,
                                                            ),
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .textPrimary,
                                                          fontSize:
                                                              AppTextSizes.sm,
                                                        ),
                                                      ),
                                                      deleteIcon: const Icon(
                                                        Icons.close,
                                                        size: 16,
                                                      ),
                                                      onDeleted: () {
                                                        controller
                                                            .removeCategory(
                                                              categoryEn,
                                                            );
                                                      },
                                                    );
                                                  })
                                                  .toList(),
                                            ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 15),

                                // =========================
                                // PASSWORD
                                // =========================
                                Obx(
                                  () => TextFormField(
                                    controller: controller.passwordController,

                                    obscureText:
                                        !controller.isPasswordVisible.value,

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

                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                    ),

                                    decoration: InputDecoration(
                                      labelText: AppLanguage.tr(
                                        en: 'Password',
                                        hi: 'पासवर्ड',
                                        ne: 'पासवर्ड',
                                      ),

                                      labelStyle: TextStyle(
                                        color: AppColors.textPrimary,
                                      ),

                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: AppColors.primary,
                                      ),

                                      border: OutlineInputBorder(
                                        borderRadius: AppRadius.medium,
                                      ),

                                      suffixIcon: IconButton(
                                        onPressed:
                                            controller.togglePasswordVisibility,
                                        icon: Icon(
                                          controller.isPasswordVisible.value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppLanguage.tr(
                                      en: 'Must be at least 8 characters',
                                      hi: 'कम से कम 8 कैरेक्टर होने चाहिए।',
                                      ne: 'कम्तीमा ८ अक्षरको हुनु पर्छ।',
                                    ),
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: AppTextSizes.sm,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // =========================
                                // REGISTER BUTTON
                                // =========================
                                Obx(
                                  () => SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        disabledBackgroundColor: AppColors
                                            .primary
                                            .withOpacity(0.6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),

                                      onPressed: controller.isLoading.value
                                          ? null
                                          : () async {
                                              final error = await controller
                                                  .registerShopkeeper();

                                              if (!context.mounted) return;

                                              if (error != null) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(error),
                                                  ),
                                                );
                                                return;
                                              }

                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Store registered successfully',
                                                  ),
                                                ),
                                              );

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const PartnerSignInPage(),
                                                ),
                                              );
                                            },

                                      child: controller.isLoading.value
                                          ? const SizedBox(
                                              height: 26,
                                              width: 26,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // =========================
                    // SIGN IN
                    // =========================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back, color: AppColors.primary),

                        Flexible(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PartnerSignInPage(),
                                ),
                              );
                            },
                            child: Text(
                              AppLanguage.tr(
                                en: 'Already have a store? Sign in',
                                hi: 'पहले से स्टोर है? साइन इन करें',
                                ne: 'पहिले नै स्टोर छ? साइन इन गर्नुहोस्',
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: AppTextSizes.md,
                                fontWeight: AppFontWeights.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
