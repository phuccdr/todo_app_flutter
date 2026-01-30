import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_cubit.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_state.dart';
import 'package:todoapp/presentation/widget/choose_category/choose_category_dialog.dart';
import 'package:todoapp/presentation/widget/priority/priority_picker_dialog.dart';
import 'package:todoapp/presentation/widget/textfield/text_input.dart';
import 'package:todoapp/presentation/widget/time_picker/task_time_picker.dart';

class AddTaskBottomSheet extends StatelessWidget {
  const AddTaskBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      builder: (BuildContext context, AddTaskState state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: 16 + bottomInset,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Add Task', style: AppTextStyle.titleMediumBold),
                const SizedBox(height: 14),
                TextInput(
                  hint: "Add task's name",
                  onChanged: (value) {
                    context.read<AddTaskCubit>().onTitleChanged(value);
                  },
                  isValid: state.titleValidator.isValid,
                ),
                const SizedBox(height: 12),
                TextInput(
                  hint: 'Description',
                  onChanged: (value) {
                    context.read<AddTaskCubit>().onDescriptionChanged(value);
                  },
                  isValid: state.descriptionValidator.isValid,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final selectedTime = await TaskTimePicker.show(
                          context,
                          initialDate: state.timeTaskValidator.value,
                        );
                        if (selectedTime != null && context.mounted) {
                          context.read<AddTaskCubit>().onTimeTaskChanged(
                            selectedTime,
                          );
                        }
                      },
                      icon: SvgPicture.asset(
                        'assets/images/ic_clock.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      onPressed: () async {
                        final selectedCateogry =
                            await ChooseCategoryDialog.show(
                              context,
                              initialCategory: state.categoryValidator.value,
                            );
                        if (selectedCateogry != null && context.mounted) {
                          context.read<AddTaskCubit>().onCategoryChanged(
                            selectedCateogry,
                          );
                        }
                      },
                      icon: SvgPicture.asset(
                        'assets/images/ic_category.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      onPressed: () async {
                        final selectPriority = await PriorityPickerDialog.show(
                          context,
                          initialPriority: state.priorityValidator.value,
                        );
                        if (selectPriority != null && context.mounted) {
                          context.read<AddTaskCubit>().onPriorityChanged(
                            selectPriority,
                          );
                        }
                      },
                      icon: SvgPicture.asset(
                        'assets/images/ic_priority.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),

                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        context.read<AddTaskCubit>().onSubmit();
                      },
                      icon: SvgPicture.asset(
                        'assets/images/ic_send.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          state.isValid
                              ? AppColors.primary
                              : AppColors.textDisabled,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, AddTaskState state) {
        if (state.status == FormzSubmissionStatus.success) {
          context.pop();
        } else if (state.status == FormzSubmissionStatus.inProgress) {
        } else if (state.status == FormzSubmissionStatus.failure) {
          print("insertTask: failure");
        }
      },
    );
  }
}
