import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class VegetableCard extends StatelessWidget {
  final String productName;
  final String imagePath;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const VegetableCard({
    Key? key,
    required this.productName,
    required this.imagePath,
    required this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Card with pastel background
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Product name below - bold and centered
          Text(
            productName,
            style: TextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textColorPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
