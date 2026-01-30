import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/presentation/cubit/navigation/navigation_cubit.dart';
import 'package:todoapp/presentation/pages/home/bottom_nav_bar/bottom_navigaton_item.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return BlocBuilder<NavigationCubit, int>(
          builder: (context, int state) {
            return BottomAppBar(
              color: AppColors.bottomAppBar,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavigationItem(
                    icon: SvgPicture.asset(
                      'assets/images/ic_home.svg',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Home',
                    index: 0,
                    onPresses: () {
                      context.read<NavigationCubit>().setIndex(0);
                    },
                  ),
                  BottomNavigationItem(
                    icon: SvgPicture.asset(
                      'assets/images/ic_calendar.svg',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Calendar',
                    index: 1,
                    onPresses: () {
                      context.read<NavigationCubit>().setIndex(1);
                    },
                  ),
                  const SizedBox(width: 24),
                  BottomNavigationItem(
                    icon: SvgPicture.asset(
                      'assets/images/ic_focus.svg',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Focus',
                    index: 2,
                    onPresses: () {
                      context.read<NavigationCubit>().setIndex(2);
                    },
                  ),
                  BottomNavigationItem(
                    icon: SvgPicture.asset(
                      'assets/images/ic_profile.svg',
                      width: 24,
                      height: 24,
                    ),
                    label: 'Profile',
                    index: 3,
                    onPresses: () {
                      context.read<NavigationCubit>().setIndex(3);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
