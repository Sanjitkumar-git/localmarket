import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localmarket/users/utils/form_inputs.dart';
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
  final FaIconData? prifixIcon;
  final ValidationError? validationError;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final Color? prifixIconColor;
  final Widget? suffixIcon;

  const AppTextField({
    super.key,
    required this.controller,
    this.prifixIcon,
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
    this.suffixIcon,
    this.validationError,
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

  Widget? _getSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
        icon: AppIcon(
          icon: _isObscured ? Icons.visibility_off : Icons.visibility,
          size: 32,
          iconSize: 17,
          iconColor: AppColors.primaryDark,
        ),
      );
    }
    return widget.suffixIcon;
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
            TextStyle(color: AppColors.black, fontSize: AppTextSizes.md),
        floatingLabelStyle:
            widget.floatingLabelStyle ??
            const TextStyle(
              color: AppColors.primary,
              fontWeight: AppFontWeights.bold,
            ),
        hintText: widget.hint,
        errorText: widget.validationError?.errorText,
        suffixIcon: _getSuffixIcon(),
        prefixIcon: widget.prifixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: FaIcon(
                  widget.prifixIcon,
                  size: 18,
                  color: AppColors.primaryDark,
                ),
              ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
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
