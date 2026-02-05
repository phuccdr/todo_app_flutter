import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/core/utils/network_image_util.dart';
import 'package:todoapp/core/utils/string_to_color.dart';
import 'package:todoapp/domain/entities/category.dart';
import 'package:todoapp/domain/entities/priority.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_cubit.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_state.dart';
import 'package:todoapp/presentation/model/task_display.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: _buildContent(context, state),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, TaskListState state) {
    return Stack(
      children: [
        _buildMainView(context, state),
        if (state.status == TaskListStatus.loading ||
            state.status == TaskListStatus.syncing)
          const Center(child: CircularProgressIndicator()),
        if (state.status == TaskListStatus.initial ||
            (state.status == TaskListStatus.success && state.tasks.isEmpty))
          _buildPlaceholder(),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/imv_place_holder.png'),
        const SizedBox(height: 12),
        Text('What do you want to do today?', style: AppTextStyle.titleMedium),
        const SizedBox(height: 12),
        Text('Tap + to add your tasks', style: AppTextStyle.body),
      ],
    );
  }

  Widget _buildMainView(BuildContext context, TaskListState state) {
    final cubit = context.read<TaskListCubit>();
    final tasksToShowToday = state.filteredTasks.where((task) {
      // test: return task.task.taskTime?.isToday(DateTime.now()) ?? false;
      return true;
    }).toList();
    final tasksToShowCompleted = state.filteredTasks.where((task) {
      return task.task.isCompleted;
    }).toList();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => cubit.updateSearchQuery(value),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset('assets/images/ic_search.svg'),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColors.border, width: 0.8),
                ),
                contentPadding: const EdgeInsets.all(12),
                hint: Text('Search for your task...', style: AppTextStyle.hint),
              ),
              style: AppTextStyle.body,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Today', style: AppTextStyle.bodySmall),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasksToShowToday.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _TaskItem(
                  display: tasksToShowToday[index],
                  onToggle: () =>
                      cubit.toggleTaskStatus(tasksToShowToday[index].task.id),
                );
              },
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Completed', style: AppTextStyle.bodySmall),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasksToShowCompleted.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _TaskItem(
                  display: tasksToShowCompleted[index],
                  onToggle: () => cubit.toggleTaskStatus(
                    tasksToShowCompleted[index].task.id,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _formatTaskTime(DateTime? taskTime) {
    if (taskTime == null) return '';
    final now = DateTime.now();
    final isToday =
        now.year == taskTime.year &&
        now.month == taskTime.month &&
        now.day == taskTime.day;
    final timeStr =
        '${taskTime.hour.toString().padLeft(2, '0')}:${taskTime.minute.toString().padLeft(2, '0')}';
    return isToday ? 'Today At $timeStr' : timeStr;
  }
}

class _TaskItem extends StatelessWidget {
  static const double _horizontalPadding = 12;
  static const double _radioSize = 16;
  static const double _gapAfterRadio = 12;
  static const double _titleTop = 12;
  static const double _timeTop = 40;
  static const double _itemHeight = 72;

  final TaskDisplay display;
  final VoidCallback onToggle;

  const _TaskItem({required this.display, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final task = display.task;
    final category = display.category;
    final timeText = HomeTabView._formatTaskTime(task.taskTime);

    return GestureDetector(
      onTap: () {
        context.push('/detailTask/${task.id}');
      },
      child: Container(
        height: _itemHeight,
        decoration: BoxDecoration(
          color: AppColors.cardTask,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: _horizontalPadding,
              top: (_itemHeight - _radioSize) / 2,
              width: _radioSize,
              height: _radioSize,
              child: SizedBox(
                width: _radioSize,
                height: _radioSize,
                child: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => onToggle(),
                  shape: const CircleBorder(),
                  side: BorderSide(color: AppColors.border, width: 2),
                  activeColor: AppColors.primary,
                  checkColor: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: _horizontalPadding + _radioSize + _gapAfterRadio,
              top: _titleTop,
              child: Text(
                task.title,
                style: AppTextStyle.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              left: _horizontalPadding + _radioSize + _gapAfterRadio,
              top: _timeTop,
              bottom: 12,
              child: Text(
                timeText.isNotEmpty ? timeText : '',
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.textGray,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              right: _horizontalPadding,
              bottom: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (category != null) ...[
                    _CategoryChip(category: category),
                    const SizedBox(width: 12),
                  ],
                  _PriorityChip(priority: task.priority),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final Category category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = category.color.isNotEmpty
        ? category.color.toColor()
        : AppColors.textGray;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (category.icon.isNotEmpty)
            NetworkImageUtil.load(category.icon, width: 14, height: 14),
          const SizedBox(width: 5),
          Text(category.name, style: AppTextStyle.bodySmall),
        ],
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final Priority? priority;

  const _PriorityChip({this.priority});

  @override
  Widget build(BuildContext context) {
    final value = priority?.value ?? 1;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: BoxBorder.all(color: AppColors.primary, width: 1),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/ic_priority.svg',
            width: 14,
            height: 14,
          ),
          const SizedBox(width: 5),
          Text('$value', style: AppTextStyle.bodySmall),
        ],
      ),
    );
  }
}
