import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  // ============================================================
  // RADIUS VALUES
  // ============================================================

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;

  /// For pill-shaped buttons/chips
  static const double pill = 100;

  // ============================================================
  // BORDER RADIUS
  // ============================================================

  static const BorderRadius small =
      BorderRadius.all(Radius.circular(sm));

  static const BorderRadius medium =
      BorderRadius.all(Radius.circular(md));

  static const BorderRadius large =
      BorderRadius.all(Radius.circular(lg));

  static const BorderRadius extraLarge =
      BorderRadius.all(Radius.circular(xl));

  static const BorderRadius rounded =
      BorderRadius.all(Radius.circular(xxl));

  static const BorderRadius pillRadius =
      BorderRadius.all(Radius.circular(pill));
}