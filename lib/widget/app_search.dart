import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localmarket/widget/app_colors.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onMicTap;
  final VoidCallback? onFilterTap;

  const AppSearchBar({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.onMicTap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        prefixIcon: const Icon(Icons.search, size: 22),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onMicTap != null)
              IconButton(
                onPressed: onMicTap,
                icon: const FaIcon(FontAwesomeIcons.microphone, size: 16),
              ),
            if (onFilterTap != null)
              IconButton(
                onPressed: onFilterTap,
                icon: const Icon(Icons.tune, size: 20),
              ),
          ],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}