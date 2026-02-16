import 'package:flutter/material.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';

class LuxurySuggestedSection extends StatelessWidget {
  const LuxurySuggestedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      const ProductCard(
        image: "https://images.unsplash.com/photo-1555041469-a586c61ea9bc",
        title: "Italian Leather Sofa",
        rating: 4.8,
        price: "₹1,25,999",
        oldPrice: "1,59,999",
        dealText: "Luxury Deal",
      ),

      const ProductCard(
        image: "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85",
        title: "Modern Velvet Sofa",
        rating: 4.6,
        price: "₹89,999",
        oldPrice: "1,09,999",
        dealText: "Limited Offer",
      ),

      const ProductCard(
        image: "https://images.unsplash.com/photo-1493666438817-866a91353ca9",
        title: "Premium Corner Sofa",
        rating: 4.7,
        price: "₹1,45,999",
        oldPrice: "1,79,999",
        dealText: "Best Seller",
      ),

      const ProductCard(
        image: "https://images.unsplash.com/photo-1484101403633-562f891dc89a",
        title: "Minimalist Grey Sofa",
        rating: 4.5,
        price: "₹74,999",
        oldPrice: "94,999",
        dealText: "Hot Deal",
      ),

      const ProductCard(
        image: "https://images.unsplash.com/photo-1615874959474-d609969a20ed",
        title: "Luxury Chesterfield",
        rating: 4.9,
        price: "₹1,95,999",
        oldPrice: "2,29,999",
        dealText: "Premium Pick",
      ),

      const ProductCard(
        image: "https://images.unsplash.com/photo-1600210492486-724fe5c67fb3",
        title: "Elegant Beige Sofa",
        rating: 4.6,
        price: "₹99,999",
        oldPrice: "1,29,999",
        dealText: "Mega Offer",
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
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
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
