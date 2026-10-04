import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/forgot_password_controller.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_icon.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_padding.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();

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
                  Stack(
                    clipBehavior: Clip.none,

                    children: [
                      // ==================================================
                      // HEADER IMAGE
                      // ==================================================
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),

                        child: SizedBox(
                          width: double.infinity,
                          height: 290,

                          child: Stack(
                            fit: StackFit.expand,

                            children: [
                              Image.asset(
                                'assets/shop/forgot.jpg',
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

                              // ==================================================
                              // HEADER LABEL
                              // ==================================================
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
                                          en: 'Forgot Password',
                                          hi: 'पासवर्ड भूल गए',
                                          ne: 'पासवर्ड बिर्सनुभयो',
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

                      // ==================================================
                      // FORGOT PASSWORD CARD
                      // ==================================================
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

                        child: Column(
                          children: [
                            // ==================================================
                            // LOGO
                            // ==================================================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Container(
                                  height: 50,
                                  width: 50,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  child: const AppIcon(
                                    iconWidget: FaIcon(
                                      FontAwesomeIcons.store,
                                      size: 30,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 6),

                                Text(
                                  AppLanguage.tr(
                                    en: 'NearShop',
                                    hi: 'नियरशॉप',
                                    ne: 'नियरशप',
                                  ),

                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: AppTextSizes.h4,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // ==================================================
                            // TITLE
                            // ==================================================
                            Text(
                              AppLanguage.tr(
                                en: 'Forgot Password',
                                hi: 'पासवर्ड भूल गए',
                                ne: 'पासवर्ड बिर्सनुभयो',
                              ),

                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppTextSizes.h5,
                                fontWeight: AppFontWeights.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // ==================================================
                            // DESCRIPTION
                            // ==================================================
                            Text(
                              AppLanguage.tr(
                                en: 'Enter your email address to reset your password.',
                                hi: 'अपना पासवर्ड रीसेट करने के लिए अपना ईमेल पता दर्ज करें।',
                                ne: 'पासवर्ड रीसेट गर्नको लागि तपाइँको इमेल ठेगाना प्रविष्ट गर्नुहोस्।',
                              ),

                              textAlign: TextAlign.center,

                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppTextSizes.md,
                                fontWeight: AppFontWeights.regular,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // ==================================================
                            // EMAIL
                            // ==================================================
                            Padding(
                              padding: AppPadding.horizontalMd,

                              child: TextFormField(
                                controller: controller.emailController,

                                keyboardType: TextInputType.emailAddress,

                                textInputAction: TextInputAction.done,

                                style: TextStyle(color: AppColors.textPrimary),

                                decoration: InputDecoration(
                                  labelText: AppLanguage.tr(
                                    en: 'Email',
                                    hi: 'ईमेल',
                                    ne: 'इमेल',
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

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),

                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),

                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // ==================================================
                            // SEND RESET LINK
                            // ==================================================
                            Obx(
                              () => SizedBox(
                                width: double.infinity,
                                height: 56,

                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,

                                    disabledBackgroundColor: AppColors.primary
                                        .withOpacity(0.6),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),

                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.sendResetLink,

                                  child: controller.isLoading.value
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,

                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          AppLanguage.tr(
                                            en: 'Send Reset Link',
                                            hi: 'पासवर्ड रीसेट लिंक भेजें',
                                            ne: 'पासवर्ड रीसेट लिंक पठाउनुहोस्',
                                          ),

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

                            const SizedBox(height: 20),

                            const Divider(),

                            const SizedBox(height: 10),

                            // ==================================================
                            // BACK TO LOGIN
                            // ==================================================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: AppColors.primary,
                                  size: 16,
                                ),

                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },

                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primary,

                                    textStyle: TextStyle(
                                      fontSize: AppTextSizes.button,
                                      fontWeight: AppFontWeights.medium,
                                    ),
                                  ),

                                  child: Text(
                                    AppLanguage.tr(
                                      en: 'Back to Login',
                                      hi: 'लॉगिन पर वापस जाएं',
                                      ne: 'लगइनमा फर्कनुहोस्',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
