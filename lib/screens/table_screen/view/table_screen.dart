import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/models/product_model.dart';
import '../controller/table_controller.dart';

class TableView extends StatelessWidget {
  const TableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TableController controller = Get.find<TableController>();

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
      body: Column(
        children: [
          // Header Section
          _buildHeader(controller),

          // Filter Chips
          _buildFilterChips(controller),

          // Products Grid
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                    )
                  : controller.tableProducts.isEmpty
                  ? _buildEmptyState(controller)
                  : _buildProductGrid(controller),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(TableController controller) {
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
              Obx(
                () => PopupMenuButton<String>(
                  icon: const Icon(Icons.sort, color: AppColors.primaryColor),
                  onSelected: (value) => controller.applySort(value),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'popular',
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 18,
                            color: controller.sortBy.value == 'popular'
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
                            color: controller.sortBy.value == 'price-low'
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
                            color: controller.sortBy.value == 'price-high'
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
                            color: controller.sortBy.value == 'rating'
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
                            color: controller.sortBy.value == 'newest'
                                ? AppColors.primaryColor
                                : AppColors.textColorSecondary,
                          ),
                          const SizedBox(width: 8),
                          const Text('Newest'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(TableController controller) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.filterOptions.length,
          itemBuilder: (context, index) {
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
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(TableController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chair_alt_outlined,
            size: 80,
            color: AppColors.greyColor.withOpacity(0.6),
          ),
          const SizedBox(height: 24),
          Text(
            'No sofas found',
            style: TextStyles.headlineMedium.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Try adjusting your filters',
            style: TextStyles.bodyMedium.copyWith(
              color: AppColors.textColorHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(TableController controller) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshTables();
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: controller.tableProducts.length,
        itemBuilder: (context, index) {
          final product = controller.tableProducts[index];
          return _sofaProductCard(product);
        },
      ),
    );
  }

  Widget _sofaProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/product-details', arguments: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: product.image != null && product.image.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return _imageFallback();
                          },
                        ),
                      )
                    : _imageFallback(),
              ),
            ),
            // Product Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.warningColor,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: TextStyles.bodySmall,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.id})',
                          style: TextStyles.bodySmall.copyWith(
                            color: AppColors.textColorHint,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyles.titleMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageFallback() {
    return Center(
      child: Icon(
        Icons.chair_alt_rounded,
        size: 50,
        color: AppColors.greyColor.withOpacity(0.6),
      ),
    );
  }
}
