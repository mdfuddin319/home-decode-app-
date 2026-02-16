import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/SuggestedSection.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/luxurysuggestion.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../controller/sofa_controller.dart';
import 'widget/modernSuggestion.dart';

class SofaView extends StatelessWidget {
  const SofaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SofaController controller = Get.find<SofaController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        title: Text(
          'Sofas',
          style: TextStyles.headlineSmall.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColorPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textColorPrimary),
            onPressed: () => Get.toNamed('/search'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            _buildHeader(controller),

            // Filter Chips
            _buildFilterChips(controller),

            const SizedBox(height: 10),
            // Featured Products
            // ⭐ Banner Slider
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: controller.featurePageController,
                itemCount: controller.featureBanners.length,
                onPageChanged: (index) {
                  controller.currentFeatureIndex.value = index;
                },
                itemBuilder: (context, index) {
                  final banner = controller.featureBanners[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(banner["image"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              banner["title"]!,
                              style: TextStyles.titleLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              banner["desc"]!,
                              style: TextStyles.bodySmall.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            const SuggestedSection(),
            const SizedBox(height: 20),

            const ModernSuggestedSection(),
            const SizedBox(height: 20),

            const LuxurySuggestedSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(SofaController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover Our Sofas',
                    style: TextStyles.titleLarge.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      '${controller.totalSofas} products available',
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              // Sort Button
              PopupMenuButton<String>(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                icon: const Icon(Icons.sort, color: AppColors.primaryColor),
                onSelected: (value) => controller.applySort(value),
                itemBuilder: (context) {
                  final sortBy = controller.sortBy.value;
                  return [
                    PopupMenuItem(
                      value: 'popular',
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 18,
                            color: sortBy == 'popular'
                                ? AppColors.primaryColor
                                : AppColors.textColorSecondary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Popular'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'price-low',
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            size: 18,
                            color: sortBy == 'price-low'
                                ? AppColors.primaryColor
                                : AppColors.textColorSecondary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Price: Low to High'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'price-high',
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: sortBy == 'price-high'
                                ? AppColors.primaryColor
                                : AppColors.textColorSecondary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Price: High to Low'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'rating',
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 18,
                            color: sortBy == 'rating'
                                ? AppColors.primaryColor
                                : AppColors.textColorSecondary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Highest Rated'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'newest',
                      child: Row(
                        children: [
                          Icon(
                            Icons.new_releases,
                            size: 18,
                            color: sortBy == 'newest'
                                ? AppColors.primaryColor
                                : AppColors.textColorSecondary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Newest'),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(SofaController controller) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.filterOptions.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.selectedFilter.value == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(
                  controller.filterOptions[index],
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : AppColors.textColorPrimary,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                selectedColor: AppColors.primaryColor,
                backgroundColor: AppColors.surfaceColor,
                checkmarkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.greyColor.withOpacity(0.3),
                  ),
                ),
                onSelected: (selected) {
                  controller.applyFilter(index);
                },
              ),
            );
          });
        },
      ),
    );
  }
}
