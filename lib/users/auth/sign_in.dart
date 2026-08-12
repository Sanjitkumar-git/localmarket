import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localmarket/widget/app_button.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_icon.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_textfield.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: AppPadding.card,
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: AppPadding.card,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: AppIcon(
                              iconWidget: const FaIcon(
                                FontAwesomeIcons.store,
                                size: 30,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Center(
                            child: Text(
                              'NearShop Merchant',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppTextSizes.h6,
                                fontWeight: AppFontWeights.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),
                          const SizedBox(height: 6),
                          Center(
                            child: Text(
                              'Please log in to continue to your account.'
                                  .toUpperCase(),
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: AppFontWeights.regular,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            controller: emailController,
                            focusNode: _emailFocus,
                            nextFocusNode: _passwordFocus,
                            textInputAction: TextInputAction.next,
                            label: 'Email',
                            hint: 'Enter your email',
                          ),
                          const SizedBox(height: 12),
                          AppTextField(
                            controller: passwordController,
                            focusNode: _passwordFocus,
                            textInputAction: TextInputAction.done,
                            label: 'Password',
                            hint: 'Enter your password',

                            isPassword: true,
                          ),
                          const SizedBox(height: 4),
                          AppTextButton(
                            text: 'Forgot Password?',
                            onPressed: () {
                              // Navigate to Forgot Password screen
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Login',
                            type: AppButton.primary,
                            onPressed: () {},
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
      ),
    );
  }
}
