import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  // ============================================================
  // BREAKPOINTS
  // ============================================================

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  // ============================================================
  // DEVICE TYPE
  // ============================================================

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return width >= mobileBreakpoint &&
        width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tabletBreakpoint;
  }

  // ============================================================
  // SCREEN WIDTH
  // ============================================================

  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double height(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  // ============================================================
  // RESPONSIVE VALUE
  // ============================================================

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    }

    if (isTablet(context)) {
      return tablet ?? mobile;
    }

    return mobile;
  }

  // ============================================================
  // RESPONSIVE PADDING
  // ============================================================

  static EdgeInsets screenPadding(BuildContext context) {
    if (isDesktop(context)) {
      return const EdgeInsets.symmetric(horizontal: 48);
    }

    if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 32);
    }

    return const EdgeInsets.symmetric(horizontal: 16);
  }

  // ============================================================
  // RESPONSIVE FONT
  // ============================================================

  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return value(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}