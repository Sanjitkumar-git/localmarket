import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localmarket/shopkeeper/routes/app_routes.dart';

import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/validation_controller.dart';


class PartnerSigninController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;

  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String firebaseErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return AppLanguage.tr(
          en: 'Please enter a valid email address.',
          hi: 'कृपया एक मान्य ईमेल पता दर्ज करें।',
          ne: 'कृपया मान्य इमेल ठेगाना प्रविष्ट गर्नुहोस्।',
        );

      case 'user-not-found':
        return AppLanguage.tr(
          en: 'No account found with this email.',
          hi: 'इस ईमेल से कोई अकाउंट नहीं मिला।',
          ne: 'यो इमेलसँग कुनै खाता फेला परेन।',
        );

      case 'wrong-password':
      case 'invalid-credential':
        return AppLanguage.tr(
          en: 'Incorrect email or password.',
          hi: 'ईमेल या पासवर्ड गलत है।',
          ne: 'इमेल वा पासवर्ड गलत छ।',
        );

      case 'user-disabled':
        return AppLanguage.tr(
          en: 'This account has been disabled.',
          hi: 'यह अकाउंट बंद कर दिया गया है।',
          ne: 'यो खाता निष्क्रिय गरिएको छ।',
        );

      case 'too-many-requests':
        return AppLanguage.tr(
          en: 'Too many attempts. Please try again later.',
          hi: 'बहुत अधिक प्रयास हुए। कृपया बाद में प्रयास करें।',
          ne: 'धेरै प्रयासहरू भए। कृपया पछि प्रयास गर्नुहोस्।',
        );

      case 'network-request-failed':
        return AppLanguage.tr(
          en: 'Please check your internet connection.',
          hi: 'कृपया अपना इंटरनेट कनेक्शन जांचें।',
          ne: 'कृपया आफ्नो इन्टरनेट जडान जाँच गर्नुहोस्।',
        );

      default:
        return AppLanguage.tr(
          en: 'Login failed. Please try again.',
          hi: 'लॉगिन विफल रहा। कृपया पुनः प्रयास करें।',
          ne: 'लगइन असफल भयो। कृपया पुनः प्रयास गर्नुहोस्।',
        );
    }
  }

  Future<void> signInWithEmail() async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Already loading
    if (isLoading.value) return;

    // Validate form
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    isLoading.value = true;

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception(
          AppLanguage.tr(
            en: 'Unable to login. Please try again.',
            hi: 'लॉगिन नहीं हो सका। कृपया पुनः प्रयास करें।',
            ne: 'लगइन गर्न सकिएन। कृपया पुनः प्रयास गर्नुहोस्।',
          ),
        );
      }

      await verifyPartnerAndOpenDashboard(user);
    } on FirebaseAuthException catch (error) {
      AppSnackbar.error(firebaseErrorMessage(error));
    } catch (error) {
      AppSnackbar.error(error.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (isLoading.value) return;

    isLoading.value = true;

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: const ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // User cancelled Google login
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user;

      if (user == null) {
        throw Exception(
          AppLanguage.tr(
            en: 'Google login failed. Please try again.',
            hi: 'Google लॉगिन विफल रहा। कृपया पुनः प्रयास करें।',
            ne: 'Google लगइन असफल भयो। कृपया पुनः प्रयास गर्नुहोस्।',
          ),
        );
      }

      await verifyPartnerAndOpenDashboard(user);
    } on FirebaseAuthException catch (error) {
      AppSnackbar.error(firebaseErrorMessage(error));
    } catch (error) {
      final message = error.toString().replaceFirst('Exception: ', '');

      if (!message.toLowerCase().contains('cancel')) {
        AppSnackbar.error(message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyPartnerAndOpenDashboard(User user) async {
    final partnerDoc = await FirebaseFirestore.instance
        .collection('shopkeepers')
        .doc(user.uid)
        .get();

    if (!partnerDoc.exists) {
      Get.toNamed(AppRoutes.shopRegistration, arguments: user);

      return;
    }

    final data = partnerDoc.data();

    if (data?['role'] != 'partner') {
      await FirebaseAuth.instance.signOut();

      throw Exception(
        AppLanguage.tr(
          en: 'This account is not a partner account.',
          hi: 'यह पार्टनर अकाउंट नहीं है।',
          ne: 'यो पार्टनर खाता होइन।',
        ),
      );
    }

    // ==========================================================
    // PARTNER LOGIN SUCCESS
    // ==========================================================

    AppSnackbar.success(
      AppLanguage.tr(
        en: 'Login successful',
        hi: 'लॉगिन सफल रहा',
        ne: 'लगइन सफल भयो',
      ),
    );

    // Go to shopkeeper bottom navigation
    Get.offAllNamed(AppRoutes.shopkeeperbottom);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}
