import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swap_ui/core/constants/app_images.dart';
import 'package:swap_ui/core/extensions/size_helper.dart';
import 'package:swap_ui/core/utils/colors.dart';
import 'package:swap_ui/features/home/presentation/page/home_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const HomeScreen(),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  _buildBottomNavBar() {
    return Positioned(
      bottom: 5,
      child: Container(
        height: 68,
        width: 260,
        padding: 4.all,
        decoration: BoxDecoration(
          color: AppColors.blackColor.withValues(alpha: .8),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            _buildNavItem(
                icon: AppImages.homeSvg,
                onTap: () => _onTapped(0),
                isActive: _currentIndex == 0),
            _buildNavItem(
              icon: AppImages.addSvg,
              onTap: () => _onTapped(1),
              isActive: _currentIndex == 1,
            ),
            _buildNavItem(
              icon: AppImages.chatSvg,
              onTap: () => _onTapped(2),
              isActive: _currentIndex == 2,
            ),
            _buildNavItem(
              icon: AppImages.profileSvg,
              onTap: () => _onTapped(3),
              isActive: _currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  CircleAvatar _buildNavItem(
      {required String icon, Function()? onTap, bool isActive = false}) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: isActive ? AppColors.blackColor : Colors.transparent,
      child: IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset(
            icon,
            colorFilter: isActive
                ? const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn)
                : const ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
          )),
    );
  }
}
