import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/core/di/injection.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_cubit.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_state.dart';

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
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.close, color: AppColors.white),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {},
                child: SvgPicture.asset('assets/images/ic_sync.svg'),
              ),
            ],
          ),
          body: _buildBody(context,state);
        );
      },
    );
  }
  
  Widget _buildBody(BuildContext context, AddTaskState state) {
    return SafeArea(child: Column(
      children:[
        Stack(
          children: [
            
          ],
        )
      ]
    ));
  }
}
