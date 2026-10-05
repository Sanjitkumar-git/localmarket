import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/shop_registration_controller.dart';
import 'package:localmarket/shopkeeper/home/dashboard_screen.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';

class ShopRegistrationView extends StatelessWidget {
  final User partner;

  const ShopRegistrationView({super.key, required this.partner});

  // ============================================================
  // SELECT SHOP CATEGORIES
  // ============================================================

  Future<void> _selectShopCategories(
    BuildContext context,
    ShopRegistrationController controller,
  ) async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        // Temporary selection for bottom sheet
        List<String> tempSelected = List<String>.from(
          controller.selectedCategories,
        );

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  child: Column(
                    children: [
                      // ==================================================
                      // HEADER
                      // ==================================================
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

                      // ==================================================
                      // SELECTED COUNT
                      // ==================================================
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

                      // ==================================================
                      // CATEGORY LIST
                      // ==================================================
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.shopCategories.length,
                          itemBuilder: (context, index) {
                            final category = controller.shopCategories[index];

                            final String categoryId = category['id']!;

                            final String categoryName =
                                category['localeKey']!.tr;

                            final bool isSelected = tempSelected.contains(
                              categoryId,
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
                                    if (!tempSelected.contains(categoryId)) {
                                      tempSelected.add(categoryId);
                                    }
                                  } else {
                                    tempSelected.remove(categoryId);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ==================================================
                      // DONE BUTTON
                      // ==================================================
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

    // ============================================================
    // UPDATE GETX CONTROLLER
    // ============================================================

    if (result != null) {
      controller.setCategories(result);
    }
  }

  // ============================================================
  // SHOW MESSAGE
  // ============================================================

  void _showMessage(
    BuildContext context,
    String message, {
    bool isError = true,
  }) {
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

  // ============================================================
  // REGISTER SHOP
  // ============================================================

  Future<void> _registerShop(
    BuildContext context,
    ShopRegistrationController controller,
  ) async {
    FocusScope.of(context).unfocus();

    final error = await controller.registerShop(
      uid: partner.uid,
      email: partner.email,
      displayName: partner.displayName,
      photoURL: partner.photoURL,
    );

    if (!context.mounted) return;

    // ==========================================================
    // ERROR
    // ==========================================================

    if (error != null) {
      _showMessage(context, error);
      return;
    }

    // ==========================================================
    // SUCCESS
    // ==========================================================

    _showMessage(
      context,
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
      MaterialPageRoute(builder: (_) => const DashboardView()),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    // GetX Controller
    final controller = Get.find<ShopRegistrationController>();

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

                  // ==================================================
                  // SHOP ICON
                  // ==================================================
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

                  // ==================================================
                  // TITLE
                  // ==================================================
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

                  // ==================================================
                  // SUBTITLE
                  // ==================================================
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

                  // ==================================================
                  // MAIN CARD
                  // ==================================================
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
                        // ==================================================
                        // EMAIL
                        // ==================================================
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
                                  partner.email ?? 'No email',

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

                        // ==================================================
                        // STORE NAME
                        // ==================================================
                        TextField(
                          controller: controller.storeNameController,

                          style: TextStyle(color: AppColors.textPrimary),

                          decoration: InputDecoration(
                            labelText: 'signup.store_name'.tr,

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

                        // ==================================================
                        // SHOP CATEGORIES
                        // ==================================================
                        Obx(
                          () => InkWell(
                            borderRadius: BorderRadius.circular(12),

                            onTap: () {
                              _selectShopCategories(context, controller);
                            },

                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'signup.shop_categories'.tr,

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

                              // ==================================================
                              // NO CATEGORY
                              // ==================================================
                              child: controller.selectedCategories.isEmpty
                                  ? Text(
                                      'signup.select_categories'.tr,

                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: AppTextSizes.md,
                                      ),
                                    )
                                  // ==================================================
                                  // SELECTED CATEGORIES
                                  // ==================================================
                                  : Wrap(
                                      spacing: 6,
                                      runSpacing: 6,

                                      children: controller.selectedCategories
                                          .map((categoryId) {
                                            return Chip(
                                              label: Text(
                                                categoryId.tr,

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
                                                controller.removeCategory(
                                                  categoryId,
                                                );
                                              },
                                            );
                                          })
                                          .toList(),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 26),

                        // ==================================================
                        // REGISTER BUTTON
                        // ==================================================
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 56,

                            child: ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                      _registerShop(context, controller);
                                    },

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

                                child: controller.isLoading.value
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
                                        'signup.register_store'.tr,

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
