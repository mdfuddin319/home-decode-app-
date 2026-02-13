import 'package:get/get.dart';
import '../../core/base/base_controller.dart';
import '../../core/models/product_model.dart';
import '../../apihelper/repositories/api_repository.dart';

class CartController extends BaseController {
  final ApiRepository _apiRepository = ApiRepository();
  var cartItems = <CartItem>[].obs;
  var totalPrice = 0.0.obs;
  double get subtotal => totalPrice.value;

  double get discount => 5.55;

  double get deliveryFee => 5.00;

  double get total => subtotal - discount + deliveryFee;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    // Load cart items from storage or initialize empty
    cartItems.clear();
    totalPrice.value = 0.0;
  }

  void addToCart(Product product) {
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.product.id == product.id,
    );

    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }

    calculateTotal();
  }

  void removeFromCart(CartItem cartItem) {
    cartItems.remove(cartItem);
    calculateTotal();
  }

  void updateQuantity(CartItem cartItem, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(cartItem);
    } else {
      cartItem.quantity = newQuantity;
    }
    calculateTotal();
  }

  void calculateTotal() {
    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  int get itemCount {
    return cartItems.fold(0, (count, item) => count + item.quantity);
  }
}

class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
