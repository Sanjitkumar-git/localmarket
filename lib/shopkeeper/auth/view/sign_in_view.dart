import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/auth/controllers/sign_in_controller.dart';
import 'package:localmarket/shopkeeper/routes/app_routes.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';

class SignInView extends GetView<PartnerSigninController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: AutofillGroup(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),

            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),

                child: Column(
                  children: [
                    // ==================================================
                    // HEADER + LOGIN CARD
                    // ==================================================
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
                                  'assets/shop/signin.jpg',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),

                                // Overlay
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

                                // Merchant Portal
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
                                            en: 'Merchant Portal',
                                            hi: 'व्यापारी पोर्टल',
                                            ne: 'व्यापारी पोर्टल',
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
                        // LOGIN CARD
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

                          child: Form(
                            key: controller.formKey,

                            child: Column(
                              children: [
                                // ==================================================
                                // ICON
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

                                const SizedBox(height: 14),

                                // ==================================================
                                // TITLE
                                // ==================================================
                                Text(
                                  AppLanguage.tr(
                                    en: 'NearShop Merchant',
                                    hi: 'नियरशॉप व्यापारी',
                                    ne: 'नियरशप व्यापारी',
                                  ),

                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: AppTextSizes.h6,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                // ==================================================
                                // DESCRIPTION
                                // ==================================================
                                Text(
                                  AppLanguage.tr(
                                    en: 'Secure access for store administrators.',
                                    hi: 'स्टोर व्यवस्थापकों के लिए सुरक्षित प्रवेश।',
                                    ne: 'स्टोर प्रशासकहरूको लागि सुरक्षित पहुँच।',
                                  ),

                                  textAlign: TextAlign.center,

                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: AppTextSizes.md,
                                    fontWeight: AppFontWeights.regular,
                                    height: 1.4,
                                  ),
                                ),

                                const SizedBox(height: 26),

                                // ==================================================
                                // EMAIL
                                // ==================================================
                                TextFormField(
                                  controller: controller.emailController,

                                  keyboardType: TextInputType.emailAddress,

                                  textInputAction: TextInputAction.next,

                                  autofillHints: const [
                                    AutofillHints.email,
                                    AutofillHints.username,
                                  ],

                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),

                                  validator: (value) {
                                    final email = value?.trim() ?? '';

                                    if (email.isEmpty) {
                                      return AppLanguage.tr(
                                        en: 'Email is required',
                                        hi: 'ईमेल आवश्यक है',
                                        ne: 'इमेल आवश्यक छ',
                                      );
                                    }

                                    final emailRegex = RegExp(
                                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                    );

                                    if (!emailRegex.hasMatch(email)) {
                                      return AppLanguage.tr(
                                        en: 'Please enter a valid email',
                                        hi: 'कृपया एक मान्य ईमेल दर्ज करें',
                                        ne: 'कृपया मान्य इमेल प्रविष्ट गर्नुहोस्',
                                      );
                                    }

                                    return null;
                                  },

                                  decoration: InputDecoration(
                                    labelText: AppLanguage.tr(
                                      en: 'Email address',
                                      hi: 'ईमेल पता',
                                      ne: 'इमेल ठेगाना',
                                    ),

                                    labelStyle: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: AppTextSizes.md,
                                    ),

                                    prefixIcon: Icon(
                                      Icons.email_outlined,
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

                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),

                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // ==================================================
                                // PASSWORD
                                // ==================================================
                                Obx(
                                  () => TextFormField(
                                    controller: controller.passwordController,

                                    obscureText:
                                        !controller.isPasswordVisible.value,

                                    textInputAction: TextInputAction.done,

                                    autofillHints: const [
                                      AutofillHints.password,
                                    ],

                                    onFieldSubmitted: (_) {
                                      if (!controller.isLoading.value) {
                                        controller.signInWithEmail();
                                      }
                                    },

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
                                        color: AppColors.textSecondary,
                                        fontSize: AppTextSizes.md,
                                      ),

                                      prefixIcon: Icon(
                                        Icons.lock_outline_rounded,
                                        color: AppColors.primary,
                                      ),

                                      suffixIcon: IconButton(
                                        tooltip:
                                            controller.isPasswordVisible.value
                                            ? 'Hide password'
                                            : 'Show password',

                                        onPressed:
                                            controller.togglePasswordVisibility,

                                        icon: Icon(
                                          controller.isPasswordVisible.value
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,

                                          color: AppColors.textSecondary,
                                        ),
                                      ),

                                      filled: true,

                                      fillColor: AppColors.background,

                                      contentPadding:
                                          const EdgeInsets.symmetric(
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

                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),

                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // ==================================================
                                // FORGOT PASSWORD
                                // ==================================================
                                Obx(
                                  () => Align(
                                    alignment: Alignment.centerRight,

                                    child: TextButton(
                                      onPressed: controller.isLoading.value
                                          ? null
                                          : () {
                                              Get.toNamed(
                                                AppRoutes.forgotPassword,
                                              );
                                            },

                                      child: Text(
                                        AppLanguage.tr(
                                          en: 'Forgot Password?',
                                          hi: 'पासवर्ड भूल गए?',
                                          ne: 'पासवर्ड बिर्सनुभयो?',
                                        ),

                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: AppTextSizes.md,
                                          fontWeight: AppFontWeights.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // ==================================================
                                // LOGIN BUTTON
                                // ==================================================
                                Obx(
                                  () => SizedBox(
                                    width: double.infinity,
                                    height: 56,

                                    child: ElevatedButton(
                                      onPressed: controller.isLoading.value
                                          ? null
                                          : controller.signInWithEmail,

                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,

                                        backgroundColor: AppColors.primary,

                                        disabledBackgroundColor: AppColors
                                            .primary
                                            .withOpacity(0.65),

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            13,
                                          ),
                                        ),
                                      ),

                                      child: AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),

                                        child: controller.isLoading.value
                                            ? const SizedBox(
                                                key: ValueKey('loader'),
                                                width: 23,
                                                height: 23,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2.5,
                                                      color: Colors.white,
                                                    ),
                                              )
                                            : Text(
                                                AppLanguage.tr(
                                                  en: 'Login To Dashboard',
                                                  hi: 'डैशबोर्ड में लॉगिन करें',
                                                  ne: 'ड्यासबोर्डमा लगइन गर्नुहोस्',
                                                ),

                                                key: const ValueKey(
                                                  'login_text',
                                                ),

                                                textAlign: TextAlign.center,

                                                style: TextStyle(
                                                  color: AppColors.tertiary,
                                                  fontSize: AppTextSizes.xl,
                                                  fontWeight:
                                                      AppFontWeights.bold,
                                                ),
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

                    // ==================================================
                    // OR
                    // ==================================================
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),

                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),

                            child: Text(
                              AppLanguage.tr(
                                en: 'or continue with',
                                hi: 'या इसके साथ जारी रखें',
                                ne: 'वा यससँग जारी राख्नुहोस्',
                              ),

                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppTextSizes.md,
                                fontWeight: AppFontWeights.regular,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ==================================================
                    // GOOGLE LOGIN
                    // ==================================================
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,

                        child: OutlinedButton.icon(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.signInWithGoogle,

                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            size: 20,
                            color: Colors.red,
                          ),

                          label: Text(
                            AppLanguage.tr(
                              en: 'Continue with Google',
                              hi: 'Google के साथ जारी रखें',
                              ne: 'Google मार्फत जारी राख्नुहोस्',
                            ),

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppTextSizes.md,
                              fontWeight: AppFontWeights.bold,
                            ),
                          ),

                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.card,

                            side: BorderSide(color: Colors.grey.shade300),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ==================================================
                    // SIGN UP
                    // ==================================================
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(top: 18),

                        child: Wrap(
                          alignment: WrapAlignment.center,

                          crossAxisAlignment: WrapCrossAlignment.center,

                          spacing: 3,

                          children: [
                            Icon(
                              Icons.person_add_alt_1_outlined,
                              color: AppColors.primary,
                              size: 21,
                            ),

                            TextButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                      Get.toNamed(AppRoutes.signup);
                                    },

                              child: Text(
                                AppLanguage.tr(
                                  en: "Don't have a store? Sign up here",
                                  hi: "स्टोर नहीं है? यहाँ साइन अप करें",
                                  ne: "स्टोर छैन? यहाँ साइन अप गर्नुहोस्",
                                ),

                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: AppTextSizes.md,
                                  fontWeight: AppFontWeights.bold,
                                ),
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
          ),
        ),
      ),
    );
  }
}
