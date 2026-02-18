import 'package:flutter/material.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';

class LuxurySuggestedSection extends StatelessWidget {
  const LuxurySuggestedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      const ProductCard(
        image: "assets/images/sofas20.png",
        title: "Milan Tan Executive Sofa",
        rating: 4.8,
        price: "₹1,25,999",
        oldPrice: "1,59,999",
        dealText: "Luxury Deal",
      ),

      const ProductCard(
        image: "assets/images/sofas21.png",
        title: "Tuscan Obsidian Leather Sofa",
        rating: 4.9,
        price: "₹1,32,000",
        oldPrice: "1,65,000",
        dealText: "Exclusive Offer",
      ),

      const ProductCard(
        image: "assets/images/sofas22.png",
        title: "Florence Cocoa L-Sofa",
        rating: 4.7,
        price: "₹1,85,999",
        oldPrice: "2,10,000",
        dealText: "Premium Deal",
      ),

      const ProductCard(
        image: "assets/images/sofas23.png",
        title: "Venice Slate Italian Leather",
        rating: 4.8,
        price: "₹1,15,500",
        oldPrice: "1,45,000",
        dealText: "Luxury Deal",
      ),

      const ProductCard(
        image: "assets/images/sofas24.png",
        title: "Roma Vintage Cognac Sofa",
        rating: 4.6,
        price: "₹1,09,999",
        oldPrice: "1,39,999",
        dealText: "Vintage Series",
      ),

      const ProductCard(
        image: "assets/images/sofas25.png",
        title: "Napoli Pure White Leather",
        rating: 4.9,
        price: "₹1,45,000",
        oldPrice: "1,75,000",
        dealText: "Elite Collection",
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
