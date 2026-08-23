import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localmarket/widget/app_background.dart';
import 'package:localmarket/widget/app_button.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_icon.dart';
import 'package:localmarket/widget/app_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    badgeIcon: Icons.storefront_outlined,
                    badgeText: 'common.badge'.tr(),
                    cardIcon: Icons.storefront_outlined,
                    title: 'common.title'.tr(),
                    subtitle: 'auth.login_desc'.tr().toUpperCase(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: emailController,
                          focusNode: _emailFocus,
                          nextFocusNode: _passwordFocus,
                          textInputAction: TextInputAction.next,
                          label: 'auth.email_or_phone'.tr(),
                          hint: 'auth.email_or_phone'.tr(),
                        ),
                        const SizedBox(height: 12),
                        AppTextField(
                          controller: passwordController,
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.done,
                          label: 'auth.password'.tr(),
                          hint: 'auth.password'.tr(),
                          isPassword: true,
                        ),
                        const SizedBox(height: 4),
                        AppTextButton(
                          text: 'auth.forgot_password'.tr(),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'auth.login'.tr(),
                          type: AppButton.primary,
                          onPressed: () {},
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