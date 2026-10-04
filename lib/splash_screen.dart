import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localmarket/widget/language_selection.dart';

/// ---------------------------------------------------------------------------
/// Palette
/// ---------------------------------------------------------------------------
class SplashPalette {
  const SplashPalette._();

  static const Color primaryGreen = Color(0xFF2E7D32);
  static const Color secondaryGreen = Color(0xFF4CAF50);
  static const Color mintGreen = Color(0xFFA5D6A7);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color bgLight = Color(0xFFF7F9FC);
  static const Color bgTint = Color(0xFFECFDF5);
  static const Color darkText = Color(0xFF1E293B);
  static const Color mutedText = Color(0xFF64748B);
  static const Color faintText = Color(0xFF94A3B8);
}

@immutable
class _SplashMetrics {
  const _SplashMetrics._({
    required this.scale,
    required this.size,
    required this.isLandscape,
    required this.isTablet,
    required this.isCompactHeight,
  });

  final double scale;
  final Size size;
  final bool isLandscape;
  final bool isTablet;
  final bool isCompactHeight;

  factory _SplashMetrics.from(Size size) {
    final shortest = size.shortestSide;
    final isLandscape = size.width > size.height;
    final isTablet = shortest >= 600;

    // Width-driven base scale.
    double s;
    if (shortest < 320) {
      s = 0.76; // very small / split-screen
    } else if (shortest < 360) {
      s = 0.86; // small phones
    } else if (shortest < 400) {
      s = 0.95; // most phones
    } else if (shortest < 600) {
      s = 1.00; // large phones
    } else if (shortest < 840) {
      s = 1.18; // tablets
    } else {
      s = 1.32; // large tablets / desktop
    }

    // Height-driven correction (landscape phones, foldables, split-screen).
    if (size.height < 520) {
      s *= 0.72;
    } else if (size.height < 620) {
      s *= 0.84;
    } else if (size.height < 720) {
      s *= 0.93;
    }

    return _SplashMetrics._(
      scale: s.clamp(0.58, 1.40),
      size: size,
      isLandscape: isLandscape,
      isTablet: isTablet,
      isCompactHeight: size.height < 640,
    );
  }

  /// Scale a design value.
  double r(double v) => v * scale;

  double _c(double v, double min, double max) => v.clamp(min, max);

  // ── Logo ────────────────────────────────────────────────────────────────
  double get markSize => _c(r(isLandscape ? 168 : 190), 100, 260);
  double get badgeSize => markSize * 0.59;
  double get badgeRadius => badgeSize * 0.30;
  double get logoIconSize => badgeSize * 0.52;
  double get haloSize => markSize * 0.79;
  double get pipOffset => (markSize - badgeSize) / 2 - badgeSize * 0.045;
  double get pipIconSize => _c(badgeSize * 0.11, 9, 18);
  double get pipPadding => _c(badgeSize * 0.055, 4, 9);

  // ── Typography ──────────────────────────────────────────────────────────
  double get titleSize => _c(r(32), 21, 46);
  double get tagFontSize => _c(r(12.5), 10.5, 17);
  double get captionSize => _c(r(12.5), 10.5, 16);
  double get footerSize => _c(r(11.5), 9.5, 15);
  double get footerIconSize => _c(r(14), 12, 20);

  // ── Progress ────────────────────────────────────────────────────────────
  double get progressWidth => _c(r(160), 110, 300);
  double get progressHeight => _c(r(5), 4, 9);

  // ── Spacing ─────────────────────────────────────────────────────────────
  double get gapXs => _c(r(6), 4, 10);
  double get gapSm => _c(r(12), 8, 20);
  double get gapMd => _c(r(16), 10, 26);
  double get gapLg => _c(r(24), 14, 40);
  double get gapXl => _c(r(32), 16, 56);

  // ── Layout ──────────────────────────────────────────────────────────────
  double get hPadding {
    if (isTablet) return 48;
    return size.width < 360 ? 18 : 26;
  }

  double get maxContentWidth {
    if (isLandscape) return 780;
    return isTablet ? 560 : 480;
  }

  /// Extra padding so content is centered & capped on wide screens.
  double horizontalInsetFor(double availableWidth) {
    final capped = (availableWidth - maxContentWidth) / 2;
    return math.max(hPadding, capped > 0 ? capped : hPadding);
  }
}

/// ---------------------------------------------------------------------------
/// Splash Screen
/// ---------------------------------------------------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _intro;
  late final AnimationController _ambient;
  late final AnimationController _progress;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _progressValue;

  bool _navigated = false;
  bool _reduceMotion = false;

  static const Duration _introDuration = Duration(milliseconds: 1500);
  static const Duration _holdDuration = Duration(seconds: 4);

  @override
  void initState() {
    super.initState();

    _intro = AnimationController(vsync: this, duration: _introDuration);

    _ambient = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _progress = AnimationController(vsync: this, duration: _holdDuration)
      ..addStatusListener((s) {
        if (s == AnimationStatus.completed) _goNext();
      });

    _logoFade = CurvedAnimation(
      parent: _intro,
      curve: const Interval(0.0, 0.40, curve: Curves.easeOut),
    );

    _logoScale = Tween<double>(begin: 0.70, end: 1.0).animate(
      CurvedAnimation(
        parent: _intro,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
      ),
    );

    _progressValue = CurvedAnimation(
      parent: _progress,
      curve: Curves.easeInOutCubic,
    );

    _intro.forward();
    _progress.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Accessibility: honour "reduce motion".
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduce != _reduceMotion) {
      _reduceMotion = reduce;
      if (reduce) {
        _intro.value = 1.0;
        _ambient.stop();
      } else if (!_ambient.isAnimating) {
        _ambient.repeat();
      }
    }
  }

  @override
  void dispose() {
    _intro.dispose();
    _ambient.dispose();
    _progress.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_navigated || !mounted) return;
    _navigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, _, _) => const LanguageSelectionPage(),
        transitionsBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 1.04, end: 1.0).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: SplashPalette.bgLight,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      // Cap user font scaling so the layout never breaks.
      child: MediaQuery.withClampedTextScaling(
        minScaleFactor: 0.9,
        maxScaleFactor: 1.25,
        child: Scaffold(
          backgroundColor: SplashPalette.bgLight,
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  SplashPalette.bgTint,
                  SplashPalette.bgLight,
                  Color(0xFFFFFDF7),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final m = _SplashMetrics.from(
                  Size(constraints.maxWidth, constraints.maxHeight),
                );

                return Stack(
                  children: [
                    if (!_reduceMotion)
                      Positioned.fill(
                        child: RepaintBoundary(
                          child: _AmbientBlobs(animation: _ambient, metrics: m),
                        ),
                      ),
                    SafeArea(
                      child: _ScrollSafe(
                        metrics: m,
                        availableHeight: constraints.maxHeight,
                        availableWidth: constraints.maxWidth,
                        child: m.isLandscape
                            ? _buildLandscape(m)
                            : _buildPortrait(m),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ── Portrait ──────────────────────────────────────────────────────────────
  Widget _buildPortrait(_SplashMetrics m) {
    return Column(
      children: [
        const Spacer(flex: 5),
        _logo(m),
        SizedBox(height: m.gapXl),
        _title(m, alignStart: false),
        SizedBox(height: m.gapMd),
        _tagline(m, alignStart: false),
        const Spacer(flex: 5),
        _progressBlock(m, alignStart: false),
        SizedBox(height: m.isCompactHeight ? m.gapLg : m.gapXl),
        _footer(m),
        SizedBox(height: m.gapMd),
      ],
    );
  }

  // ── Landscape ─────────────────────────────────────────────────────────────
  Widget _buildLandscape(_SplashMetrics m) {
    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logo(m),
              SizedBox(width: m.gapXl),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(m, alignStart: true),
                    SizedBox(height: m.gapSm),
                    _tagline(m, alignStart: true),
                    SizedBox(height: m.gapLg),
                    _progressBlock(m, alignStart: true),
                  ],
                ),
              ),
            ],
          ),
        ),
        _footer(m),
        SizedBox(height: m.gapSm),
      ],
    );
  }

  // ── Pieces ────────────────────────────────────────────────────────────────
  Widget _logo(_SplashMetrics m) => FadeTransition(
    opacity: _logoFade,
    child: ScaleTransition(
      scale: _logoScale,
      child: _LogoMark(
        pulse: _ambient,
        metrics: m,
        animatePulse: !_reduceMotion,
      ),
    ),
  );

  Widget _title(_SplashMetrics m, {required bool alignStart}) => _Entrance(
    controller: _intro,
    start: 0.35,
    end: 0.75,
    child: ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        colors: [SplashPalette.darkText, SplashPalette.primaryGreen],
      ).createShader(rect),
      child: Text(
        'My Local Market',
        textAlign: alignStart ? TextAlign.start : TextAlign.center,
        style: TextStyle(
          fontSize: m.titleSize,
          height: 1.1,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.8,
          color: Colors.white,
        ),
      ),
    ),
  );

  Widget _tagline(_SplashMetrics m, {required bool alignStart}) => _Entrance(
    controller: _intro,
    start: 0.50,
    end: 0.90,
    child: _TaglineStrip(
      metrics: m,
      alignStart: alignStart,
      items: const ['Save More', 'Waste Less', 'Support Local'],
    ),
  );

  Widget _progressBlock(_SplashMetrics m, {required bool alignStart}) =>
      _Entrance(
        controller: _intro,
        start: 0.60,
        end: 1.00,
        offset: const Offset(0, 0.6),
        child: Column(
          crossAxisAlignment: alignStart
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _ProgressBar(value: _progressValue, metrics: m),
            SizedBox(height: m.gapSm),
            Text(
              'Finding fresh deals near you…',
              textAlign: alignStart ? TextAlign.start : TextAlign.center,
              style: TextStyle(
                fontSize: m.captionSize,
                fontWeight: FontWeight.w500,
                color: SplashPalette.mutedText,
              ),
            ),
          ],
        ),
      );

  Widget _footer(_SplashMetrics m) => _Entrance(
    controller: _intro,
    start: 0.70,
    end: 1.00,
    offset: const Offset(0, 0.8),
    child: _FooterBadge(
      metrics: m,
      text: 'Hyperlocal Discovery • Self-Pickup Only',
    ),
  );
}

/// ---------------------------------------------------------------------------
/// Keeps content centered + width-capped, and scrollable if it ever overflows.
/// ---------------------------------------------------------------------------
class _ScrollSafe extends StatelessWidget {
  const _ScrollSafe({
    required this.child,
    required this.metrics,
    required this.availableHeight,
    required this.availableWidth,
  });

  final Widget child;
  final _SplashMetrics metrics;
  final double availableHeight;
  final double availableWidth;

  @override
  Widget build(BuildContext context) {
    final hInset = metrics.horizontalInsetFor(availableWidth);

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: availableHeight),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hInset),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Reusable staggered fade + slide entrance
/// ---------------------------------------------------------------------------
class _Entrance extends StatelessWidget {
  const _Entrance({
    required this.controller,
    required this.start,
    required this.end,
    required this.child,
    this.offset = const Offset(0, 0.35),
  });

  final AnimationController controller;
  final double start;
  final double end;
  final Offset offset;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween<Offset>(begin: offset, end: Offset.zero).animate(curve),
        child: child,
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Logo with breathing glow rings
/// ---------------------------------------------------------------------------
class _LogoMark extends StatelessWidget {
  const _LogoMark({
    required this.pulse,
    required this.metrics,
    this.animatePulse = true,
  });

  final Animation<double> pulse;
  final _SplashMetrics metrics;
  final bool animatePulse;

  @override
  Widget build(BuildContext context) {
    final m = metrics;

    return SizedBox(
      width: m.markSize,
      height: m.markSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (animatePulse)
            AnimatedBuilder(
              animation: pulse,
              builder: (_, _) {
                final t = pulse.value;
                return Stack(
                  alignment: Alignment.center,
                  children: [_ring(t), _ring((t + 0.5) % 1.0)],
                );
              },
            ),

          // Soft ambient halo
          Container(
            width: m.haloSize,
            height: m.haloSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  SplashPalette.secondaryGreen.withValues(alpha: 0.18),
                  SplashPalette.secondaryGreen.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),

          // Squircle badge
          Container(
            width: m.badgeSize,
            height: m.badgeSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF66BB6A),
                  SplashPalette.secondaryGreen,
                  SplashPalette.primaryGreen,
                ],
              ),
              borderRadius: BorderRadius.circular(m.badgeRadius),
              boxShadow: [
                BoxShadow(
                  color: SplashPalette.primaryGreen.withValues(alpha: 0.34),
                  blurRadius: m.r(34),
                  spreadRadius: -2,
                  offset: Offset(0, m.r(16)),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(m.badgeRadius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.center,
                        colors: [
                          Colors.white.withValues(alpha: 0.28),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Icon(
                    Icons.storefront_rounded,
                    size: m.logoIconSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Orange accent pip
          Positioned(
            right: m.pipOffset,
            top: m.pipOffset,
            child: Container(
              padding: EdgeInsets.all(m.pipPadding),
              decoration: BoxDecoration(
                color: SplashPalette.accentOrange,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: SplashPalette.accentOrange.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.bolt_rounded,
                size: m.pipIconSize,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ring(double t) {
    final m = metrics;
    final size = m.badgeSize + ((m.markSize - m.badgeSize) * t);
    final opacity = (1.0 - t) * 0.35;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: SplashPalette.secondaryGreen.withValues(alpha: opacity),
          width: 1.6,
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Tagline pills (wraps automatically on narrow screens)
/// ---------------------------------------------------------------------------
class _TaglineStrip extends StatelessWidget {
  const _TaglineStrip({
    required this.items,
    required this.metrics,
    this.alignStart = false,
  });

  final List<String> items;
  final _SplashMetrics metrics;
  final bool alignStart;

  @override
  Widget build(BuildContext context) {
    final m = metrics;

    return Wrap(
      alignment: alignStart ? WrapAlignment.start : WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: m.gapXs + 2,
      runSpacing: m.gapXs + 2,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: m.gapSm,
              vertical: m.gapXs,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: SplashPalette.mintGreen.withValues(alpha: 0.55),
              ),
              boxShadow: [
                BoxShadow(
                  color: SplashPalette.primaryGreen.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              items[i],
              style: TextStyle(
                fontSize: m.tagFontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
                color: SplashPalette.mutedText,
              ),
            ),
          ),
          if (i != items.length - 1)
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: SplashPalette.accentOrange,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// Slim gradient progress bar
/// ---------------------------------------------------------------------------
class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value, required this.metrics});

  final Animation<double> value;
  final _SplashMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: metrics.progressWidth,
      height: metrics.progressHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: SplashPalette.primaryGreen.withValues(alpha: 0.10),
              ),
            ),
            AnimatedBuilder(
              animation: value,
              builder: (_, _) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value.value.clamp(0.02, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    gradient: const LinearGradient(
                      colors: [
                        SplashPalette.secondaryGreen,
                        SplashPalette.primaryGreen,
                        SplashPalette.accentOrange,
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
}

/// ---------------------------------------------------------------------------
/// Footer badge
/// ---------------------------------------------------------------------------
class _FooterBadge extends StatelessWidget {
  const _FooterBadge({required this.text, required this.metrics});

  final String text;
  final _SplashMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.pin_drop_rounded,
          size: metrics.footerIconSize,
          color: SplashPalette.accentOrange,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: metrics.footerSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: SplashPalette.faintText,
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// Ambient floating background blobs (sized relative to the screen)
/// ---------------------------------------------------------------------------
class _AmbientBlobs extends StatelessWidget {
  const _AmbientBlobs({required this.animation, required this.metrics});

  final Animation<double> animation;
  final _SplashMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final unit = metrics.size.shortestSide;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final t = animation.value * 2 * math.pi;
        return Stack(
          children: [
            _blob(
              top: -unit * 0.18 + math.sin(t) * 14,
              left: -unit * 0.16 + math.cos(t) * 12,
              size: unit * 0.66,
              color: SplashPalette.secondaryGreen.withValues(alpha: 0.16),
            ),
            _blob(
              top: metrics.size.height * 0.18 + math.cos(t) * 18,
              right: -unit * 0.24,
              size: unit * 0.55,
              color: SplashPalette.accentOrange.withValues(alpha: 0.11),
            ),
            _blob(
              bottom: -unit * 0.20 + math.sin(t + 1) * 16,
              left: -unit * 0.14,
              size: unit * 0.72,
              color: SplashPalette.mintGreen.withValues(alpha: 0.22),
            ),
          ],
        );
      },
    );
  }

  Widget _blob({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, color.withValues(alpha: 0)],
            ),
          ),
        ),
      ),
    );
  }
}
