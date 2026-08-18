import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';
import 'package:localmarket/widget/role_selection.dart';

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
    AppLanguage.currentLanguage = _selectedLanguage;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RoleSelectionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -90,
              right: -70,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.07),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.05),
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.language_rounded,
                              size: 38,
                              color: AppColors.primary,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Choose Language',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: AppTextSizes.h6,
                            fontWeight: AppFontWeights.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Select your preferred language to continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextSizes.md,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 28),

                        Text(
                          'AVAILABLE LANGUAGES',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextSizes.sm,
                            fontWeight: AppFontWeights.bold,
                            letterSpacing: 0.8,
                          ),
                        ),

                        const SizedBox(height: 12),

                        ...languages.map((language) => _languageTile(language)),

                        const SizedBox(height: 14),

                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _continue,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.tertiary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: AppTextSizes.lg,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 21,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          'You can change your language later from settings.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppTextSizes.sm,
                          ),
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
    );
  }

  Widget _languageTile(Map<String, String> language) {
    final bool isSelected = _selectedLanguage == language['name'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Semantics(
        button: true,
        selected: isSelected,
        label: '${language['name']} language',
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedLanguage = language['name']!;
            });
          },
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.10)
                  : AppColors.background.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                width: isSelected ? 1.6 : 1,
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    language['flag']!,
                    style: const TextStyle(fontSize: 26),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
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
                      const SizedBox(height: 3),
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

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          key: const ValueKey('selected'),
                          color: AppColors.primary,
                          size: 25,
                        )
                      : Icon(
                          Icons.radio_button_unchecked_rounded,
                          key: const ValueKey('unselected'),
                          color: Colors.grey.shade400,
                          size: 23,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
