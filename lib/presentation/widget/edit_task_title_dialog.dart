import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';
import 'package:todoapp/presentation/widget/textfield/text_input.dart';

class EditTaskTitleDialog extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;

  const EditTaskTitleDialog({
    super.key,
    this.initialTitle = '',
    this.initialDescription = '',
  });
  static Future<({String title, String description})?> show(
    BuildContext context, {
    String initialTitle = '',
    String initialDescription = '',
  }) {
    return showDialog<({String title, String description})>(
      context: context,
      builder: (BuildContext context) {
        return EditTaskTitleDialog(
          initialTitle: initialTitle,
          initialDescription: initialDescription,
        );
      },
    );
  }

  @override
  State<EditTaskTitleDialog> createState() => _EditTaskTitleDialogState();
}

class _EditTaskTitleDialogState extends State<EditTaskTitleDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController = TextEditingController(
      text: widget.initialDescription,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bottomAppBar,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Edit Task title',
              style: AppTextStyle.titleMediumBold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Container(height: 1, color: AppColors.divier),
            const SizedBox(height: 16),
            TextInput(controller: _titleController, isValid: true),
            const SizedBox(height: 12),
            TextInput(controller: _descriptionController, isValid: true),
            const SizedBox(height: 16),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: ButtonSubmit(
            text: 'Cancel',
            textActiveColor: AppColors.primary,
            activeBackgroundColor: AppColors.transparent,
            onSubmit: () => context.pop(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ButtonSubmit(
            text: 'Edit',
            textActiveColor: AppColors.textPrimary,
            activeBackgroundColor: AppColors.primary,
            onSubmit:
                _titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty
                ? () {
                    context.pop((
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                    ));
                  }
                : null,
          ),
        ),
      ],
    );
  }
}
