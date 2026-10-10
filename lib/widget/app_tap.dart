import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';

class CategoryTabItem {
  final String key;
  final String label;
  final IconData? icon;

  const CategoryTabItem({required this.key, required this.label, this.icon});
}

class AppCategoryTabs extends StatelessWidget {
  final List<CategoryTabItem> items;
  final String selectedKey;
  final ValueChanged<String> onSelected;

  const AppCategoryTabs({
    super.key,
    required this.items,
    required this.selectedKey,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final item = items[i];
          final selected = item.key == selectedKey;
          return GestureDetector(
            onTap: () => onSelected(item.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? AppColors.primary : Colors.black12,
                ),
              ),
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    Icon(item.icon,
                        size: 16,
                        color: selected ? Colors.white : AppColors.primary),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    item.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}