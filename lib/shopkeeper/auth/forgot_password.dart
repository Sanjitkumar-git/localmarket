import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_icon.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/app_padding.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 350,
            height: 390,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: AppIcon(
                        iconWidget: const FaIcon(
                          FontAwesomeIcons.store,
                          size: 30,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      AppLanguage.tr(
                        en: "NearShop",
                        hi: "नियरशॉप",
                        ne: "नियरशप",
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
                Text(
                  AppLanguage.tr(
                    en: "Forgot Password",
                    hi: "पासवर्ड भूल गए",
                    ne: "पासवर्ड बिर्सनुभयो",
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppTextSizes.h5,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),
                Text(
                  AppLanguage.tr(
                    en: "Enter your email address to reset your password.",
                    hi: "अपना पासवर्ड रीसेट करने के लिए अपना ईमेल पता दर्ज करें।",
                    ne: "पासवर्ड रीसेट गर्नको लागि तपाइँको इमेल ठिकाना प्रविष्ट गर्नुहोस्।",
                  ),
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextSizes.md,
                    fontWeight: AppFontWeights.regular,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: AppPadding.horizontalMd,
                  child: TextField(
                    style: TextStyle(color: AppColors.textPrimary),

                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: AppColors.textPrimary),

                      labelText: AppLanguage.tr(
                        en: 'Email',
                        hi: 'ईमेल',
                        ne: 'इमेल',
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                        en: 'Send Reset Link',
                        hi: 'पासवर्ड रीसेट लिंक भेजें',
                        ne: 'पासवर्ड रीसेट लिंक पठाउनुहोस्',
                      ),

                      style: TextStyle(
                        color: AppColors.tertiary,
                        fontSize: AppTextSizes.xl,
                        fontWeight: AppFontWeights.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: AppColors.primary,
                        size: 14,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
