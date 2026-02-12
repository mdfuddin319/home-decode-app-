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
}
