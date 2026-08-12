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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              width: 430,
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.primary.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 58,
                    width: 58,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.storefront_rounded,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 14),

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

                  const SizedBox(height: 6),

                  Text(
                    AppLanguage.tr(
                      en: 'Choose your account type',
                      hi: 'अपना अकाउंट प्रकार चुनें',
                      ne: 'आफ्नो खाता प्रकार छान्नुहोस्',
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextSizes.sm,
                      fontWeight: AppFontWeights.regular,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: _roleCard(
                          context: context,
                          icon: Icons.person_rounded,
                          title: AppLanguage.tr(
                            en: 'User',
                            hi: 'उपयोगकर्ता',
                            ne: 'प्रयोगकर्ता',
                          ),
                          description: AppLanguage.tr(
                            en: 'Find local shops',
                            hi: 'स्थानीय दुकानें खोजें',
                            ne: 'स्थानीय पसल खोज्नुहोस्',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _roleCard(
                          context: context,
                          icon: Icons.store_rounded,
                          title: AppLanguage.tr(
                            en: 'Shopkeeper',
                            hi: 'दुकानदार',
                            ne: 'पसल मालिक',
                          ),
                          description: AppLanguage.tr(
                            en: 'Manage your shop',
                            hi: 'अपनी दुकान संभालें',
                            ne: 'आफ्नो पसल व्यवस्थापन गर्नुहोस्',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PartnerSignInPage(),
                              ),
                            );
                          },
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

  Widget _roleCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 155,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 25, color: AppColors.primary),
              ),

              const SizedBox(height: 10),

              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppTextSizes.md,
                  fontWeight: AppFontWeights.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                description,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppTextSizes.sm,
                  fontWeight: AppFontWeights.regular,
                ),
              ),

              const SizedBox(height: 7),

              Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
