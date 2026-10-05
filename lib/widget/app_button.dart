import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';

// Outline type pan add karyo chhe
enum AppButton { primary, secondary, outline }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButton type;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor; // Outline mate border color
  final double borderRadius;
  final double height;
  final bool isFullWidth;
  final bool isLoading;
  final Widget? icon; // FaIcon va mate Widget rakhi didhu chhe

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButton.primary,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius = 14.0,
    this.height = 50.0,
    this.isFullWidth = true,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Jare type == AppButton.outline hoy tyare color badlai jase
    final bool isOutline = type == AppButton.outline;

    final Color bgColor = backgroundColor ??
        (isOutline
            ? Colors.white
            : (type == AppButton.primary ? AppColors.primaryDark : AppColors.primary));

    final Color fgColor = foregroundColor ??
        (isOutline ? AppColors.textPrimary : (type == AppButton.primary ? AppColors.white : AppColors.primary));

    final Color outlineColor = borderColor ?? AppColors.primary.withOpacity(0.3);

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
                icon!,
                const SizedBox(width: 10),
              ],
              Text(
                text,
                style: TextStyle(
                  color: fgColor,
                  fontSize: 15,
                  fontWeight: AppFontWeights.bold,
                ),
              ),
            ],
          );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: isOutline
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed) ||
                      states.contains(WidgetState.focused) ||
                      states.contains(WidgetState.hovered)) {
                    return AppColors.primary.withOpacity(0.05);
                  }
                  return bgColor;
                }),
                side: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed) ||
                      states.contains(WidgetState.focused)) {
                    return BorderSide(color: AppColors.primary, width: 1.5);
                  }
                  return BorderSide(color: outlineColor, width: 1);
                }),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
              child: content,
            )
          : ElevatedButton(
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
