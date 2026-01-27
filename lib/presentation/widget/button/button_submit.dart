import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';

class ButtonSubmit extends StatelessWidget {
  final String text;
  final VoidCallback? onSubmit;
  final Color activeBackgroundColor;
  final Color disabledBackgroundColor;
  final Color textActiveColor;
  final Color textDisabledColor;
  final double paddingVertical;

  const ButtonSubmit({
    super.key,
    this.text = 'Submit',
    this.onSubmit,
    this.activeBackgroundColor = AppColors.button,
    this.disabledBackgroundColor = AppColors.buttonDisabled,
    this.textActiveColor = AppColors.textPrimary,
    this.textDisabledColor = AppColors.textButtonDisabled,
    this.paddingVertical = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSubmit?.call,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: onSubmit != null
              ? activeBackgroundColor
              : disabledBackgroundColor,
        ),
        child: Text(
          text,
          style: AppTextStyle.body.copyWith(
            color: onSubmit != null ? textActiveColor : textDisabledColor,
          ),
        ),
      ),
    );
  }
}
