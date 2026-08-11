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
}
