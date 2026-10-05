import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:localmarket/users/routes/app_routes.dart';
import 'package:localmarket/users/utils/form_inputs.dart';

class UserSigninController extends GetxController {
  final LoginForm form = LoginForm();
  
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final FocusNode emailAddressNode;
  late final FocusNode passwordNode;
  late final TapGestureRecognizer tapGestureRecognizer;
  
  bool isChecked = false;

  @override
  void onInit() {
    super.onInit();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    emailAddressNode = FocusNode();
    passwordNode = FocusNode();

    emailTextController.addListener(() {
      form.email = EmailInput.dirty(value: emailTextController.text);
    });

    passwordTextController.addListener(() {
      form.password = PasswordInput.dirty(value: passwordTextController.text);
    });

    tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () async {
         await Get.toNamed(Routes.SIGNUPSCREEN);
      };
  }

  void toggleRememberMe(bool? value) {
    isChecked = value ?? false;
    update();
  }

  Future<void> confirmLogin() async {
   
    form.email = EmailInput.dirty(value: emailTextController.text);
    form.password = PasswordInput.dirty(value: passwordTextController.text);
    update();

    if (form.isValid) {
       Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    emailAddressNode.dispose();
    passwordNode.dispose();
    tapGestureRecognizer.dispose();
    super.onClose();
  }
}

class LoginForm with FormzMixin {
  LoginForm({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
  });
  
  EmailInput email;
  PasswordInput password;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];
}