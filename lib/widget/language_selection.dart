import 'package:flutter/material.dart';
import 'package:localmarket/shopkeeper/auth/sign_in.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> languages = [
    {'name': 'English', 'nativeName': 'English', 'flag': '🇬🇧'},
    {'name': 'Hindi', 'nativeName': 'हिंदी', 'flag': '🇮🇳'},
    {'name': 'Nepali', 'nativeName': 'नेपाली', 'flag': '🇳🇵'},
  ];

  void _continue() {
    // Selected language ko globally set karna
    AppLanguage.currentLanguage = _selectedLanguage;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PartnerSignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Icon(Icons.language, size: 55, color: AppColors.primary),

                  const SizedBox(height: 20),

                  Text(
                    'Choose Language',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppTextSizes.h6,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Select your preferred language',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppTextSizes.md,
                    ),
                  ),

                  const SizedBox(height: 25),

                  ...languages.map((language) {
                    final isSelected = _selectedLanguage == language['name'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedLanguage = language['name']!;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                language['flag']!,
                                style: const TextStyle(fontSize: 24),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      language['name']!,
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: AppTextSizes.md,
                                        fontWeight: AppFontWeights.bold,
                                      ),
                                    ),
                                    Text(
                                      language['nativeName']!,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: AppTextSizes.sm,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: AppColors.tertiary,
                          fontSize: AppTextSizes.lg,
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
    );
  }
}
