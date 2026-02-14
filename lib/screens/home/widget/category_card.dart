import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.categoryName,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Image Container
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 10),
          // Category Name Below
          Text(
            categoryName,
            style: TextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
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
