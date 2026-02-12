import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

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
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search furniture...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: AppColors.backgroundColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Categories
                      Text(AppStrings.categories, style: TextStyles.titleLarge),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 60,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.categories.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? AppColors.primaryColor
                                      : AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.categories[index],
                                    style: TextStyle(
                                      color: index == 0
                                          ? AppColors.whiteColor
                                          : AppColors.textColorPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Featured Products
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Featured Products',
                            style: TextStyles.titleLarge,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('See All'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 250,
                        child: Obx(
                          () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.featuredProducts.length,
                            itemBuilder: (context, index) {
                              var product = controller.featuredProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    '/product-details',
                                    arguments: product,
                                  );
                                },
                                child: Container(
                                  width: 180,
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.greyColor.withOpacity(
                                          0.2,
                                        ),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              style: TextStyles.titleMedium,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '\$${product.price.toStringAsFixed(2)}',
                                              style: TextStyles.titleMedium
                                                  .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: AppColors.warningColor,
                                                  size: 16,
                                                ),
                                                Text(
                                                  product.rating.toString(),
                                                  style: TextStyles.bodySmall,
                                                ),
                                              ],
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

                      const SizedBox(height: 15),

                      Obx(
                        () => GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.greyColor.withOpacity(
                                        0.2,
                                      ),
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
                                        height: 120,
                                        width: double.infinity,
                                        color: AppColors.backgroundColor,
                                        child: const Center(
                                          child: Icon(
                                            Icons.chair,
                                            size: 40,
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
                                            style: TextStyles.bodyMedium
                                                .copyWith(
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
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: controller.currentIndex.value == 0
                        ? AppColors.primaryColor
                        : AppColors.textColorHint,
                  ),
                  onPressed: () => controller.changePageIndex(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.category,
                    color: controller.currentIndex.value == 1
                        ? AppColors.primaryColor
                        : AppColors.textColorHint,
                  ),
                  onPressed: () => controller.changePageIndex(1),
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: controller.currentIndex.value == 2
                        ? AppColors.primaryColor
                        : AppColors.textColorHint,
                  ),
                  onPressed: () => controller.changePageIndex(2),
                ),
                IconButton(
                  icon: Icon(
                    Icons.person_outline,
                    color: controller.currentIndex.value == 3
                        ? AppColors.primaryColor
                        : AppColors.textColorHint,
                  ),
                  onPressed: () => controller.changePageIndex(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
