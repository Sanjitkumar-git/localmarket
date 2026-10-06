import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localmarket/widget/validation_controller.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();

  final RxBool isLoading = false.obs;

  String? validateEmail() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      return 'Please enter your email address.';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  Future<bool> sendResetLink() async {
    final validationError = validateEmail();

    if (validationError != null) {
      Get.snackbar(
        'Error',
        validationError,
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    }

    isLoading.value = true;

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());

      AppSnackbar.success('Password reset link has been sent to your email.');

      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong. Please try again.';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email address.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      }

      AppSnackbar.error(message);

      return false;
    } catch (e) {
      AppSnackbar.error('Something went wrong. Please try again.');

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
