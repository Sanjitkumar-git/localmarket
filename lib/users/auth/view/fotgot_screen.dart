import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/forgot_pass_controller.dart';
import 'package:localmarket/widget/app_background.dart';
import 'package:localmarket/widget/app_button.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_textfield.dart';

class ForgotScreen extends GetView<UserForgotController> {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserForgotController());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  MerchantAuthShell(
                    imagePath: 'assets/user/sign.jpg',
                    imageHeight: 290,
                    overlapHeight: 40,
                    badgeIcon: FontAwesomeIcons.store,
                    badgeText: tr('common.badge'),
                    cardIcon: FontAwesomeIcons.store,
                    title: tr('auth.forgot_password'),
                    subtitle: tr('auth.forgot_password_desc').toUpperCase(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        GetBuilder<UserForgotController>(
                          builder: (userController) {
                            return AppTextField(
                              controller: userController.emailController,
                              focusNode: userController.emailNode,
                              textInputAction: TextInputAction.done,
                              label: tr('auth.email_or_phone'),
                              hint: tr('auth.email_or_phone'),
                              prifixIcon: FontAwesomeIcons.envelope,
                              validationError: userController.form.email.error,
                            );
                          },
                        ),
                          AppTextButton(
                            text: tr(''),
                            onPressed: () => controller.goToLogin(),
                          ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: tr('auth.send_reset_link'),
                          type: AppButton.primary,
                          onPressed: () => controller.submitForgot(),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: AppTextButton(
                            text: tr('auth.back_to_login'),
                            onPressed: () => controller.goToLogin(),
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
    );
  }
}