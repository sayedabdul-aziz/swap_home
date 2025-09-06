import 'package:flutter/material.dart';
import 'package:swap_ui/core/constants/app_shadows.dart';
import 'package:swap_ui/core/extensions/size_helper.dart';
import 'package:swap_ui/core/utils/colors.dart';
import 'package:swap_ui/core/utils/text_styles.dart';
import 'package:swap_ui/features/home/data/models/product_model.dart';
import 'package:swap_ui/features/home/presentation/widgets/content/product_publisher.dart';

class ProductListBuilder extends StatelessWidget {
  const ProductListBuilder({super.key, required this.model});

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildShadow(),
        PositionedDirectional(
            top: 0, bottom: 0, start: 0, end: 0, child: _buildProductCard()),
      ],
    );
  }

  Container _buildProductCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: AppShadows.cardShadow),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsetsDirectional.only(start: 8, end: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductPublisher(
            publisher: model.publisher,
          ),
          16.h,
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                model.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 52,
            padding: const EdgeInsets.all(12),
            child: Text(
              model.title,
              style: TextStyles.body(),
            ),
          ),
        ],
      ),
    );
  }

  PositionedDirectional _buildShadow() {
    return PositionedDirectional(
      top: 26,
      bottom: 26,
      end: 8,
      child: Container(
        width: 20,
        decoration: const BoxDecoration(
          color: AppColors.neural2Color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
      ),
    );
  }
}
