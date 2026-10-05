import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

      Get.snackbar(
        'Success',
        'Password reset link has been sent to your email.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong. Please try again.';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email address.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email address.';
      }

      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);

      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );

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
