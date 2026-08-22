import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localmarket/shopkeeper/auth/forgot_password.dart';
import 'package:localmarket/shopkeeper/auth/shop_registration.dart';
import 'package:localmarket/shopkeeper/auth/sign_up.dart';
import 'package:localmarket/shopkeeper/home/bottom_nav.dart';
import 'package:localmarket/shopkeeper/home/dashboard_screen.dart';

import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_padding.dart';
import 'package:localmarket/widget/app_radius.dart';
import 'package:localmarket/widget/app_language.dart';

class PartnerSignInPage extends StatefulWidget {
  const PartnerSignInPage({super.key});

  @override
  State<PartnerSignInPage> createState() => _PartnerSignInPageState();
}

class _PartnerSignInPageState extends State<PartnerSignInPage> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _showMessage(String message, {bool isError = true}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  String _firebaseErrorMessage(FirebaseAuthException error) {
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

  Future<void> _signInWithEmail() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
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

      await _verifyPartnerAndOpenDashboard(user);
    } on FirebaseAuthException catch (error) {
      _showMessage(_firebaseErrorMessage(error));
    } catch (error) {
      _showMessage(error.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyPartnerAndOpenDashboard(User user) async {
    try {
      final partnerDoc = await FirebaseFirestore.instance
          .collection('shopkeepers')
          .doc(user.uid)
          .get();

      if (!partnerDoc.exists) {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ShopRegistrationPage(user: user)),
        );
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

      if (!mounted) return;

      _showMessage(
        AppLanguage.tr(
          en: 'Login successful',
          hi: 'लॉगिन सफल रहा',
          ne: 'लगइन सफल भयो',
        ),
        isError: false,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const shopkeeperbottom()),
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _signInWithGoogle() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
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

      // Verify partner and handle registration
      await _verifyPartnerAndOpenDashboard(user);
    } on FirebaseAuthException catch (error) {
      _showMessage(_firebaseErrorMessage(error));
    } catch (error) {
      final message = error.toString();
      if (!message.toLowerCase().contains('cancel')) {
        _showMessage(message.replaceFirst('Exception: ', ''));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AutofillGroup(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: SizedBox(
                            width: double.infinity,
                            height: 290,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  'assets/shop/signin.jpg',
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),

                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.05),
                                        Colors.black.withOpacity(0.45),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 18,
                                  left: 18,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.45),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.35),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.storefront_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 7),
                                        Text(
                                          AppLanguage.tr(
                                            en: 'Merchant Portal',
                                            hi: 'व्यापारी पोर्टल',
                                            ne: 'व्यापारी पोर्टल',
                                          ),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppTextSizes.md,
                                            fontWeight: AppFontWeights.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 253),
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.7),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 24,
                                spreadRadius: 1,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Icon
                                Container(
                                  height: 68,
                                  width: 68,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.storefront_outlined,
                                    color: AppColors.primary,
                                    size: 38,
                                  ),
                                ),

                                const SizedBox(height: 14),

                                // Merchant Title
                                Text(
                                  AppLanguage.tr(
                                    en: 'NearShop Merchant',
                                    hi: 'नियरशॉप व्यापारी',
                                    ne: 'नियरशप व्यापारी',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: AppTextSizes.h6,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),

                                const SizedBox(height: 7),

                                // Description
                                Text(
                                  AppLanguage.tr(
                                    en: 'Secure access for store administrators.',
                                    hi: 'स्टोर व्यवस्थापकों के लिए सुरक्षित प्रवेश।',
                                    ne: 'स्टोर प्रशासकहरूको लागि सुरक्षित पहुँच।',
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: AppTextSizes.md,
                                    fontWeight: AppFontWeights.regular,
                                    height: 1.4,
                                  ),
                                ),

                                const SizedBox(height: 26),

                                // Email
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.email,
                                    AutofillHints.username,
                                  ],
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  validator: (value) {
                                    final email = value?.trim() ?? '';

                                    if (email.isEmpty) {
                                      return AppLanguage.tr(
                                        en: 'Email is required',
                                        hi: 'ईमेल आवश्यक है',
                                        ne: 'इमेल आवश्यक छ',
                                      );
                                    }

                                    final emailRegex = RegExp(
                                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                    );

                                    if (!emailRegex.hasMatch(email)) {
                                      return AppLanguage.tr(
                                        en: 'Please enter a valid email',
                                        hi: 'कृपया एक मान्य ईमेल दर्ज करें',
                                        ne: 'कृपया मान्य इमेल प्रविष्ट गर्नुहोस्',
                                      );
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: AppLanguage.tr(
                                      en: 'Email address',
                                      hi: 'ईमेल पता',
                                      ne: 'इमेल ठेगाना',
                                    ),
                                    labelStyle: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: AppTextSizes.md,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: AppColors.primary,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.background,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 18,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                        width: 1.8,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Password
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [AutofillHints.password],
                                  onFieldSubmitted: (_) {
                                    if (!_isLoading) {
                                      _signInWithEmail();
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLanguage.tr(
                                        en: 'Password is required',
                                        hi: 'पासवर्ड आवश्यक है',
                                        ne: 'पासवर्ड आवश्यक छ',
                                      );
                                    }

                                    if (value.length < 8) {
                                      return AppLanguage.tr(
                                        en: 'Password must be at least 8 characters',
                                        hi: 'पासवर्ड कम से कम 8 अक्षरों का होना चाहिए',
                                        ne: 'पासवर्ड कम्तीमा ८ अक्षरको हुनुपर्छ',
                                      );
                                    }

                                    return null;
                                  },
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: AppLanguage.tr(
                                      en: 'Password',
                                      hi: 'पासवर्ड',
                                      ne: 'पासवर्ड',
                                    ),
                                    labelStyle: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: AppTextSizes.md,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: AppColors.primary,
                                    ),
                                    suffixIcon: IconButton(
                                      tooltip: _isPasswordVisible
                                          ? 'Hide password'
                                          : 'Show password',
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.background,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 18,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                        width: 1.8,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),

                                // Forgot Password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const ForgotPasswordPage(),
                                              ),
                                            );
                                          },
                                    child: Text(
                                      AppLanguage.tr(
                                        en: 'Forgot Password?',
                                        hi: 'पासवर्ड भूल गए?',
                                        ne: 'पासवर्ड बिर्सनुभयो?',
                                      ),
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: AppTextSizes.md,
                                        fontWeight: AppFontWeights.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Login Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: _isLoading
                                        ? null
                                        : _signInWithEmail,
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColors.primary,
                                      disabledBackgroundColor: AppColors.primary
                                          .withOpacity(0.65),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                    ),
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                              key: ValueKey('loader'),
                                              width: 23,
                                              height: 23,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              AppLanguage.tr(
                                                en: 'Login To Dashboard',
                                                hi: 'डैशबोर्ड में लॉगिन करें',
                                                ne: 'ड्यासबोर्डमा लगइन गर्नुहोस्',
                                              ),
                                              key: const ValueKey('login_text'),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.tertiary,
                                                fontSize: AppTextSizes.xl,
                                                fontWeight: AppFontWeights.bold,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              AppLanguage.tr(
                                en: 'or continue with',
                                hi: 'या इसके साथ जारी रखें',
                                ne: 'वा यससँग जारी राख्नुहोस्',
                              ),
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppTextSizes.md,
                                fontWeight: AppFontWeights.regular,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: _isLoading ? null : _signInWithGoogle,
                        icon: const FaIcon(
                          FontAwesomeIcons.google,
                          size: 20,
                          color: Colors.red,
                        ),
                        label: Text(
                          AppLanguage.tr(
                            en: 'Continue with Google',
                            hi: 'Google के साथ जारी रखें',
                            ne: 'Google मार्फत जारी राख्नुहोस्',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: AppTextSizes.md,
                            fontWeight: AppFontWeights.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.card,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 3,
                        children: [
                          Icon(
                            Icons.person_add_alt_1_outlined,
                            color: AppColors.primary,
                            size: 21,
                          ),
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const PartnerSignUpPage(),
                                      ),
                                    );
                                  },
                            child: Text(
                              AppLanguage.tr(
                                en: "Don't have a store? Sign up here",
                                hi: "स्टोर नहीं है? यहाँ साइन अप करें",
                                ne: "स्टोर छैन? यहाँ साइन अप गर्नुहोस्",
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: AppTextSizes.md,
                                fontWeight: AppFontWeights.bold,
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
      ),
    );
  }
}
