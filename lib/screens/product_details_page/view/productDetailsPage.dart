import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/models/product_model.dart';
import 'widget/product_details_widget.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ProductDetailsWidget(product: product),
    );
  }
}
