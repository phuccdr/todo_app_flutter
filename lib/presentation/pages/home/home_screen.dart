import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/di/injection.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/core/utils/network_image_util.dart';
import 'package:todoapp/presentation/cubit/auth/auth_cubit.dart';
import 'package:todoapp/presentation/cubit/auth/auth_state.dart';
import 'package:todoapp/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:todoapp/presentation/cubit/task/add_task/add_task_cubit.dart';
import 'package:todoapp/presentation/cubit/task/task_list/task_list_cubit.dart';
import 'package:todoapp/presentation/pages/home/bottom_nav_bar/home_bottom_nav_bar.dart';
import 'package:todoapp/presentation/pages/home/bottom_sheet/add_task_bottom_sheet.dart';
import 'package:todoapp/presentation/pages/home/calendar/calendar_tab_view.dart';
import 'package:todoapp/presentation/pages/home/focus/focus_tab_view.dart';
import 'package:todoapp/presentation/pages/home/home_tab/home_tab_view.dart';
import 'package:todoapp/presentation/pages/home/profile/profile_tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => getIt<TaskListCubit>()..init()),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return IndexedStack(
            index: state,
            children: const [
              HomeTabView(),
              CalendarTabView(),
              FocusTabView(),
              ProfileTabView(),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskBottomSheet(context);
        },
        backgroundColor: AppColors.primary,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 32, color: AppColors.white),
      ),
      bottomNavigationBar: HomeBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
        ),
      ),
      title: BlocBuilder<NavigationCubit, int>(
        builder: (context, index) {
          return Text(_getTitle(index), style: AppTextStyle.titleMedium);
        },
      ),
      centerTitle: true,
      actions: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ClipOval(
                child: NetworkImageUtil.load(
                  state.user?.avatar ?? '',
                  width: 42,
                  height: 42,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Calendar';
      case 2:
        return 'Focus';
      case 3:
        return 'Profile';
      default:
        return 'Todo App';
    }
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bottomAppBar,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return BlocProvider(
          create: (_) => getIt<AddTaskCubit>(),
          child: SafeArea(child: const AddTaskBottomSheet()),
        );
      },
    );
  }
}
