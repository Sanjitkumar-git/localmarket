import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:localmarket/users/auth/controllers/sign_in_controller.dart';
import 'package:localmarket/users/routes/app_routes.dart';
import 'package:localmarket/widget/app_background.dart';
import 'package:localmarket/widget/app_button.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_textfield.dart';

class SignInScreen extends GetView<UserSigninController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserSigninController());

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
                    badgeText: tr('common.badge'),
                    badgeIcon: FontAwesomeIcons.store,

                    title: tr('common.title'),
                    subtitle: tr('auth.login_desc').toUpperCase(),
                    cardIcon: FontAwesomeIcons.store,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        GetBuilder<UserSigninController>(
                          builder: (userController) {
                            return AppTextField(
                              controller: userController.emailTextController,
                              focusNode: userController.emailAddressNode,
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
                        GetBuilder<UserSigninController>(
                          builder: (userController) {
                            return AppTextField(
                              controller: userController.passwordTextController,
                              focusNode: userController.passwordNode,
                              textInputAction: TextInputAction.done,
                              label: tr('auth.password'),
                              hint: tr('auth.password'),
                              isPassword: true,
                              prifixIcon: FontAwesomeIcons.lock,   
                              validationError:
                                  userController.form.password.error,
                            );
                          },
                        ),
                        const SizedBox(height: 4),

                        // Remember Password  Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GetBuilder<UserSigninController>(
                                builder: (userController) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: userController.isChecked,
                                        activeColor: AppColors.primary,
                                        onChanged: (value) {
                                          userController.toggleRememberMe(
                                            value ?? false,
                                          );
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          tr('auth.remember_password'),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            AppTextButton(
                              text: tr('auth.forgot_password'),
                              onPressed: () => Get.toNamed(Routes.FORGOTPAGE),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        CustomButton(
                          text: tr('auth.login'),
                          type: AppButton.primary,
                          onPressed: () => controller.confirmLogin(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.primary.withOpacity(0.5),
                                thickness: 0.8,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(tr('auth.or_continue_with')),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.primary.withOpacity(0.5),
                                thickness: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          type: AppButton.outline,
                          text: tr('auth.continue_google'),
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: AppColors.secondaryDark,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: '${tr('auth.dont_have_account')} ',
                              style: TextStyle(
                                color: AppColors.black.withOpacity(0.4),
                              ),
                              children: [
                                TextSpan(
                                  text: tr('auth.create_account'),
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
