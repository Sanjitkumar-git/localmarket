import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final bool showBackButton;
  final bool showDrawerButton;
  final bool showBranding;
  final bool showSupportButton;

  final List<Widget>? actions;

  final VoidCallback? onBack;
  final VoidCallback? onSupportTap;

  final Color? backgroundColor;
  final double? elevation;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showDrawerButton = false,
    this.showBranding = false,
    this.showSupportButton = false,
    this.actions,
    this.onBack,
    this.onSupportTap,
    this.backgroundColor,
    this.elevation,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.primary,
      elevation: elevation ?? 0,
      centerTitle: true,

      automaticallyImplyLeading: false,

      iconTheme: const IconThemeData(color: AppColors.white, size: 28),

      leading: _buildLeading(context),

      leadingWidth: _getLeadingWidth(),

      title: _buildTitle(),

      actions: _buildActions(),
    );
  }

  // ============================================================
  // LEADING
  // ============================================================

  Widget? _buildLeading(BuildContext context) {
    // BOTH BACK + DRAWER
    if (showBackButton && showDrawerButton) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onBack ?? () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          ),

          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu),
              );
            },
          ),
        ],
      );
    }

    // ONLY BACK
    if (showBackButton) {
      return IconButton(
        onPressed: onBack ?? () => Get.back(),
        icon: const Icon(Icons.arrow_back),
      );
    }

    // ONLY DRAWER
    if (showDrawerButton) {
      return Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu),
          );
        },
      );
    }

    return null;
  }

  // ============================================================
  // LEADING WIDTH
  // ============================================================

  double _getLeadingWidth() {
    if (showBackButton && showDrawerButton) {
      return 112;
    }

    if (showBackButton || showDrawerButton) {
      return 56;
    }

    return 0;
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _buildTitle() {
    if (showBranding) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.storefront_outlined,
            color: AppColors.primaryLight,
            size: 28,
          ),

          const SizedBox(width: 5),

          Text(
            AppLanguage.tr(en: title, hi: 'नियरशॉप', ne: 'नियरसप'),
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: AppTextSizes.h3,
              fontWeight: AppFontWeights.extraBold,
            ),
          ),
        ],
      );
    }

    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.white,
        fontSize: AppTextSizes.h5,
        fontWeight: AppFontWeights.bold,
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================

  List<Widget>? _buildActions() {
    final List<Widget> allActions = [];

    if (showSupportButton) {
      allActions.add(
        IconButton(
          onPressed: onSupportTap,
          icon: const Icon(
            Icons.support_agent_outlined,
            color: AppColors.white,
            size: 28,
          ),
        ),
      );
    }

    if (actions != null) {
      allActions.addAll(actions!);
    }

    if (allActions.isEmpty) {
      return null;
    }

    return allActions;
  }
}
