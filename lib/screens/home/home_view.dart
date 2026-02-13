import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'home_controller.dart';
import 'widget/feature_product.dart';
import 'widget/category_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        title: Text(
          AppStrings.appName,
          style: TextStyles.headlineSmall.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(
                  Icons.shopping_cart,
                  color: AppColors.textColorPrimary,
                ),
                Obx(
                  () => Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.errorColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${controller.cartItemCount.value}',
                        style: const TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () => Get.toNamed('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: AppColors.textColorPrimary),
            onPressed: () => Get.toNamed('/profile'),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppStrings.loading,
                      style: TextStyle(color: AppColors.textColorSecondary),
                    ),
                  ],
                ),
              )
            : SafeArea(
                top: false,
                bottom: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search Bar
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.greyColor.withOpacity(0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.greyColor.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '${AppStrings.search} furniture...',
                              hintStyle: TextStyle(
                                color: AppColors.textColorHint,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: AppColors.primaryColor,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.tune,
                                  color: AppColors.textColorHint,
                                ),
                                onPressed: () {
                                  // Add filter functionality
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.backgroundColor,
                            ),
                            onChanged: (value) {
                              // Add search functionality
                              controller.performSearch(value);
                            },
                            onSubmitted: (value) {
                              // Handle search submission
                              controller.performSearch(value);
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Categories
                        Text(
                          AppStrings.categories,
                          style: TextStyles.titleLarge,
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 60,
                          child: Obx(
                            () => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.categories.length,
                              itemBuilder: (context, index) {
                                bool isSelected =
                                    controller.selectedIndex.value == index;
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectCategory(index);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : AppColors.backgroundColor,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.greyColor.withOpacity(
                                                0.3,
                                              ),
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.2),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: AppColors.greyColor
                                                    .withOpacity(0.1),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getCategoryIcon(
                                              controller.categories[index],
                                            ),
                                            color: isSelected
                                                ? AppColors.whiteColor
                                                : AppColors.primaryColor,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            controller.categories[index],
                                            style: TextStyle(
                                              color: isSelected
                                                  ? AppColors.whiteColor
                                                  : AppColors.textColorPrimary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
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
                        ),

                        const SizedBox(height: 24),

                        // Featured Products
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Featured Products',
                              style: TextStyles.titleLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to products screen
                                Get.toNamed('/product');
                              },
                              child: const Text('See All'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        SizedBox(
                          height: 120,
                          child: Obx(
                            () => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.featuredProducts.length,
                              itemBuilder: (context, index) {
                                final product =
                                    controller.featuredProducts[index];

                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      '/product-details',
                                      arguments: product,
                                    );
                                  },
                                  child: Container(
                                    width: 180,
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceColor,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.greyColor
                                              .withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// IMAGE SECTION
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                          child: Container(
                                            height: 150,
                                            width: double.infinity,
                                            color: AppColors.backgroundColor,
                                            child: product.image.isNotEmpty
                                                ? Image.asset(
                                                    product.image,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          debugPrint(
                                                            "Image not found → ${product.image}",
                                                          );
                                                          return _imageFallback();
                                                        },
                                                  )
                                                : _imageFallback(),
                                          ),
                                        ),

                                        /// DETAILS SECTION
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: TextStyles.titleMedium,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 6),

                                              Text(
                                                '\$${(product.price).toStringAsFixed(2)}',
                                                style: TextStyles.titleMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              const SizedBox(height: 6),

                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color:
                                                        AppColors.warningColor,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    (product.rating).toString(),
                                                    style: TextStyles.bodySmall,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '(24)',
                                                    style: TextStyles.bodySmall
                                                        .copyWith(
                                                          color: AppColors
                                                              .textColorHint,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),

                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  product.category,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Popular Products
                        Text('Popular Products', style: TextStyles.titleLarge),

                        const SizedBox(height: 12),

                        // Use a different approach for the grid without IntrinsicHeight
                        Obx(
                          () => Container(
                            constraints: const BoxConstraints(
                              minHeight: 200, // Minimum height for the grid
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 0.75,
                                  ),
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                var product = controller.products[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      '/product-details',
                                      arguments: product,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceColor,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.greyColor
                                              .withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                          child: Container(
                                            height: 120,
                                            width: double.infinity,
                                            color: AppColors.backgroundColor,
                                            child: product.image.isNotEmpty
                                                ? Image.network(
                                                    product.image,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    height: 120,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Icon(
                                                            Icons.chair,
                                                            size: 40,
                                                            color: AppColors
                                                                .greyColor
                                                                .withOpacity(
                                                                  0.6,
                                                                ),
                                                          );
                                                        },
                                                    loadingBuilder:
                                                        (
                                                          context,
                                                          child,
                                                          loadingProgress,
                                                        ) {
                                                          if (loadingProgress ==
                                                              null)
                                                            return child;
                                                          return Center(
                                                            child: CircularProgressIndicator(
                                                              value:
                                                                  loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes!
                                                                  : null,
                                                              strokeWidth: 2,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                    Color
                                                                  >(
                                                                    AppColors
                                                                        .primaryColor,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                  )
                                                : Icon(
                                                    Icons.chair,
                                                    size: 40,
                                                    color: AppColors.greyColor
                                                        .withOpacity(0.6),
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: TextStyles.bodyMedium,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                '\$${product.price.toStringAsFixed(2)}',
                                                style: TextStyles.bodyMedium
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color:
                                                        AppColors.warningColor,
                                                    size: 14,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    product.rating.toString(),
                                                    style: TextStyles.bodySmall,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '(12)',
                                                    style: TextStyles.bodySmall
                                                        .copyWith(
                                                          color: AppColors
                                                              .textColorHint,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  product.category,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Product Auto Slider (below Popular Products)
                        ProductAutoSlider(
                          products: controller.featuredProducts,
                        ),

                        const SizedBox(height: 24),

                        // Category Grid Section
                        Text('Sofa Category', style: TextStyles.titleLarge),

                        const SizedBox(height: 14),

                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 7,
                          childAspectRatio: 0.665,
                          children: [
                            CategoryCard(
                              categoryName: 'Sofa',
                              imagePath: 'assets/images/sofaone.jpg',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Bed',
                              imagePath: 'assets/images/sofatwo.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Table',
                              imagePath: 'assets/images/sofathree.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Chair',
                              imagePath: 'assets/images/sofafour.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Cabinet',
                              imagePath: 'assets/images/sofafive.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Shelf',
                              imagePath: 'assets/images/sofasix.png',
                              onTap: () {
                                // Handle shelf category tap
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Vegetables & Fruits Category Section
                        Text('Lighting', style: TextStyles.titleLarge),

                        const SizedBox(height: 15),

                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 7,
                          childAspectRatio: 0.665,
                          children: [
                            CategoryCard(
                              categoryName: ' Chandeliers',
                              imagePath: 'assets/images/light1.png',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Light Room',
                              imagePath: 'assets/images/sofatwo.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Ceiling lights',
                              imagePath: 'assets/images/light3.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Pot lights',
                              imagePath: 'assets/images/light4.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Desk lamps',
                              imagePath: 'assets/images/light5.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'LED strip',
                              imagePath: 'assets/images/light6.png',
                              onTap: () {
                                // Handle shelf category tap
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Beds Category Section
                        Text('Beds', style: TextStyles.titleLarge),

                        const SizedBox(height: 15),

                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 7,
                          childAspectRatio: 0.665,
                          children: [
                            CategoryCard(
                              categoryName: 'Sofa',
                              imagePath: 'assets/images/sofaone.jpg',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Bed',
                              imagePath: 'assets/images/sofatwo.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Table',
                              imagePath: 'assets/images/sofathree.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Chair',
                              imagePath: 'assets/images/sofafour.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Cabinet',
                              imagePath: 'assets/images/sofafive.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Shelf',
                              imagePath: 'assets/images/sofasix.png',
                              onTap: () {
                                // Handle shelf category tap
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Tables Category Section
                        Text('Tables', style: TextStyles.titleLarge),

                        const SizedBox(height: 15),

                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 7,
                          childAspectRatio: 0.665,
                          children: [
                            CategoryCard(
                              categoryName: 'Sofa',
                              imagePath: 'assets/images/sofaone.jpg',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Bed',
                              imagePath: 'assets/images/sofatwo.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Table',
                              imagePath: 'assets/images/sofathree.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Chair',
                              imagePath: 'assets/images/sofafour.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Cabinet',
                              imagePath: 'assets/images/sofafive.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Shelf',
                              imagePath: 'assets/images/sofasix.png',
                              onTap: () {
                                // Handle shelf category tap
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Chairs Category Section
                        Text('Chairs', style: TextStyles.titleLarge),

                        const SizedBox(height: 15),

                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 7,
                          childAspectRatio: 0.665,
                          children: [
                            CategoryCard(
                              categoryName: 'Sofa',
                              imagePath: 'assets/images/sofaone.jpg',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Bed',
                              imagePath: 'assets/images/sofatwo.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Table',
                              imagePath: 'assets/images/sofathree.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Chair',
                              imagePath: 'assets/images/sofafour.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Cabinet',
                              imagePath: 'assets/images/sofafive.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Shelf',
                              imagePath: 'assets/images/sofasix.png',
                              onTap: () {
                                // Handle shelf category tap
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // Storage Category Section
                        Text('Storage', style: TextStyles.titleLarge),

                        const SizedBox(height: 15),

                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 7,
                          childAspectRatio: 0.665,
                          children: [
                            CategoryCard(
                              categoryName: 'Sofa',
                              imagePath: 'assets/images/sofaone.jpg',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Bed',
                              imagePath: 'assets/images/sofatwo.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Table',
                              imagePath: 'assets/images/sofathree.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Chair',
                              imagePath: 'assets/images/sofafour.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Cabinet',
                              imagePath: 'assets/images/sofafive.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Shelf',
                              imagePath: 'assets/images/sofasix.png',
                              onTap: () {
                                // Handle shelf category tap
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        // Small visual gap (SafeArea prevents clipping by the BottomAppBar)
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
    required HomeController controller,
  }) {
    final isActive = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changePageIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: isActive
                  ? AppColors.primaryColor
                  : AppColors.textColorHint,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? AppColors.primaryColor
                    : AppColors.textColorHint,
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
        Icons.chair,
        size: 40,
        color: AppColors.greyColor.withOpacity(0.6),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    final c = category.toLowerCase();
    if (c.contains('sofa')) return Icons.weekend_rounded;
    if (c.contains('bed')) return Icons.bed_rounded;
    if (c.contains('table')) return Icons.table_chart_rounded;
    if (c.contains('chair')) return Icons.chair_rounded;
    if (c.contains('lamp') || c.contains('light') || c.contains('lighting'))
      return Icons.lightbulb;
    if (c.contains('cabinet') || c.contains('storage') || c.contains('shelf'))
      return Icons.inventory_2_rounded;
    return Icons.chair;
  }
}
