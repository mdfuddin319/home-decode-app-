import 'package:flutter/material.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';

class SuggestedSection extends StatelessWidget {
  const SuggestedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                "Suggested For You",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 🔹 Product List
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              ProductCard(
                image: "assets/images/beds10.png",
                title: "Vogue Smart Hydraulic King Bed",
                rating: 4.8,
                price: "₹74,900",
                oldPrice: "1,67,500",
                dealText: "Festival Offer - 55% Off",
              ),

              ProductCard(
                image: "assets/images/beds11.png",
                title: "Harlow Modern Solid Wood Platform",
                rating: 4.6,
                price: "₹29,999",
                oldPrice: "58,998",
                dealText: "Limited Time Deal",
              ),

              ProductCard(
                image: "assets/images/beds12.png",
                title: "Aurora Royale Grand Upholstered",
                rating: 4.9,
                price: "₹80,999",
                oldPrice: "2,29,999",
                dealText: "Premium Choice",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
