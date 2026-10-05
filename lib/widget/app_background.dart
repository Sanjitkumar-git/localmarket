import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';

class MerchantAuthShell extends StatelessWidget {
  /// Top image path (assets/shop/signin.jpg jasto)
  final String imagePath;

  /// Image height
  final double imageHeight;

  /// Card le image lai kati overlap garne
  final double overlapHeight;

  /// Top-left badge ko icon + text (jasto "Merchant Portal")
  final FaIconData badgeIcon;
  final String badgeText;

  /// Card bhitra ko top icon (circle ma)
  final FaIconData cardIcon;

  /// Card ko title ra subtitle
  final String title;
  final String subtitle;

  /// Card bhitra ko form content — text field, button, jasai
  final Widget child;

  /// Form key (chahiyo bhane)
  final GlobalKey<FormState>? formKey;

  const MerchantAuthShell({
    super.key,
    required this.imagePath,
    required this.badgeIcon,
    required this.badgeText,
    required this.cardIcon,
    required this.title,
    required this.subtitle,
    required this.child,
    this.imageHeight = 290,
    this.overlapHeight = 37,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ---------- Top Image + Overlay + Badge ----------
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            width: double.infinity,
            height: imageHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(imagePath, fit: BoxFit.cover, alignment: Alignment.center),

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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.35)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(badgeIcon, color: Colors.white, size: 20),
                        const SizedBox(width: 7),
                        Text(
                          badgeText,
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

        // ---------- Overlapping Card ----------
        Container(
          margin: EdgeInsets.only(top: imageHeight - overlapHeight),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Icon circle
                Container(
                  height: 68,
                  width: 68,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: FaIcon(cardIcon, color: AppColors.primary, size: 38)),
                ),

                const SizedBox(height: 14),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppTextSizes.h6,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextSizes.md,
                    fontWeight: AppFontWeights.regular,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 26),

                // yeta form fields, buttons, jasai
                child,
              ],
            ),
          ),
        ),
      ],
    );
  }
}