import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';

enum AppButton { primary, secondary }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButton type;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final double height;
  final bool isFullWidth;
  final bool isLoading;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButton.primary,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 8.0,
    this.height = 40.0,
    this.isFullWidth = true,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    final Color bgColor =
        backgroundColor ??
        (type == AppButton.primary ? AppColors.primaryDark : AppColors.primary);

    final Color fgColor =
        foregroundColor ??
        (type == AppButton.primary ? AppColors.white : AppColors.primary);

    final Widget content = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2.5, color: fgColor),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: fgColor, size: 20),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  color: fgColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: content,
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Alignment geometryAlignment;
  final EdgeInsetsGeometry? padding;

  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.geometryAlignment = Alignment.center,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          padding: padding ?? EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.primary,
            fontSize: fontSize ?? AppTextSizes.md,
            fontWeight: fontWeight ?? AppFontWeights.bold,
          ),
        ),
      ),
    );
  }
}
