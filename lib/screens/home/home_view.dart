import 'dart:async';

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
        // centerTitle: true,
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              return Obx(() {
                                final isSelected =
                                    controller.selectedIndex.value == index;
                                final category = controller.categories[index];

                                return GestureDetector(
                                  onTap: () {
                                    controller.selectCategory(index);
                                    // Navigate based on category
                                    _navigateToCategory(category);
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
                                            _getCategoryIcon(category),
                                            color: isSelected
                                                ? AppColors.whiteColor
                                                : AppColors.primaryColor,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            category,
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
                              });
                            },
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
                          height: 2,
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
                                      color: const Color.fromARGB(
                                        255,
                                        83,
                                        159,
                                        178,
                                      ),
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

                        // Promotional Section: Banners + Auto Carousel
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left side: Stacked promotional banners
                            Expanded(
                              child: Column(
                                children: [
                                  // First Promotional Banner Card
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryColor.withOpacity(
                                            0.8,
                                          ),
                                          AppColors.primaryColor.withOpacity(
                                            0.5,
                                          ),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        // Background pattern
                                        Positioned(
                                          right: -30,
                                          bottom: -30,
                                          child: Icon(
                                            Icons.chair_rounded,
                                            size: 120,
                                            color: Colors.white.withOpacity(
                                              0.1,
                                            ),
                                          ),
                                        ),
                                        // Promo content
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Special Offer on EID',
                                                    style: TextStyles.titleSmall
                                                        .copyWith(
                                                          color: Colors.white70,
                                                          fontSize: 12,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Get 30% Off',
                                                    style: TextStyles
                                                        .headlineSmall
                                                        .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.toNamed('/product');
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.whiteColor,
                                                  foregroundColor:
                                                      AppColors.primaryColor,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Shop Now',
                                                  style: TextStyles.bodySmall
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Second Promotional Banner Card
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color.fromARGB(
                                            255,
                                            7,
                                            181,
                                            255,
                                          ).withOpacity(0.8),
                                          const Color.fromARGB(
                                            255,
                                            7,
                                            181,
                                            255,
                                          ).withOpacity(0.5),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                            255,
                                            7,
                                            181,
                                            255,
                                          ).withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        // Background pattern
                                        Positioned(
                                          right: -30,
                                          bottom: -30,
                                          child: Icon(
                                            Icons.local_shipping,
                                            size: 120,
                                            color: Colors.white.withOpacity(
                                              0.1,
                                            ),
                                          ),
                                        ),
                                        // Promo content
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Free Delivery',
                                                    style: TextStyles.titleSmall
                                                        .copyWith(
                                                          color: Colors.white70,
                                                          fontSize: 12,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'On Orders Above 99',
                                                    style: TextStyles
                                                        .headlineSmall
                                                        .copyWith(
                                                          color: AppColors
                                                              .whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.toNamed('/product');
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.whiteColor,
                                                  foregroundColor:
                                                      const Color.fromARGB(
                                                        255,
                                                        7,
                                                        181,
                                                        255,
                                                      ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Learn More',
                                                  style: TextStyles.bodySmall
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Right side: Auto-sliding carousel card
                            Expanded(child: _buildAutoSlideCarouselCard()),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Popular Products
                        Text('Popular Products', style: TextStyles.titleLarge),

                        const SizedBox(height: 12),

                        // Use a different approach for the grid without IntrinsicHeight
                        Obx(
                          () => Container(
                            constraints: const BoxConstraints(
                              minHeight: 15, // Minimum height for the grid
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
                        const SizedBox(height: 10),

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
                              categoryName: 'Camel Hump',
                              imagePath: 'assets/images/sofaC1.png',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Leather upholstery',
                              imagePath: 'assets/images/sofaC2.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: ' geometric sofa',
                              imagePath: 'assets/images/sofaC3.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Loveseat',
                              imagePath: 'assets/images/sofaC4.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: ' reclining Chaise Longue',
                              imagePath: 'assets/images/sofaC5.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Cabriole',
                              imagePath: 'assets/images/sofaC6.png',
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
                              categoryName: 'Upholstered cocoon',
                              imagePath: 'assets/images/BedC1.png',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Canopy & Four-Poster Beds',
                              imagePath: 'assets/images/BedC2.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Hydraulic Storage Beds',
                              imagePath: 'assets/images/BedC3.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Floating Beds',
                              imagePath: 'assets/images/BedC4.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Solid Wood Frames',
                              imagePath: 'assets/images/BedC5.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Smart Bases',
                              imagePath: 'assets/images/BedC6.png',
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
                              categoryName: 'Organically-Shaped Tables',
                              imagePath: 'assets/images/TableC1.png',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Live Edge & Resin',
                              imagePath: 'assets/images/TableC2.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Waterfall Consoles',
                              imagePath: 'assets/images/TableC3.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Slim floating Consoles',
                              imagePath: 'assets/images/TableC4.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'C-Tables',
                              imagePath: 'assets/images/TableC5.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Monolithic Stone Plinths',
                              imagePath: 'assets/images/TableC6.png',
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
                              categoryName: 'Curved Swivel Chairs',
                              imagePath: 'assets/images/ChairC1.png',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Wingback Shelter Chairs',
                              imagePath: 'assets/images/ChairC2.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Active-Sitting Stools',
                              imagePath: 'assets/images/ChairC3.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Mesh Performance Chairs',
                              imagePath: 'assets/images/ChairC4.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Eames-Style Lounge ',
                              imagePath: 'assets/images/ChairC5.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Pod Chairs',
                              imagePath: 'assets/images/ChairC6.png',
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
                              categoryName: 'Hidden Wardrobes',
                              imagePath: 'assets/images/StoreC1.png',
                              onTap: () {
                                // Handle sofa category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Pull-Out Pantry',
                              imagePath: 'assets/images/StoreC2.png',
                              onTap: () {
                                // Handle bed category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Under-Stair Drawer',
                              imagePath: 'assets/images/StoreC3.png',
                              onTap: () {
                                // Handle table category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Magnetic Backsplash Racks',
                              imagePath: 'assets/images/StoreC4.png',
                              onTap: () {
                                // Handle chair category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Lift-up TV',
                              imagePath: 'assets/images/StoreC5.png',
                              onTap: () {
                                // Handle cabinet category tap
                              },
                            ),
                            CategoryCard(
                              categoryName: 'Charging Station Side',
                              imagePath: 'assets/images/StoreC6.png',
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 12,
        color: Colors.white,
        child: SizedBox(
          height: 55,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(
                  icon: Icons.home_rounded,
                  label: AppStrings.home,
                  index: 0,
                ),
                _navItem(
                  icon: Icons.chair_alt_rounded,
                  label: AppStrings.products,
                  index: 1,
                ),
                const SizedBox(width: 10), // FAB Space
                _navItem(
                  icon: Icons.favorite_rounded,
                  label: AppStrings.wishlist,
                  index: 2,
                ),
                _navItem(
                  icon: Icons.person_rounded,
                  label: AppStrings.profile,
                  index: 3,
                ),
              ],
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
  }) {
    final isActive = Get.find<HomeController>().currentIndex.value == index;

    return GestureDetector(
      onTap: () {
        final controller = Get.find<HomeController>();
        controller.changePageIndex(index);

        // Navigate to the corresponding screen
        switch (index) {
          case 0:
            Get.offAllNamed('/home');
            break;
          case 1:
            Get.toNamed('/product');
            break;
          case 2:
            Get.toNamed('/wishlist');
            break;
          case 3:
            Get.toNamed('/profile');
            break;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryColor.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive
                  ? AppColors.primaryColor
                  : AppColors.textColorHint,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
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
}

/// Auto-sliding promotional carousel card builder
Widget _buildAutoSlideCarouselCard() {
  final pageController = PageController();
  int currentPage = 0;

  // Auto slide images every 3 seconds
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageController.hasClients) {
        currentPage++;
        pageController.animateToPage(
          currentPage % 4,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  });

  // Sample carousel images/products
  final carouselItems = [
    'assets/images/sofaone.jpg',
    'assets/images/sofatwo.png',
    'assets/images/sofathree.png',
    'assets/images/sofafour.png',
  ];

  return Container(
    height: 415, // Increased height for better carousel visibility
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 143, 200, 232),
          AppColors.surfaceColor.withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.greyColor.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        // Auto-sliding PageView
        Expanded(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (page) => currentPage = page,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.greyColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    carouselItems[index % carouselItems.length],
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, st) => Center(
                      child: Icon(
                        Icons.chair_rounded,
                        size: 60,
                        color: AppColors.greyColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Dot indicators
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage % 4 == index
                        ? AppColors.primaryColor
                        : AppColors.greyColor.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget navItem({
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
            color: isActive ? AppColors.primaryColor : AppColors.textColorHint,
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

/// Navigate to category-specific screen
void _navigateToCategory(String category) {
  final categoryLower = category.toLowerCase();

  if (categoryLower.contains('sofa')) {
    Get.toNamed('/sofa');
  } else if (categoryLower.contains('table')) {
    Get.toNamed('/product', arguments: {'category': 'tables'});
  } else if (categoryLower.contains('chair')) {
    Get.toNamed('/sofa'); // Navigate to sofa as fallback
  } else if (categoryLower.contains('bed')) {
    Get.toNamed('/product', arguments: {'category': 'beds'});
  } else if (categoryLower.contains('storage')) {
    Get.toNamed('/product', arguments: {'category': 'storage'});
  } else if (categoryLower.contains('lighting') ||
      categoryLower.contains('lamp')) {
    Get.toNamed('/product', arguments: {'category': 'lighting'});
  } else {
    // Default: navigate to sofa screen
    Get.toNamed('/home');
  }
}
