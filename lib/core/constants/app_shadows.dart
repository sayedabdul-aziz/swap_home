import 'package:flutter/material.dart';
import 'package:swap_ui/core/utils/colors.dart';

class AppShadows {
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.blackColor.withValues(alpha: .08),
      offset: const Offset(0, 6),
      blurRadius: 8,
    ),
  ];
}
