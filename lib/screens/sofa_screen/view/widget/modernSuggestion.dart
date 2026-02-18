import 'package:flutter/material.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';

class ModernSuggestedSection extends StatelessWidget {
  const ModernSuggestedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = [
      const ProductCard(
        image: "assets/images/sofaC1.png",
        name: "Moto G96 5G",
        rating: 4.4,
        price: "₹17,999",
        oldPrice: "20,999",
        dealText: "Super Deals",
      ),
      const ProductCard(
        image: "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
        name: "OPPO Reno",
        rating: 4.6,
        price: "₹45,999",
        oldPrice: "49,999",
        dealText: "Limited Offer",
      ),
      const ProductCard(
        image: "https://images.unsplash.com/photo-1580910051074-3eb694886505",
        name: "Vivo T3 Lite",
        rating: 4.4,
        price: "₹11,499",
        oldPrice: "15,499",
        dealText: "Hot Deal",
      ),
      const ProductCard(
        image: "https://images.unsplash.com/photo-1606813907291-d86efa9b94db",
        name: "Realme Narzo",
        rating: 4.2,
        price: "₹13,999",
        oldPrice: "16,999",
        dealText: "Best Seller",
      ),
      const ProductCard(
        image: "https://images.unsplash.com/photo-1510557880182-3c5f9b7f2c6c",
        name: "iQOO Neo",
        rating: 4.5,
        price: "₹29,999",
        oldPrice: "34,999",
        dealText: "Mega Offer",
      ),
      const ProductCard(
        image: "https://images.unsplash.com/photo-1585386959984-a415522316f3",
        name: "Samsung Galaxy",
        rating: 4.7,
        price: "₹55,999",
        oldPrice: "62,999",
        dealText: "Premium Pick",
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
        // 🔹 Heading Row
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
