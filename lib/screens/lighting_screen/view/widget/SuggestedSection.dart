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
                image: "assets/images/lighting14.png",
                title: "Modern LED Ceiling Light",
                rating: 4.5,
                price: "₹2,499",
                oldPrice: "₹3,999",
                dealText: "Lighting Deals",
              ),

              ProductCard(
                image: "assets/images/lighting15.png",
                title: "Designer Bedside Lamp",
                rating: 4.3,
                price: "₹1,299",
                oldPrice: "₹2,199",
                dealText: "Limited Offer",
              ),

              ProductCard(
                image: "assets/images/lighting16.png",
                title: "Hanging Pendant Light",
                rating: 4.6,
                price: "₹3,499",
                oldPrice: "₹5,499",
                dealText: "Hot Deal",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
