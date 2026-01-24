import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/core/theme/app_colors.dart';
import 'package:todoapp/core/theme/app_text_style.dart';
import 'package:todoapp/presentation/pages/home/bottom_navigaton_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // add not
        },
        backgroundColor: AppColors.button,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNaigationBar(),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 24),
        child: IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
      ),
      title: Text('Index', style: AppTextStyle.titleMedium),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ClipOval(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/ic_placeholder_avatar.png',
              image:
                  'https://assets.editorial.aetnd.com/uploads/2016/11/donald-trump-gettyimages-687193180.jpg',
              width: 42,
              height: 42,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildBody() {
    return null;
  }

  Widget? _buildBottomNaigationBar() {
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
          ),
          BottomNavigationItem(
            icon: SvgPicture.asset(
              'assets/images/ic_calendar.svg',
              width: 24,
              height: 24,
            ),
            label: 'Calendar',
          ),
          const SizedBox(width: 24),
          BottomNavigationItem(
            icon: SvgPicture.asset(
              'assets/images/ic_focus.svg',
              width: 24,
              height: 24,
            ),
            label: 'Focus',
          ),
          BottomNavigationItem(
            icon: SvgPicture.asset(
              'assets/images/ic_profile.svg',
              width: 24,
              height: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
