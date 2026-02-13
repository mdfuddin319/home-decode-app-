import 'package:get/get.dart';
import '../api_provider/api_provider.dart';
import '../../core/models/product_model.dart';

class ApiRepository extends GetConnect {
  final ApiProvider _apiProvider = ApiProvider();

  // Product APIs
  Future<List<Product>> getProducts() async {
    try {
      final response = await _apiProvider.get('/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _apiProvider.get('/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data['data']);
      }
      throw Exception('Failed to load product');
    } catch (e) {
      throw Exception('Error loading product: $e');
    }
  }

  // Cart APIs
  Future<void> addToCart(int productId, int quantity) async {
    try {
      Map<String, dynamic> data = {
        'product_id': productId,
        'quantity': quantity,
      };
      final response = await _apiProvider.post('/cart', data: data);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  // User APIs
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _apiProvider.get('/user/profile');
      if (response.statusCode == 200) {
        return response.data['data'];
      }
      throw Exception('Failed to load user profile');
    } catch (e) {
      throw Exception('Error loading profile: $e');
    }
  }
}
