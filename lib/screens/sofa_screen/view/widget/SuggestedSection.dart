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
        // Product List
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              ProductCard(
                image:
                    "https://images.unsplash.com/photo-1598327105666-5b89351aff97",
                name: "Moto G96 5G",
                rating: 4.4,
                price: "₹17,999",
                oldPrice: "20,999",
                dealText: "Super Deals",
              ),

              ProductCard(
                image:
                    "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
                name: "OPPO Reno",
                rating: 4.6,
                price: "₹45,999",
                oldPrice: "49,999",
                dealText: "Limited Offer",
              ),

              ProductCard(
                image:
                    "https://images.unsplash.com/photo-1580910051074-3eb694886505",
                name: "Vivo T3 Lite",
                rating: 4.4,
                price: "₹11,499",
                oldPrice: "15,499",
                dealText: "Hot Deal",
                image: "assets/images/sofas11.png",
                title: "Everett Fabric 3-Seater Sofa",
                rating: 4.6,
                price: "₹32,499",
                oldPrice: "₹45,000",
                dealText: "Limited Time Offer",
              ),

              ProductCard(
                image: "assets/images/sofas12.png",
                title: "Royal Velvet Tufted Sofa",
                rating: 4.8,
                price: "₹54,999",
                oldPrice: "₹72,000",
                dealText: "Festival Special",
              ),

              ProductCard(
                image: "assets/images/sofas13.png",
                title: "Heritage Faux-Leather Couch",
                rating: 4.2,
                price: "₹28,800",
                oldPrice: "₹35,500",
                dealText: "Hot Seller",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
