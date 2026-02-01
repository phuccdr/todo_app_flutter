import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/di/injection.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/core/utils/date_time_formatter.dart';
import 'package:todoapp/core/utils/network_image_util.dart';
import 'package:todoapp/core/utils/string_to_color.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_cubit.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_state.dart';
import 'package:todoapp/presentation/model/task_display.dart';
import 'package:todoapp/presentation/widget/button/button_submit.dart';
import 'package:todoapp/presentation/widget/choose_category/choose_category_dialog.dart';
import 'package:todoapp/presentation/widget/confirm_delete_task.dart';
import 'package:todoapp/presentation/widget/edit_task_title_dialog.dart';
import 'package:todoapp/presentation/widget/priority/priority_picker_dialog.dart';
import 'package:todoapp/presentation/widget/time_picker/task_time_picker.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;
  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddTaskCubit>()..getTaskById(taskId),
      child: const _TaskDetailView(),
    );
  }
}

class _TaskDetailView extends StatelessWidget {
  const _TaskDetailView();
  @override
  Widget build(Object context) {
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.close, color: AppColors.white),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/images/ic_sync.svg'),
                    ),
                  ],
                ),
              ),
            ),
            body: _buildBody(context, state),
          ),
        );
      },
      listener: (BuildContext context, AddTaskState state) {
        if (state.status == FormzSubmissionStatus.success) {
          context.pop();
        } else if (state.status == FormzSubmissionStatus.inProgress) {}
      },
    );
  }

  Widget _buildBody(BuildContext context, AddTaskState state) {
    final TaskDisplay? taskDisplay = state.initialTask;
    final task = taskDisplay?.task;
    final category = taskDisplay?.category;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 28),
            Row(
              children: [
                RadioGroup<bool>(
                  onChanged: (bool? value) {},
                  child: Radio<bool>(
                    value: true,
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return AppColors.border;
                    }),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    task?.title ?? "",
                    style: AppTextStyle.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(width: 20),
                IconButton(
                  onPressed: () async {
                    final result = await EditTaskTitleDialog.show(
                      context,
                      initialTitle: state.initialTask?.task.title ?? '',
                      initialDescription:
                          state.initialTask?.task.description ?? '',
                    );

                    if (result != null && context.mounted) {
                      final title = result.title;
                      final description = result.description;
                      context.read<AddTaskCubit>().onUpdateTileTask(
                        title,
                        description,
                      );
                    }
                  },
                  icon: SvgPicture.asset(
                    'assets/images/ic_pencil.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 60),
                Text(
                  task?.description ?? '',
                  style: AppTextStyle.titleSmall.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ic_clock.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text('Task Time:', style: AppTextStyle.body),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final selectedTime = await TaskTimePicker.show(
                      context,
                      initialDate: state.initialTask?.task.taskTime,
                    );
                    if (selectedTime != null && context.mounted) {
                      context.read<AddTaskCubit>().onUpdateTimeTask(
                        selectedTime,
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.cardSecond,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      (task != null && task.taskTime != null)
                          ? task.taskTime!.convertToTextDisplay
                          : '',
                      style: AppTextStyle.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ic_category.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text('Task Category:', style: AppTextStyle.body),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final result = await ChooseCategoryDialog.show(
                      context,
                      initialCategory: state.initialTask?.category,
                      title: 'Edit Category',
                      textActionButton: 'Edit',
                    );

                    if (result != null && context.mounted) {
                      context.read<AddTaskCubit>().onUpdateCategoryTask(result);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.cardSecond,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        if (category != null) ...[
                          NetworkImageUtil.load(
                            category.icon,
                            width: 24,
                            height: 24,
                            color: category.color.toColor(),
                          ),
                          const SizedBox(width: 10),
                          Text(category.name, style: AppTextStyle.bodySmall),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Text('Task Priority:', style: AppTextStyle.body),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final result = await PriorityPickerDialog.show(
                      context,
                      initialPriority: state.initialTask?.task.priority,
                      title: 'Edit Task Priority',
                      textActionButton: 'Edit',
                    );

                    if (result != null && context.mounted) {
                      context.read<AddTaskCubit>().onUpdatePriorityTask(result);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.cardSecond,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      task?.priority?.value.toString() ?? '',
                      style: AppTextStyle.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 34),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ic_subtask.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text('Sub-Task', style: AppTextStyle.body),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.cardSecond,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text('AddSub-Task', style: AppTextStyle.bodySmall),
                ),
              ],
            ),
            const SizedBox(height: 34),
            GestureDetector(
              onTap: () async {
                final confirmed = await ConfirmDeleteTaskDialog.show(
                  context,
                  taskTitle: task?.title ?? '',
                );
                if (confirmed == true && context.mounted && task?.id != null) {
                  context.read<AddTaskCubit>().deleteTask(task!.id);
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_delete.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Delete Task',
                    style: AppTextStyle.body.copyWith(color: AppColors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 200),
            ButtonSubmit(
              text: 'Edit Task',
              onSubmit: () {
                context.read<AddTaskCubit>().onEditTask();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
