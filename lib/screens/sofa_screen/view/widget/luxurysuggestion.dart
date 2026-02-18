import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';

import '../../../../core/models/product_model.dart';
import '../../../../routes/app_pages.dart';

class LuxurySuggestedSection extends StatelessWidget {
  const LuxurySuggestedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      ProductCard(
        image: "assets/images/sofas20.png",
        title: "Milan Tan Executive Sofa",
        rating: 4.8,
        price: "₹1,25,999",
        oldPrice: "1,59,999",
        dealText: "Luxury Deal",
        onImageTap: () {
          final product = Product(
            id: 201,
            name: "Milan Tan Executive Sofa",
            price: 125999,
            image: "assets/images/sofas20.png",
            rating: 4.8,
            reviews: 0,
            description: "Premium executive leather sofa with luxury comfort.",
            category: "sofa",
            images: const ["assets/images/sofas20.png"],
          );

          Get.toNamed(AppRoutes.productDetails, arguments: product);
        },
      ),

      ProductCard(
        image: "assets/images/sofas21.png",
        title: "Tuscan Obsidian Leather Sofa",
        rating: 4.9,
        price: "₹1,32,000",
        oldPrice: "1,65,000",
        dealText: "Exclusive Offer",
        onImageTap: () {
          final product = Product(
            id: 202,
            name: "Tuscan Obsidian Leather Sofa",
            price: 132000,
            image: "assets/images/sofas21.png",
            rating: 4.9,
            reviews: 0,
            description: "Italian leather finish luxury sofa.",
            category: "sofa",
            images: const ["assets/images/sofas21.png"],
          );

          Get.toNamed(AppRoutes.productDetails, arguments: product);
        },
      ),

      ProductCard(
        image: "assets/images/sofas22.png",
        title: "Florence Cocoa L-Sofa",
        rating: 4.7,
        price: "₹1,85,999",
        oldPrice: "2,10,000",
        dealText: "Premium Deal",
        onImageTap: () {
          final product = Product(
            id: 203,
            name: "Florence Cocoa L-Sofa",
            price: 185999,
            image: "assets/images/sofas22.png",
            rating: 4.7,
            reviews: 0,
            description: "Premium L-shaped sofa with cocoa finish.",
            category: "sofa",
            images: const ["assets/images/sofas22.png"],
          );

          Get.toNamed(AppRoutes.productDetails, arguments: product);
        },
      ),

      ProductCard(
        image: "assets/images/sofas23.png",
        title: "Venice Slate Italian Leather",
        rating: 4.8,
        price: "₹1,15,500",
        oldPrice: "1,45,000",
        dealText: "Luxury Deal",
        onImageTap: () {
          final product = Product(
            id: 204,
            name: "Venice Slate Italian Leather",
            price: 115500,
            image: "assets/images/sofas23.png",
            rating: 4.8,
            reviews: 0,
            description: "Italian leather sofa with sleek slate finish.",
          );

          Get.toNamed(AppRoutes.productDetails, arguments: product);
        },
      ),

      ProductCard(
        image: "assets/images/sofas24.png",
        title: "Roma Vintage Cognac Sofa",
        rating: 4.6,
        price: "₹1,09,999",
        oldPrice: "1,39,999",
        dealText: "Vintage Series",
        onImageTap: () {
          final product = Product(
            id: 205,
            name: "Roma Vintage Cognac Sofa",
            price: 109999,
            image: "assets/images/sofas24.png",
            rating: 4.6,
            reviews: 0,
            description: "Vintage cognac leather sofa with timeless appeal.",
            category: "sofa",
            images: const ["assets/images/sofas24.png"],
          );

          Get.toNamed(AppRoutes.productDetails, arguments: product);
        },
      ),

      ProductCard(
        image: "assets/images/sofas25.png",
        title: "Napoli Pure White Leather",
        rating: 4.9,
        price: "₹1,45,000",
        oldPrice: "1,75,000",
        dealText: "Elite Collection",
        onImageTap: () {
          final product = Product(
            id: 206,
            name: "Napoli Pure White Leather",
            price: 145000,
            image: "assets/images/sofas25.png",
            rating: 4.9,
            reviews: 0,
            description: "Pure white leather sofa with elite craftsmanship.",
            category: "sofa",
            images: const ["assets/images/sofas25.png"],
          );

          Get.toNamed(AppRoutes.productDetails, arguments: product);
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Heading Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Luxury Sofa",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 🔹 Grid Layout (3 per row)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true, // ⭐ IMPORTANT
            physics: const NeverScrollableScrollPhysics(), // ⭐ IMPORTANT
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // ⭐ 3 items per row
              crossAxisSpacing: 3,
              mainAxisSpacing: 12,
              childAspectRatio: 0.57,
            ),
            itemBuilder: (context, index) {
              return products[index];
            },
          ),
        ),
      ],
    );
  }
}
