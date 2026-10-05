import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/sign_up_controller.dart';
import 'package:localmarket/widget/app_background.dart';
import 'package:localmarket/widget/app_button.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_textfield.dart';

class SignUpScreen extends GetView<UserSignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserSignUpController());

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
                    cardIcon:FontAwesomeIcons.store,
                    title: tr('signup.join'),
                    subtitle: tr('auth.create_account_desc').toUpperCase(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),

                        // Full name
                        GetBuilder<UserSignUpController>(
                          builder: (userController) {
                            return AppTextField(
                              controller: userController.fullNameController,
                              focusNode: userController.fullNameNode,
                              nextFocusNode: userController.emailNode,
                              textInputAction: TextInputAction.next,
                              label: tr('signup.full_name'),
                              hint: tr('signup.full_name'),
                               prifixIcon: FontAwesomeIcons.user,
                              validationError: userController.form.fullName.error,
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // Email
                        GetBuilder<UserSignUpController>(
                          builder: (userController) {
                            return AppTextField(
                              controller:userController.emailController,
                              focusNode: userController.emailNode,
                              nextFocusNode: userController.passwordNode,
                              textInputAction: TextInputAction.next,
                              label: tr('auth.email_or_phone'),
                              hint: tr('auth.email_or_phone'),
                               prifixIcon: FontAwesomeIcons.envelope,
                              validationError: userController.form.email.error,
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // Password
                        GetBuilder<UserSignUpController>(
                          builder: (userController) {
                            return AppTextField(
                              controller: userController.passwordController,
                              focusNode: userController.passwordNode,
                              nextFocusNode: userController.confirmPasswordNode,
                              textInputAction: TextInputAction.next,
                              label: tr('auth.password'),
                              hint: tr('auth.password'),
                               prifixIcon: FontAwesomeIcons.lock,
                              isPassword: true,
                              validationError: userController.form.password.error,
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // Confirm password
                        GetBuilder<UserSignUpController>(
                          builder: (userController) {
                            return AppTextField(
                              controller: userController.confirmPasswordController,
                              focusNode: userController.confirmPasswordNode,
                              textInputAction: TextInputAction.done,
                              label: tr('auth.confirm_Password'),
                              hint: tr('auth.confirm_Password'),
                              prifixIcon: FontAwesomeIcons.lock,
                              isPassword: true,
                              validationError: userController.form.confirmPassword.error,
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        CustomButton(
                          text: tr('auth.create_account'),
                          type: AppButton.primary,
                          onPressed: () => controller.submitRegister(),
                        ),
                        const SizedBox(height: 16),

                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: '${tr('auth.already_have_account')} ',
                              style: TextStyle(
                                color: AppColors.black.withOpacity(0.4),
                              ),
                              children: [
                                TextSpan(
                                  text: tr('auth.login'),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: controller.tapGestureRecognizer,
                                ),
                              ],
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
    );
  }
}