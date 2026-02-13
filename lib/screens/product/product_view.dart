import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'product_controller.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        title: Text(
          AppStrings.products,
          style: TextStyles.headlineSmall.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Categories
                    SizedBox(
                      height: 60,
                      child: Obx(
                        () => ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            String category = controller.categories[index];
                            bool isSelected =
                                controller.selectedCategory.value == category ||
                                (controller.selectedCategory.value.isEmpty &&
                                    index == 0);

                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => controller
                                      .loadProductsByCategory(category),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColors.whiteColor
                                          : AppColors.textColorPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Products List
                    Expanded(
                      child: Obx(
                        () => GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.7,
                              ),
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            var product = controller.products[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.greyColor.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      color: AppColors.backgroundColor,
                                      child: const Center(
                                        child: Icon(
                                          Icons.chair,
                                          size: 50,
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
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
                                        const SizedBox(height: 5),
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyles.bodyMedium.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.warningColor,
                                              size: 14,
                                            ),
                                            Text(
                                              product.rating.toString(),
                                              style: TextStyles.bodySmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () =>
                                              controller.addToCart(product),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            AppStrings.addToCart,
                                            style: TextStyles.labelMedium
                                                .copyWith(
                                                  color: AppColors.whiteColor,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
