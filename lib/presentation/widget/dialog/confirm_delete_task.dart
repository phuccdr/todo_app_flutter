import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';

class ConfirmDeleteTaskDialog extends StatelessWidget {
  final String taskTitle;

  const ConfirmDeleteTaskDialog({super.key, required this.taskTitle});

  static Future<bool?> show(BuildContext context, {required String taskTitle}) {
    return showDialog<bool?>(
      context: context,
      builder: (context) => ConfirmDeleteTaskDialog(taskTitle: taskTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bottomAppBar,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Task',
              style: AppTextStyle.titleSmallBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(height: 1, color: AppColors.divier),
            const SizedBox(height: 24),
            Text(
              'Are You sure you want to delete this task?',
              style: AppTextStyle.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Task title : $taskTitle',
              style: AppTextStyle.body.copyWith(color: AppColors.textGray),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonSubmit(
            text: 'Cancel',
            textActiveColor: AppColors.primary,
            activeBackgroundColor: AppColors.transparent,
            onSubmit: () {
              context.pop(false);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ButtonSubmit(
            onSubmit: () {
              context.pop(true);
            },
            text: 'Delete',
            textActiveColor: AppColors.textPrimary,
            activeBackgroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
