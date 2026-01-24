import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';

class TextInput extends StatelessWidget {
  final Color textFocusColor;
  final Color textUnfocusColor;
  final String hint;
  final Function(String value)? onChanged;
  final bool isValid;
  final String errorText;

  const TextInput({
    super.key,
    this.textFocusColor = AppColors.textPrimary,
    this.textUnfocusColor = AppColors.textDisabled,
    this.hint = 'Enter your Username',
    this.isValid = false,
    this.onChanged,
    this.errorText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: onChanged,
          style: AppTextStyle.bodyMedium.copyWith(
            color: isValid ? textFocusColor : textUnfocusColor,
          ),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.border, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
        ),
        if (isValid && errorText.isNotEmpty) ...{
          Text(
            errorText,
            style: AppTextStyle.smallBody.copyWith(color: AppColors.error),
          ),
        },
      ],
    );
  }
}
