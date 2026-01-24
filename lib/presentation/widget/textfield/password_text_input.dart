import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';

class PasswordTextInput extends StatelessWidget {
  final Color validColor;
  final Color invalidColor;
  final String hint;
  final Function(String value)? onChanged;
  final String title;
  final bool isValid;

  const PasswordTextInput({
    super.key,
    this.validColor = AppColors.textPrimary,
    this.invalidColor = AppColors.textDisabled,
    this.hint = '●●●●●●●●',
    this.onChanged,
    this.title = '',
    this.isValid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...{Text(title, style: AppTextStyle.titleMedium)},
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          obscuringCharacter: '●',
          obscureText: true,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.all(12),
          ),
          style: AppTextStyle.body.copyWith(
            color: isValid ? AppColors.textPrimary : AppColors.textDisabled,
          ),
        ),
      ],
    );
  }
}
