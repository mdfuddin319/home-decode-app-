import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/base_controller.dart';
import '../../../core/models/product_model.dart';
import '../../../app_manager/local_storage.dart';

class WishlistController extends BaseController {
  var wishlistItems = <Product>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWishlist();
  }

  void loadWishlist() async {
    try {
      isLoading.value = true;
      final List<Product> savedWishlist = await LocalStorage.getWishlist();
      wishlistItems.assignAll(savedWishlist);
    } catch (e) {
      setError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void addToWishlist(Product product) async {
    try {
      final updatedWishlist = List<Product>.from(wishlistItems);
      updatedWishlist.add(product);
      await LocalStorage.saveWishlist(updatedWishlist);
      wishlistItems.assignAll(updatedWishlist);
      Get.snackbar(
        'Added to Wishlist',
        '${product.name} has been added to your wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      setError(e.toString());
      Get.snackbar(
        'Error',
        'Failed to add item to wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeFromWishlist(Product product) async {
    try {
      final updatedWishlist = List<Product>.from(
        wishlistItems,
      ).where((item) => item.id != product.id).toList();
      await LocalStorage.saveWishlist(updatedWishlist);
      wishlistItems.assignAll(updatedWishlist);
      Get.snackbar(
        'Removed from Wishlist',
        '${product.name} has been removed from your wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } catch (e) {
      setError(e.toString());
      Get.snackbar(
        'Error',
        'Failed to remove item from wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product)) {
      removeFromWishlist(product);
    } else {
      addToWishlist(product);
    }
  }

  bool isInWishlist(Product product) {
    return wishlistItems.any((item) => item.id == product.id);
  }

  void clearWishlist() async {
    try {
      await LocalStorage.saveWishlist([]);
      wishlistItems.clear();
      Get.snackbar(
        'Wishlist Cleared',
        'Your wishlist has been cleared',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    } catch (e) {
      setError(e.toString());
      Get.snackbar(
        'Error',
        'Failed to clear wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  double get totalWishlistValue {
    return wishlistItems.fold(0.0, (sum, item) => sum + item.price);
  }

  int get wishlistCount => wishlistItems.length;
}
