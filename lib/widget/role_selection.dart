import 'package:flutter/material.dart';
import 'package:localmarket/shopkeeper/auth/sign_in.dart';
import 'package:localmarket/users/auth/sign_in.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.07),
                ),
              ),
            ),

            Positioned(
              bottom: -110,
              left: -90,
              child: Container(
                height: 240,
                width: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.05),
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 28,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 30, 22, 24),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 82,
                          width: 82,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.12),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.18),
                            ),
                          ),
                          child: Icon(
                            Icons.storefront_rounded,
                            size: 41,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          AppLanguage.tr(
                            en: 'Welcome to NearShop',
                            hi: 'नियरशॉप में आपका स्वागत है',
                            ne: 'नियरशपमा स्वागत छ',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: AppTextSizes.h5,
                            fontWeight: AppFontWeights.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          AppLanguage.tr(
                            en: 'Choose how you want to continue',
                            hi: 'जारी रखने के लिए अपना विकल्प चुनें',
                            ne: 'अगाडि बढ्न आफ्नो विकल्प छान्नुहोस्',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextSizes.sm,
                            fontWeight: AppFontWeights.regular,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 28),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLanguage.tr(
                              en: 'SELECT ACCOUNT TYPE',
                              hi: 'अकाउंट प्रकार चुनें',
                              ne: 'खाता प्रकार छान्नुहोस्',
                            ),
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppTextSizes.sm,
                              fontWeight: AppFontWeights.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => SignInPage(),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(18),
                                  splashColor: AppColors.primary.withValues(
                                    alpha: 0.10,
                                  ),
                                  highlightColor: AppColors.primary.withValues(
                                    alpha: 0.05,
                                  ),
                                  child: Ink(
                                    height: 208,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: AppColors.background.withValues(
                                        alpha: 0.45,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.14,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 27,
                                            width: 27,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.09),
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_rounded,
                                              color: AppColors.primary,
                                              size: 16,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 2),

                                        Container(
                                          height: 56,
                                          width: 56,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary.withValues(
                                              alpha: 0.12,
                                            ),
                                            border: Border.all(
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.16),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.person_rounded,
                                            size: 29,
                                            color: AppColors.primary,
                                          ),
                                        ),

                                        const SizedBox(height: 13),

                                        Text(
                                          AppLanguage.tr(
                                            en: 'User',
                                            hi: 'उपयोगकर्ता',
                                            ne: 'प्रयोगकर्ता',
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: AppTextSizes.md,
                                            fontWeight: AppFontWeights.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Expanded(
                                          child: Text(
                                            AppLanguage.tr(
                                              en: 'Find local shops and products',
                                              hi: 'स्थानीय दुकानें और उत्पाद खोजें',
                                              ne: 'स्थानीय पसल र उत्पादन खोज्नुहोस्',
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: AppTextSizes.sm,
                                              fontWeight:
                                                  AppFontWeights.regular,
                                              height: 1.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PartnerSignInPage(),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(18),
                                  splashColor: AppColors.primary.withValues(
                                    alpha: 0.10,
                                  ),
                                  highlightColor: AppColors.primary.withValues(
                                    alpha: 0.05,
                                  ),
                                  child: Ink(
                                    height: 208,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: AppColors.background.withValues(
                                        alpha: 0.45,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.14,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 27,
                                            width: 27,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.09),
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_rounded,
                                              color: AppColors.primary,
                                              size: 16,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 2),

                                        Container(
                                          height: 56,
                                          width: 56,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primary.withValues(
                                              alpha: 0.12,
                                            ),
                                            border: Border.all(
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.16),
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.store_rounded,
                                            size: 29,
                                            color: AppColors.primary,
                                          ),
                                        ),

                                        const SizedBox(height: 13),

                                        Text(
                                          AppLanguage.tr(
                                            en: 'Shopkeeper',
                                            hi: 'दुकानदार',
                                            ne: 'पसल मालिक',
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: AppTextSizes.md,
                                            fontWeight: AppFontWeights.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Expanded(
                                          child: Text(
                                            AppLanguage.tr(
                                              en: 'Manage your shop and orders',
                                              hi: 'अपनी दुकान और ऑर्डर संभालें',
                                              ne: 'आफ्नो पसल र अर्डर व्यवस्थापन गर्नुहोस्',
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: AppTextSizes.sm,
                                              fontWeight:
                                                  AppFontWeights.regular,
                                              height: 1.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.08),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                size: 19,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 9),
                              Expanded(
                                child: Text(
                                  AppLanguage.tr(
                                    en: 'Select the account type that best describes you. You can continue securely.',
                                    hi: 'अपने अनुसार अकाउंट प्रकार चुनें। आप सुरक्षित रूप से आगे बढ़ सकते हैं।',
                                    ne: 'तपाईंलाई उपयुक्त खाता प्रकार छान्नुहोस्। सुरक्षित रूपमा अगाडि बढ्न सक्नुहुन्छ।',
                                  ),
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: AppTextSizes.sm,
                                    fontWeight: AppFontWeights.regular,
                                    height: 1.35,
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
            ),
          ],
        ),
      ),
    );
  }
}
