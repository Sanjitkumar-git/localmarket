import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';

enum IconShape { roundedRectangle, circle, square }

class AppIcon extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final double iconSize;
  final Color iconColor;

  final double size;
  final IconShape shape;
  final double borderRadius;
  final Border? border;
  final VoidCallback? onTap;

  const AppIcon({
    super.key,
    this.icon,
    this.iconWidget,
    this.iconSize = 24.0,
    this.iconColor = AppColors.primaryDark,

    this.size = 48.0,
    this.shape = IconShape.roundedRectangle,
    this.borderRadius = 12.0,
    this.border,
    this.onTap,
  }) : assert(
         icon != null || iconWidget != null,
         'You must provide either an icon or an iconWidget',
       );

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    switch (shape) {
      case IconShape.circle:
        decoration = BoxDecoration(shape: BoxShape.circle, border: border);
        break;
      case IconShape.square:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.zero,
          border: border,
        );
        break;
      case IconShape.roundedRectangle:
      default:
        decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
        );
        break;
    }

    final Widget renderIcon =
        iconWidget ?? Icon(icon, size: iconSize, color: iconColor);

    final Widget container = Container(
      width: size,
      height: size,
      decoration: decoration,
      alignment: Alignment.center,
      child: renderIcon,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: container);
    }

    return container;
  }
}
