import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swap_ui/core/constants/app_images.dart';
import 'package:swap_ui/core/extensions/size_helper.dart';
import 'package:swap_ui/core/utils/colors.dart';
import 'package:swap_ui/core/utils/text_styles.dart';
import 'package:swap_ui/features/home/data/models/product_model.dart';

class ProductPublisher extends StatelessWidget {
  const ProductPublisher({
    super.key,
    this.onTap,
    required this.publisher,
  });

  final PublisherModel publisher;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PublisherAvatar(
            image: publisher.image ?? AppImages.user,
          ),
          8.w,
          _buildNameWithLocation(),
        ],
      ),
    );
  }

  Expanded _buildNameWithLocation() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(publisher.name ?? 'Unknown', style: TextStyles.title()),
          2.h,
          Row(
            children: [
              SvgPicture.asset(
                AppImages.ratingSvg,
              ),
              4.w,
              Text(
                '${publisher.rating ?? 0}',
                style: TextStyles.small(),
              ),
              const Text(
                ' · ',
              ),
              Expanded(
                child: Text(
                  '${publisher.location ?? 'Unknown'} (${publisher.distanceKm?.toStringAsFixed(0) ?? 0} km from you)',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyles.small(
                    color: AppColors.neural4Color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PublisherAvatar extends StatelessWidget {
  const PublisherAvatar({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    const ringColor = AppColors.primaryColor;
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const SizedBox(
            width: 44,
            height: 44,
            child: ClipOval(
              child: CircularProgressIndicator(
                value: .75,
                color: AppColors.primaryColor,
                strokeWidth: 4.0,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(2.5),
              child: ClipOval(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: ringColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '75%',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
