import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swap_ui/core/constants/app_images.dart';
import 'package:swap_ui/core/extensions/size_helper.dart';
import 'package:swap_ui/core/utils/colors.dart';
import 'package:swap_ui/core/utils/text_styles.dart';
import 'package:swap_ui/features/home/presentation/widgets/header/notification_counter.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      height: 70,
      color: AppColors.backgroundColor,
      child: Row(
        children: [
          4.w,
          Expanded(
            child: Row(
              children: [
                _buildTap(
                    text: 'For you',
                    isActive: _selectedIndex == 0,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                5.w,
                _buildTap(
                    text: 'Following',
                    isActive: _selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }),
              ],
            ),
          ),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildTap({
    required String text,
    required bool isActive,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: isActive ? Border.all(color: AppColors.primaryColor) : null,
        ),
        child: Text(
          text,
          style: TextStyles.title(
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
              color: isActive ? AppColors.blackColor : AppColors.neural4Color),
        ),
      ),
    );
  }

  Row _buildActions() {
    return Row(
      children: [
        SvgPicture.asset(AppImages.replySvg),
        26.w,
        SvgPicture.asset(AppImages.filterSvg),
        18.w,
        SizedBox(
          width: 36,
          height: 56,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: GestureDetector(
                    child: SvgPicture.asset(AppImages.notificationSvg)),
              ),
              const PositionedDirectional(
                top: 42,
                end: 0,
                start: 0,
                child: NotificationCounter(
                  count: 4,
                ),
              ),
              const Positioned(
                right: 0,
                top: 12,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
