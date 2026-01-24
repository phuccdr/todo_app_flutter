import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';

class TwoTextSpan extends StatelessWidget {
  final String firstText;
  final TextStyle firstTextStyle;
  final String secondText;
  final TextStyle secondTextStyle;
  final VoidCallback? onFirstTextClick;
  final VoidCallback? onSecondTextClick;

  const TwoTextSpan({
    super.key,
    required this.firstText,
    this.firstTextStyle = AppTextStyle.smallBody,
    required this.secondText,
    this.secondTextStyle = AppTextStyle.smallBody,
    this.onFirstTextClick,
    this.onSecondTextClick,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: firstTextStyle.copyWith(color: AppColors.textDisabled),
          recognizer: onFirstTextClick != null
              ? (TapGestureRecognizer()..onTap = onFirstTextClick)
              : null,
          children: [
            TextSpan(
              text: secondText,
              style: secondTextStyle,
              recognizer: onSecondTextClick != null
                  ? (TapGestureRecognizer()..onTap = onSecondTextClick)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
