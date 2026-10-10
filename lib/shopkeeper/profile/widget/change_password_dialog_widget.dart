import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/shopkeeper/profile/controller/profile_controller.dart';

import 'package:localmarket/shopkeeper/profile/widget/premium_dialog_shell.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/validation_controller.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  late final ProfileController controller;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProfileController>();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _close() => Navigator.of(context).pop();

  void _changePassword() {
    final String currentPassword = currentPasswordController.text.trim();
    final String newPassword = newPasswordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();

    if (currentPassword.isEmpty) {
      AppSnackbar.error('Please enter your current password.');
      return;
    }

    if (newPassword.isEmpty) {
      AppSnackbar.error('Please enter your new password.');
      return;
    }

    if (newPassword.length < 6) {
      AppSnackbar.error('New password must be at least 6 characters.');
      return;
    }

    if (confirmPassword.isEmpty) {
      AppSnackbar.error('Please confirm your new password.');
      return;
    }

    if (newPassword != confirmPassword) {
      AppSnackbar.error('New passwords do not match.');
      return;
    }

    // Dialog turant band, password change background mein chalega
    _close();
    controller.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PremiumDialogShell(
      title: 'Change Password',
      subtitle: 'Keep your account safe and secure',
      icon: Icons.lock_outline_rounded,
      onClose: _close,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _passwordField(
            controller: currentPasswordController,
            label: 'Current Password',
            obscureText: obscureCurrentPassword,
            onToggle: () => setState(
              () => obscureCurrentPassword = !obscureCurrentPassword,
            ),
          ),
          const SizedBox(height: 14),
          _passwordField(
            controller: newPasswordController,
            label: 'New Password',
            obscureText: obscureNewPassword,
            onToggle: () =>
                setState(() => obscureNewPassword = !obscureNewPassword),
          ),
          const SizedBox(height: 14),
          _passwordField(
            controller: confirmPasswordController,
            label: 'Confirm New Password',
            obscureText: obscureConfirmPassword,
            onToggle: () => setState(
              () => obscureConfirmPassword = !obscureConfirmPassword,
            ),
          ),
          const SizedBox(height: 14),

          // Hint
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Use at least 6 characters for your new password.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextSizes.caption,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),
          Obx(
            () => PremiumDialogButton(
              label: 'Change Password',
              icon: Icons.lock_reset_rounded,
              loading: controller.isSaving.value,
              onPressed: controller.isSaving.value ? null : _changePassword,
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: premiumInputDecoration(
        label: label,
        icon: Icons.lock_outline_rounded,
        suffix: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
