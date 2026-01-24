import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';

class UserNameTextInput extends StatelessWidget {
  final Color textColor;
  final Color textDisabledColor;
  final String hint;
  final Function(String value)? onChanged;
  final bool isValid;

  const UserNameTextInput({
    super.key,
    this.textColor = AppColors.textPrimary,
    this.textDisabledColor = AppColors.textDisabled,
    this.hint = 'Enter your Username',
    this.isValid = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Username', style: AppTextStyle.titleMedium),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          style: AppTextStyle.body.copyWith(
            color: isValid ? textColor : textDisabledColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
