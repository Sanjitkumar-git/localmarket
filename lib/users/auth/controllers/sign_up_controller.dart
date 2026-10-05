import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:localmarket/users/routes/app_routes.dart';
import 'package:localmarket/users/utils/form_inputs.dart';

class UserSignUpController extends GetxController {
  RegisterForm form = RegisterForm();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final fullNameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();

  late final TapGestureRecognizer tapGestureRecognizer;

  @override
  void onInit() {
    super.onInit();
    tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () => Get.offNamed(Routes.SIGNINSCREEN);
  }

  void onFullNameChanged(String v) {
    form.fullName = NameInput.dirty(value: v);
    update();
  }

  void onEmailChanged(String v) {
    form.email = EmailInput.dirty(value: v);
    update();
  }

  void onPasswordChanged(String v) {
    form.password = PasswordInput.dirty(value: v);
    update();
  }

  void onConfirmPasswordChanged(String v) {
    form.confirmPassword =
        ConfirmPasswordInput.dirty(value: v, password: form.password.value);
    update();
  }

 void submitRegister() {
  try {
    onFullNameChanged(fullNameController.text.trim());
    onEmailChanged(emailController.text.trim());
    onPasswordChanged(passwordController.text);
    onConfirmPasswordChanged(confirmPasswordController.text);

    if (form.isValid) {
      Get.offAllNamed(Routes.SIGNINSCREEN);
    }
  } catch (e, s) {
    debugPrint('SUBMIT ERROR: $e\n$s');
  }
}

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    fullNameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();

    tapGestureRecognizer.dispose();
    super.onClose();
  }
}

class RegisterForm with FormzMixin {
  RegisterForm({
    this.fullName = const NameInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
  });

  NameInput fullName;
  EmailInput email;
  PasswordInput password;
  ConfirmPasswordInput confirmPassword;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs =>
      [fullName, email, password, confirmPassword];
}