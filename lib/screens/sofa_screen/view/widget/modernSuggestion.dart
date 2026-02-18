import 'package:flutter/material.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';
import 'package:home_decor_app/screens/product_details_page/view/productDetailsPage.dart';

import '../../../../core/models/product_model.dart';

class ModernSuggestedSection extends StatelessWidget {
  const ModernSuggestedSection({Key? key}) : super(key: key);

  double _parsePrice(String value) {
    final sanitized = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(sanitized) ?? 0;
  }

  void _openDetails(
    BuildContext context, {
    required int id,
    required String name,
    required String priceText,
    required String image,
    required double rating,
    required String description,
  }) {
    final product = Product(
      id: id,
      name: name,
      price: _parsePrice(priceText),
      image: image,
      rating: rating,
      reviews: 0,
      description: description,
      category: 'sofa',
      images: [image],
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailsView(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = [
      ProductCard(
        image: "assets/images/sofas14.png",
        title: "Aura Modular Sectional Sofa",
        rating: 4.7,
        price: "₹40,900",
        oldPrice: "45,999",
        dealText: "Summer Deal",
        onImageTap: () => _openDetails(
          context,
          id: 201,
          name: "Aura Modular Sectional Sofa",
          priceText: "₹40,900",
          image: "assets/images/sofas14.png",
          rating: 4.7,
          description:
              "Modular sectional design that adapts easily to your space.",
        ),
      ),
      ProductCard(
        image: "assets/images/sofas15.png",
        title: "Nordic Luxe 3-Seater Sofa",
        rating: 4.7,
        price: "₹38,000",
        oldPrice: "42,500",
        dealText: "Bestseller",
        onImageTap: () => _openDetails(
          context,
          id: 202,
          name: "Nordic Luxe 3-Seater Sofa",
          priceText: "₹38,000",
          image: "assets/images/sofas15.png",
          rating: 4.7,
          description: "Minimal Scandinavian styling with plush seating.",
        ),
      ),
      ProductCard(
        image: "assets/images/sofas16.png",
        title: "Loft Living Fabric Sofa",
        rating: 4.4,
        price: "₹33,000",
        oldPrice: "39,999",
        dealText: "Weekend Discount",
        onImageTap: () => _openDetails(
          context,
          id: 203,
          name: "Loft Living Fabric Sofa",
          priceText: "₹33,000",
          image: "assets/images/sofas16.png",
          rating: 4.4,
          description: "Everyday comfort with a modern loft-inspired look.",
        ),
      ),
      ProductCard(
        image: "assets/images/sofas17.png",
        title: "Emerald Curved Velvet Sofa",
        rating: 4.8,
        price: "₹54,900",
        oldPrice: "68,000",
        dealText: "Premium Pick",
        onImageTap: () => _openDetails(
          context,
          id: 204,
          name: "Emerald Curved Velvet Sofa",
          priceText: "₹54,900",
          image: "assets/images/sofas17.png",
          rating: 4.8,
          description:
              "Statement curved silhouette with rich velvet upholstery.",
        ),
      ),
      ProductCard(
        image: "assets/images/sofas18.png",
        title: "Urban Slate 3-Seater Couch",
        rating: 4.5,
        price: "₹28,500",
        oldPrice: "35,000",
        dealText: "Super Value",
        onImageTap: () => _openDetails(
          context,
          id: 205,
          name: "Urban Slate 3-Seater Couch",
          priceText: "₹28,500",
          image: "assets/images/sofas18.png",
          rating: 4.5,
          description: "Clean lines, supportive cushions, great value.",
        ),
      ),
      ProductCard(
        image: "assets/images/sofas19.png",
        title: "Haven Cloud Plush Sofa",
        rating: 4.6,
        price: "₹49,999",
        oldPrice: "58,500",
        dealText: "New Arrival",
        onImageTap: () => _openDetails(
          context,
          id: 206,
          name: "Haven Cloud Plush Sofa",
          priceText: "₹49,999",
          image: "assets/images/sofas19.png",
          rating: 4.6,
          description: "Extra-plush comfort with a soft, cloud-like feel.",
        ),
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
