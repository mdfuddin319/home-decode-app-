import 'package:get/get.dart';
import '../../core/base/base_controller.dart';
import '../../core/models/product_model.dart';
import '../../apihelper/repositories/api_repository.dart';

class ProductController extends BaseController {
  final ApiRepository _apiRepository = ApiRepository();
  var products = <Product>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    loadCategories();
  }

  void loadProducts() async {
    setLoading(true);
    try {
      final data = await _apiRepository.getProducts();
      products.assignAll(data);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void loadProductsByCategory(String category) async {
    selectedCategory.value = category;
    // In a real app, you would fetch products by category
    loadProducts();
  }

  void loadCategories() {
    categories.assignAll([
      "All",
      "Sofas",
      "Tables",
      "Chairs",
      "Beds",
      "Storage",
      "Lighting",
    ]);
  }

  void addToCart(Product product) async {
    try {
      await _apiRepository.addToCart(product.id, 1);
      Get.snackbar(
        "Success",
        "${product.name} added to cart!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add to cart",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
