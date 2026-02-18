import 'package:get/get.dart';

import '../../../core/models/product_model.dart';

class ProductDetailsController extends GetxController {
  var favorites = <int>[].obs;

  void toggleFavorite(int productId) {
    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }
  }

  bool isFavorite(int productId) {
    return favorites.contains(productId);
  }

  void addToCart(Product product) {
    Get.snackbar("Cart", "${product.name} added to cart");
  }

  void buyNow(Product product) {
    Get.snackbar("Buy Now", "Proceeding to checkout");
  }
}
