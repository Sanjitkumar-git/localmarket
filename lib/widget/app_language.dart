import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLanguage {
  static String currentLanguage = 'English';

  static String tr({
    required String en,
    required String hi,
    required String ne,
  }) {
    switch (currentLanguage) {
      case 'Hindi':
        return hi;

      case 'Nepali':
        return ne;

      case 'English':
      default:
        return en;
    }
  }

  static Future<void> changeLanguage(
    BuildContext context,
    String language,
  ) async {
    currentLanguage = language;

    switch (language) {
      case 'Hindi':
        await context.setLocale(const Locale('hi'));
        break;

      case 'Nepali':
        await context.setLocale(const Locale('ne'));
        break;

      case 'English':
      default:
        await context.setLocale(const Locale('en'));
        break;
    }
  }

  static String getLanguageFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'hi':
        return 'Hindi';

      case 'ne':
        return 'Nepali';

      case 'en':
      default:
        return 'English';
    }
  }
}
