import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_text_style.dart';

class BottomNavigationItem extends StatelessWidget {
  final VoidCallback? onPresses;
  final String label;
  final Widget icon;
  final int index;
  final int? currentIndex;
  const BottomNavigationItem({
    super.key,
    required this.label,
    required this.icon,
    this.onPresses,
    required this.index,
    this.currentIndex,
  });

  bool isSelected() {
    return index == currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPresses?.call,
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8),
          Text(label, style: AppTextStyle.bodySmall),
        ],
      ),
    );
  }
}
