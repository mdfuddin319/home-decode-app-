import 'package:flutter/material.dart';
import 'package:home_decor_app/screens/sofa_screen/view/widget/ProductCard.dart';

class SuggestedSection extends StatelessWidget {
  const SuggestedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

        // Product List
        SizedBox(
          height: 240,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              ProductCard(
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
