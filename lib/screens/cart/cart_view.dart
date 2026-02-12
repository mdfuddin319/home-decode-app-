import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_strings.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        title: Text(
          AppStrings.shoppingCart,
          style: TextStyles.headlineSmall.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.cartItems.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: AppColors.greyColor,
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppStrings.emptyCart,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textColorHint,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Add some items to your cart',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textColorHint,
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          var item = controller.cartItems[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.chair,
                                      size: 40,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: TextStyles.bodyMedium,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '\$${item.product.price.toStringAsFixed(2)}',
                                          style: TextStyles.bodyMedium.copyWith(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.greyColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    onPressed: () => controller
                                                        .updateQuantity(
                                                          item,
                                                          item.quantity - 1,
                                                        ),
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${item.quantity}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () => controller
                                                        .updateQuantity(
                                                          item,
                                                          item.quantity + 1,
                                                        ),
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () => controller
                                                  .removeFromCart(item),
                                              icon: const Icon(
                                                Icons.delete,
                                                color: AppColors.errorColor,
                                              ),
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
                    const Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.cartTotal,
                            style: TextStyles.titleMedium,
                          ),
                          Text(
                            '\$${controller.totalPrice.value.toStringAsFixed(2)}',
                            style: TextStyles.headlineSmall.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Order Placed",
                            middleText:
                                "Your order has been placed successfully!",
                            textConfirm: AppStrings.ok,
                            confirmTextColor: AppColors.whiteColor,
                            onConfirm: () {
                              Get.back();
                              controller.loadCart(); // Clear cart
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppStrings.checkout,
                          style: TextStyles.titleMedium.copyWith(
                            color: AppColors.whiteColor,
                          ),
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
