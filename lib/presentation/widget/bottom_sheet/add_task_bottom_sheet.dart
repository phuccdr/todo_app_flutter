import 'package:flutter/material.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/widget/textfield/text_input.dart';

void showFormAddTaskBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          color: AppColors.bottomAppBar,
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: 16,
          ),
          child: Column(
            children: [
              const Text('Add Task', style: AppTextStyle.titleMediumBold),
              const SizedBox(height: 14),
              TextInput(hint: "Add task's name"),
              const SizedBox(height: 12),
              TextInput(hint: 'Description'),
            ],
          ),
        ),
      );
    },
  );
}
