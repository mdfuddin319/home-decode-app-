class CartItem {
  final String name;
  final String size;
  final String color;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.size,
    required this.color,
    required this.price,
    this.quantity = 1,
  });
}
