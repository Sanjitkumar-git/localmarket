import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_language.dart';

class LanguageDialog {
  static void show(BuildContext context) {
    final String currentLanguage = AppLanguage.getLanguageFromLocale(
      context.locale,
    );

    Get.dialog(
      _LanguageDialogContent(
        parentContext: context,
        initialLanguage: currentLanguage,
      ),
    );
  }
}

class _LanguageDialogContent extends StatefulWidget {
  final BuildContext parentContext;
  final String initialLanguage;

  const _LanguageDialogContent({
    required this.parentContext,
    required this.initialLanguage,
  });

  @override
  State<_LanguageDialogContent> createState() => _LanguageDialogContentState();
}

class _LanguageDialogContentState extends State<_LanguageDialogContent> {
  static const _green = Color(0xFF1B7F3B);
  static const _darkGreen = Color(0xFF0F5A28);

  late String _selected;
  bool _changing = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialLanguage;
  }

  Future<void> _onSelect(String value) async {
    if (_changing) return;

    setState(() {
      _selected = value;
      _changing = true;
    });

    await AppLanguage.changeLanguage(widget.parentContext, value);

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [_green, _darkGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  right: -30,
                  top: -30,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  bottom: -34,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.06),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.18),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.translate_rounded,
                              color: _green,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLanguage.tr(
                                    en: 'Select Language',
                                    hi: 'भाषा चुनें',
                                    ne: 'भाषा छान्नुहोस्',
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppTextSizes.h5,
                                    fontWeight: AppFontWeights.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  AppLanguage.tr(
                                    en: 'Choose your preferred language',
                                    hi: 'अपनी पसंदीदा भाषा चुनें',
                                    ne: 'आफ्नो मनपर्ने भाषा छान्नुहोस्',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: AppTextSizes.caption,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: _changing ? null : () => Get.back(),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      _languageTile(
                        value: 'English',
                        badge: 'E',
                        title: 'English',
                        subtitle: 'English',
                      ),
                      const SizedBox(height: 10),
                      _languageTile(
                        value: 'Hindi',
                        badge: 'हि',
                        title: 'हिंदी',
                        subtitle: 'Hindi',
                      ),
                      const SizedBox(height: 10),
                      _languageTile(
                        value: 'Nepali',
                        badge: 'ने',
                        title: 'नेपाली',
                        subtitle: 'Nepali',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageTile({
    required String value,
    required String badge,
    required String title,
    required String subtitle,
  }) {
    final bool selected = _selected == value;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? Colors.white : Colors.white.withOpacity(0.28),
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _onSelect(value),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                // Badge
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? _green.withOpacity(0.12)
                        : Colors.white.withOpacity(0.2),
                  ),
                  child: Text(
                    badge,
                    style: TextStyle(
                      color: selected ? _green : Colors.white,
                      fontSize: AppTextSizes.button,
                      fontWeight: AppFontWeights.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selected ? _darkGreen : Colors.white,
                          fontSize: AppTextSizes.button,
                          fontWeight: AppFontWeights.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selected
                              ? _darkGreen.withOpacity(0.7)
                              : Colors.white.withOpacity(0.75),
                          fontSize: AppTextSizes.caption,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Check
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? _green : Colors.transparent,
                    border: Border.all(
                      color: selected ? _green : Colors.white.withOpacity(0.5),
                      width: 1.6,
                    ),
                  ),
                  child: selected
                      ? (_changing
                            ? const Padding(
                                padding: EdgeInsets.all(6),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 16,
                              ))
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
