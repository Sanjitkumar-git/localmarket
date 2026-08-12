import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localmarket/shopkeeper/auth/forgot_password.dart';
import 'package:localmarket/shopkeeper/auth/sign_up.dart';
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

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      print('Google Sign-In Successful');
    } catch (e) {
      print('Google Sign-In Error: $e');
    }
  }

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
                    height: 390,

                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Form(
                      key: _formKey,

                      child: Column(
                        children: [
                          Padding(
                            padding: AppPadding.xs,

                            child: Container(
                              height: 50,
                              width: 50,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: Icon(
                                Icons.storefront_outlined,
                                color: AppColors.primary,
                                size: 50,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Merchant Portal
                          Text(
                            AppLanguage.tr(
                              en: 'NearShop Merchant',
                              hi: 'नियरशॉप व्यापारी',
                              ne: 'नियरशप व्यापारी',
                            ),

                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppTextSizes.h6,
                              fontWeight: AppFontWeights.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          // Description
                          Text(
                            AppLanguage.tr(
                              en: 'Secure access for store administrators.',
                              hi: 'स्टोर व्यवस्थापकों के लिए सुरक्षित प्रवेश।',
                              ne: 'स्टोर प्रशासकहरूको लागि सुरक्षित पहुँच।',
                            ),

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: AppTextSizes.md,
                              fontWeight: AppFontWeights.regular,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Email
                          Padding(
                            padding: AppPadding.horizontalMd,

                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                ),

                                labelText: AppLanguage.tr(
                                  en: 'Email',
                                  hi: 'ईमेल',
                                  ne: 'इमेल',
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          // Password
                          Padding(
                            padding: AppPadding.horizontalMd,

                            child: TextFormField(
                              controller: _passwordController,

                              obscureText: !_isPasswordVisible,

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

                              style: TextStyle(color: AppColors.textPrimary),

                              decoration: InputDecoration(
                                labelText: AppLanguage.tr(
                                  en: 'Password',
                                  hi: 'पासवर्ड',
                                  ne: 'पासवर्ड',
                                ),

                                labelStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                ),

                                border: OutlineInputBorder(
                                  borderRadius: AppRadius.medium,
                                ),

                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },

                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,

                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,

                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
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

                          const SizedBox(height: 10),

                          // Login Button
                          SizedBox(
                            width: 330,
                            height: 60,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                try {
                                  // 1. Firebase Authentication se login
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text
                                            .trim(),
                                      );

                                  // 2. Logged-in user ki UID
                                  final uid = credential.user!.uid;

                                  // 3. Firestore mein partner profile check
                                  final partnerDoc = await FirebaseFirestore
                                      .instance
                                      .collection('shopkeepers')
                                      .doc(uid)
                                      .get();

                                  // 4. Partner profile nahi mila
                                  if (!partnerDoc.exists) {
                                    await FirebaseAuth.instance.signOut();

                                    throw Exception(
                                      'Partner account not found.',
                                    );
                                  }

                                  // 5. Partner data
                                  final data = partnerDoc.data();

                                  // 6. Role check
                                  if (data?['role'] != 'partner') {
                                    await FirebaseAuth.instance.signOut();

                                    throw Exception(
                                      'This account is not a partner account.',
                                    );
                                  }

                                  // 7. Login successful
                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Login successful'),
                                    ),
                                  );

                                  // 8. Partner Dashboard
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DashboardScreen(),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  String message;

                                  switch (e.code) {
                                    case 'invalid-email':
                                      message = 'Please enter a valid email.';
                                      break;

                                    case 'user-not-found':
                                      message =
                                          'No account found with this email.';
                                      break;

                                    case 'wrong-password':
                                    case 'invalid-credential':
                                      message = 'Incorrect email or password.';
                                      break;

                                    case 'user-disabled':
                                      message =
                                          'This account has been disabled.';
                                      break;

                                    default:
                                      message =
                                          'Login failed. Please try again.';
                                  }

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                } catch (e) {
                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        e.toString().replaceFirst(
                                          'Exception: ',
                                          '',
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },

                              child: Text(
                                AppLanguage.tr(
                                  en: 'Login To Dashboard',
                                  hi: 'डैशबोर्ड में लॉगिन करें',
                                  ne: 'ड्यासबोर्डमा लगइन गर्नुहोस्',
                                ),

                                style: TextStyle(
                                  color: AppColors.tertiary,
                                  fontSize: AppTextSizes.xl,
                                  fontWeight: AppFontWeights.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // OR
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  AppLanguage.tr(en: 'or', hi: 'या', ne: 'वा'),

                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppTextSizes.xl,
                    fontWeight: AppFontWeights.bold,
                  ),
                ),
              ),

              // Google Login
              Padding(
                padding: const EdgeInsets.only(bottom: 20),

                child: SizedBox(
                  width: 330,
                  height: 55,

                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await signInWithGoogle();
                    },

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

                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppTextSizes.md,
                        fontWeight: AppFontWeights.bold,
                      ),
                    ),

                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,

                      side: BorderSide(color: Colors.grey.shade300),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add_alt_1, color: AppColors.primary),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PartnerSignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      AppLanguage.tr(
                        en: "Don't have a store? Sign up here",
                        hi: "स्टोर नहीं है? यहाँ साइन अप करें",
                        ne: "स्टोर छैन? यहाँ साइन अप गर्नुहोस्",
                      ),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: AppTextSizes.md,
                        fontWeight: AppFontWeights.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
