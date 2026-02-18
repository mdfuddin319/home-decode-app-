import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textColorPrimary,
          ),
        ),
      ),

      bottomNavigationBar: _bottomButtons(),

      body: Obx(
        () => controller.cartItems.isEmpty
            ? _emptyCart()
            : Column(
                children: [
                  /// CART LIST
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.cartItems.length,
                      itemBuilder: (_, index) {
                        final item = controller.cartItems[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// IMAGE
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: AppColors.greyColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.chair_alt_rounded,
                                  color: AppColors.greyColor,
                                ),
                              ),

                              const SizedBox(width: 12),

                              /// DETAILS
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      // item.product.title,
                                      style: TextStyles.titleMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    Text(
                                      "Size: M   Color: Red",
                                      style: TextStyles.bodySmall.copyWith(
                                        color: AppColors.textColorHint,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      '\$${item.product.price.toStringAsFixed(2)}',
                                      style: TextStyles.titleMedium.copyWith(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// DELETE
                              GestureDetector(
                                onTap: () => controller.removeFromCart(item),
                                child: const Icon(Icons.close, size: 18),
                              ),

                              const SizedBox(width: 6),

                              /// QUANTITY
                              Column(
                                children: [
                                  _qtyButton(
                                    Icons.remove,
                                    () => controller.updateQuantity(
                                      item,
                                      item.quantity - 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      "${item.quantity}",
                                      style: TextStyles.bodyMedium,
                                    ),
                                  ),
                                  _qtyButton(
                                    Icons.add,
                                    () => controller.updateQuantity(
                                      item,
                                      item.quantity + 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  /// PAYMENT SUMMARY
                  _paymentSummary(controller),
                ],
              ),
      ),
    );
  }

  // ---------------- EMPTY CART ----------------

  Widget _emptyCart() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 90,
            color: AppColors.greyColor,
          ),
          SizedBox(height: 16),
          Text("Your cart is empty", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  // ---------------- QTY BUTTON ----------------

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.greyColor),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  // ---------------- PAYMENT SUMMARY ----------------

  Widget _paymentSummary(CartController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment Summary", style: TextStyles.titleMedium),

          const SizedBox(height: 12),

          /// PROMO FIELD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.discount_outlined),
                hintText: "Enter your promo code",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          _summaryRow("Subtotal", controller.subtotal),
          _summaryRow("Coupon Discount", -controller.discount),
          _summaryRow("Delivery Fee", controller.deliveryFee),

          const Divider(height: 24),

          _summaryRow("Total Amount", controller.total, isTotal: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            '\$${value.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: isTotal
                  ? AppColors.primaryColor
                  : AppColors.textColorPrimary,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- BOTTOM BUTTONS ----------------

  Widget _bottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        border: Border(top: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Add Item"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }
}
