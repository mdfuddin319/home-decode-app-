import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_decor_app/core/models/product_model.dart';

import 'widget/product_details_widget.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ProductDetailsWidget(product: product),
    );
  }
}
