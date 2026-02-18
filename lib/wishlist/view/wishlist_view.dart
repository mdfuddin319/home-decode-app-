import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_decor_app/wishlist/controller/wishlist_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/values/app_strings.dart';
import '../../../core/models/product_model.dart';


class WishlistView extends StatelessWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WishlistController controller = Get.find<WishlistController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        title: Text(
          AppStrings.wishlist,
          style: TextStyles.headlineSmall.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => controller.wishlistCount > 0
                ? IconButton(
                    icon: const Icon(
                      Icons.delete_sweep,
                      color: AppColors.errorColor,
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: 'Clear Wishlist',
                        middleText:
                            'Are you sure you want to clear your entire wishlist?',
                        textConfirm: 'Yes, Clear',
                        textCancel: 'Cancel',
                        confirmTextColor: Colors.white,
                        buttonColor: AppColors.errorColor,
                        onConfirm: () {
                          controller.clearWishlist();
                          Get.back();
                        },
                      );
                    },
                  )
                : const SizedBox.shrink(),
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
            : controller.wishlistItems.isEmpty
            ? _buildEmptyWishlist()
            : _buildWishlistContent(controller),
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: AppColors.greyColor.withOpacity(0.6),
          ),
          const SizedBox(height: 24),
          Text(
            'Your wishlist is empty',
            style: TextStyles.headlineMedium.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Start adding items you love to your wishlist',
            style: TextStyles.bodyMedium.copyWith(
              color: AppColors.textColorHint,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Get.offAllNamed('/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistContent(WishlistController controller) {
    return Column(
      children: [
        // Wishlist Summary
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                'Wishlist Summary',
                style: TextStyles.titleLarge.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryItem(
                    icon: Icons.shopping_bag,
                    value: controller.wishlistCount.toString(),
                    label: 'Items',
                  ),
                  _summaryItem(
                    icon: Icons.attach_money,
                    value:
                        '\$${controller.totalWishlistValue.toStringAsFixed(2)}',
                    label: 'Total Value',
                  ),
                ],
              ),
            ],
          ),
        ),
        // Wishlist Items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.wishlistItems.length,
            itemBuilder: (context, index) {
              final product = controller.wishlistItems[index];
              return _wishlistItemCard(controller, product, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 28, color: AppColors.primaryColor),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyles.titleMedium.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyles.bodySmall.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
      ],
    );
  }

  Widget _wishlistItemCard(
    WishlistController controller,
    Product product,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: product.image != null && product.image.isNotEmpty
                child: product.image.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.chair,
                              size: 40,
                              color: AppColors.greyColor.withOpacity(0.6),
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.chair,
                        size: 40,
                        color: AppColors.greyColor.withOpacity(0.6),
                      ),
              ),
              // Product Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyles.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyles.titleMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.warningColor,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toString(),
                            style: TextStyles.bodySmall,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(12)',
                            style: TextStyles.bodySmall.copyWith(
                              color: AppColors.textColorHint,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Action Buttons
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: AppColors.errorColor,
                      size: 24,
                    ),
                    onPressed: () => controller.removeFromWishlist(product),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                    onPressed: () {
                      // Navigate to product details or add to cart
                      Get.toNamed('/product-details', arguments: product);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
