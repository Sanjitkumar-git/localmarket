import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_font.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_icon.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final bool isPassword;
  final bool initialObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final Color? prifixIconColor;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.labelStyle,
    this.floatingLabelStyle,
    this.isPassword = false,
    this.initialObscure = true,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction,
    this.prifixIconColor,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword ? widget.initialObscure : false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (_) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle:
            widget.labelStyle ??
            TextStyle(
              color: AppColors.black,
              fontWeight: AppFontWeights.bold,
              fontSize: AppTextSizes.md,
            ),
        floatingLabelStyle:
            widget.floatingLabelStyle ??
            const TextStyle(
              color: AppColors.primary,
              fontWeight: AppFontWeights.bold,
            ),
        hintText: widget.hint,

        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: AppIcon(
                  icon: _isObscured ? Icons.visibility_off : Icons.visibility,
                  size: 32,
                  iconSize: 18,
                  iconColor: AppColors.primaryDark,
                ),
              )
            : null,
        filled: true,
        fillColor: AppColors.tertiary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.black, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }
}
