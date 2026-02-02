import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/domain/entities/priority.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';

class PriorityPickerDialog extends StatefulWidget {
  final Priority? initialPriority;
  const PriorityPickerDialog({
    super.key,
    this.initialPriority = Priority.one,
    this.title,
    this.textActionButton,
  });
  final String? title;
  final String? textActionButton;

  static Future<Priority?> show(
    BuildContext context, {
    Priority? initialPriority,
    String? title,
    String? textActionButton,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return PriorityPickerDialog(
          initialPriority: initialPriority,
          title: title,
          textActionButton: textActionButton,
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _PriorityPickerDialogState();
  }
}

class _PriorityPickerDialogState extends State<PriorityPickerDialog> {
  late Priority _selectPriority;

  @override
  void initState() {
    super.initState();
    _selectPriority = widget.initialPriority ?? Priority.one;
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
          children: [
            Text(
              widget.title ?? 'Task Priority',
              style: AppTextStyle.titleMediumBold,
            ),
            Container(height: 1, color: AppColors.divier),
            const SizedBox(height: 8),
            _buildPriorityPicker(),
            const SizedBox(height: 16),
            _buildPriorityPickerAction(widget.textActionButton),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityPicker() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: Priority.values.length,
      itemBuilder: (context, index) {
        final priority = Priority.values[index];
        final isSelected = _selectPriority == priority;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectPriority = priority;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? AppColors.primary : AppColors.card,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_priority.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(height: 4),
                  Text('${priority.value}', style: AppTextStyle.body),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPriorityPickerAction(String? textActionButton) {
    return Row(
      children: [
        Expanded(
          child: ButtonSubmit(
            text: 'Cancel',
            textActiveColor: AppColors.primary,
            activeBackgroundColor: AppColors.transparent,
            onSubmit: () {
              context.pop();
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ButtonSubmit(
            onSubmit: () {
              context.pop(_selectPriority);
            },
            text: textActionButton ?? 'Save',
            textActiveColor: AppColors.textPrimary,
            activeBackgroundColor: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
