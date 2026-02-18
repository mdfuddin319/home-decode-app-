import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/models/product_model.dart';
import '../../controller/product_details_controller.dart';

class ProductDetailsWidget extends StatelessWidget {
  final Product product;

  const ProductDetailsWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Add to Cart
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.addToCart(product),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  side: BorderSide(color: Colors.black12),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// Buy Now
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.buyNow(product),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text("Buy Now", style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),

      /// 🔹 Scrollable Body
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HERO IMAGE
            Hero(
              tag: "product_${product.id}",
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset(product.image, fit: BoxFit.cover),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title + Wishlist
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Obx(() {
                        final isFav = controller.isFavorite(product.id);

                        return IconButton(
                          onPressed: () =>
                              controller.toggleFavorite(product.id),
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        );
                      }),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(${product.reviews} reviews)",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Price
                  Text(
                    "₹${product.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Description
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Extra Info
                  if (product.brand.isNotEmpty || product.dimensions.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          if (product.brand.isNotEmpty)
                            Row(
                              children: [
                                const Icon(
                                  Icons.verified,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text("Brand: ${product.brand}"),
                              ],
                            ),

                          if (product.dimensions.isNotEmpty) ...[
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.straighten,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 8),
                                Text("Size: ${product.dimensions}"),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                  const SizedBox(height: 80), // space for bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
