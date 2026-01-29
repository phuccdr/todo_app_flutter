import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/domain/entities/task.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_cubit.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_state.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListCubit, TaskListState>(
      builder: (context, state) {
        return SafeArea(child: _buildContent(state));
      },
    );
  }

  Widget _buildContent(TaskListState state) {
    if (state.status == TaskListStatus.loading ||
        state.status == TaskListStatus.syncing) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == TaskListStatus.success && state.tasks.isEmpty) {
      return _buildPlaceholder();
    }

    if (state.tasks.isNotEmpty) {
      return _buildMainView(state.tasks);
    }

    return _buildPlaceholder();
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

  Widget _buildMainView(List<Task> tasks) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: task.description != null ? Text(task.description!) : null,
        );
      },
    );
  }
}
