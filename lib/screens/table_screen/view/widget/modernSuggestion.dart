import 'package:flutter/material.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';

class ModernSuggestedSection extends StatelessWidget {
  const ModernSuggestedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      const ProductCard(
        image: "assets/images/sofas14.png",
        title: "Aura Modular Sectional Sofa",
        rating: 4.7,
        price: "₹40,900",
        oldPrice: "45,999",
        dealText: "Summer Deal",
      ),
      const ProductCard(
        image: "assets/images/sofas15.png",
        title: "Nordic Luxe 3-Seater Sofa",
        rating: 4.7,
        price: "₹38,000",
        oldPrice: "42,500",
        dealText: "Bestseller",
      ),
      const ProductCard(
        image: "assets/images/sofas16.png",
        title: "Loft Living Fabric Sofa",
        rating: 4.4,
        price: "₹33,000",
        oldPrice: "39,999",
        dealText: "Weekend Discount",
      ),
      const ProductCard(
        image: "assets/images/sofas17.png",
        title: "Emerald Curved Velvet Sofa",
        rating: 4.8,
        price: "₹54,900",
        oldPrice: "68,000",
        dealText: "Premium Pick",
      ),
      const ProductCard(
        image: "assets/images/sofas18.png",
        title: "Urban Slate 3-Seater Couch",
        rating: 4.5,
        price: "₹28,500",
        oldPrice: "35,000",
        dealText: "Super Value",
      ),
      const ProductCard(
        image: "assets/images/sofas19.png",
        title: "Haven Cloud Plush Sofa",
        rating: 4.6,
        price: "₹49,999",
        oldPrice: "58,500",
        dealText: "New Arrival",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Modern Sofa",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 12,
              childAspectRatio: 0.56,
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
