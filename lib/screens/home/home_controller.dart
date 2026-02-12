import 'package:get/get.dart';
import '../../core/base/base_controller.dart';
import '../../core/models/product_model.dart';
import '../../apihelper/repositories/api_repository.dart';

class HomeController extends BaseController {
  final ApiRepository _apiRepository = ApiRepository();
  var products = <Product>[].obs;
  var featuredProducts = <Product>[].obs;
  var categories = <String>[].obs;
  var currentIndex = 0.obs;
  var cartItemCount = 0.obs;
  var searchQuery = ''.obs;
  var selectedIndex = 0.obs;

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
      featuredProducts.assignAll(products.take(2).toList());
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  void loadCategories() {
    categories.assignAll([
      "Sofas",
      "Tables",
      "Chairs",
      "Beds",
      "Storage",
      "Lighting",
    ]);
  }

  void changePageIndex(int index) {
    currentIndex.value = index;
  }

  void updateCartCount(int count) {
    cartItemCount.value = count;
  }

  void performSearch(String query) {
    searchQuery.value = query;
    // Filter products based on search query
    if (query.isEmpty) {
      loadProducts(); // Reload all products
    } else {
      // Filter products by name or category
      List<Product> filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase());
      }).toList();

      products.assignAll(filteredProducts);
    }
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      // If first category is selected, show all products
      loadProducts();
    } else {
      // Filter products by selected category
      String selectedCategory = categories[index];
      List<Product> filteredProducts = products.where((product) {
        return product.category.toLowerCase().contains(
          selectedCategory.toLowerCase(),
        );
      }).toList();

      products.assignAll(filteredProducts);
    }
  }
}
