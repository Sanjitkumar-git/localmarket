import 'package:flutter/material.dart';

class AppPadding {
  AppPadding._();

  // ============================================================
  // STANDARD
  // ============================================================

  static const EdgeInsets xs = EdgeInsets.all(4);
  static const EdgeInsets sm = EdgeInsets.all(8);
  static const EdgeInsets md = EdgeInsets.all(12);
  static const EdgeInsets lg = EdgeInsets.all(16);
  static const EdgeInsets xl = EdgeInsets.all(20);
  static const EdgeInsets xxl = EdgeInsets.all(24);
  static const EdgeInsets xxxl = EdgeInsets.all(32);

  // ============================================================
  // HORIZONTAL
  // ============================================================

  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: 8);

  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: 12);

  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: 16);

  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: 24);

  // ============================================================
  // VERTICAL
  // ============================================================

  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: 8);

  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: 12);

  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: 16);

  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: 24);

  // ============================================================
  // SCREEN
  // ============================================================

  static const EdgeInsets screenMobile = EdgeInsets.symmetric(horizontal: 16);

  static const EdgeInsets screenTablet = EdgeInsets.symmetric(horizontal: 32);

  static const EdgeInsets screenDesktop = EdgeInsets.symmetric(horizontal: 48);

  // ============================================================
  // CARD
  // ============================================================

  static const EdgeInsets card = EdgeInsets.all(16);

  static const EdgeInsets cardCompact = EdgeInsets.all(12);

  static const EdgeInsets cardLarge = EdgeInsets.all(24);

  static EdgeInsetsGeometry? get allMd => null;
}
