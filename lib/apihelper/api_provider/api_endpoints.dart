class ApiEndpoints {
  static const String baseUrl = 'https://api.homedecor.com/v1';

  // Auth endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';

  // Product endpoints
  static const String products = '$baseUrl/products';
  static const String productDetails = '$baseUrl/products/';
  static const String categories = '$baseUrl/categories';

  // User endpoints
  static const String userProfile = '$baseUrl/user/profile';
  static const String userOrders = '$baseUrl/user/orders';
  static const String wishlist = '$baseUrl/user/wishlist';

  // Cart endpoints
  static const String cart = '$baseUrl/cart';
  static const String checkout = '$baseUrl/checkout';
}
