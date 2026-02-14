import 'package:get/get.dart';
import '../../../core/base/base_controller.dart';
import '../../../core/models/product_model.dart';
import '../../../apihelper/repositories/api_repository.dart';

class TableController extends BaseController {
  final ApiRepository _apiRepository = ApiRepository();

  var tableProducts = <Product>[].obs;
  var isLoading = false.obs;
  var selectedFilter = 0.obs;
  var sortBy = 'popular'.obs;

  // Filter options
  final List<String> filterOptions = [
    'All',
    'Modern',
    'Classic',
    'Sectional',
    'L-Shaped',
    'Recliner',
    'Chaise',
  ];

  // Sort options
  final List<String> sortOptions = [
    'popular',
    'price-low',
    'price-high',
    'rating',
    'newest',
  ];

  @override
  void onInit() {
    super.onInit();
    loadTables();
  }

  void loadTables() async {
    try {
      isLoading.value = true;
      final allProducts = await _apiRepository.getProducts();

      // Filter products that contain 'sofa' in category or name
      final sofas = allProducts.where((product) {
        final categoryLower = product.category.toLowerCase();
        final nameLower = product.name.toLowerCase();
        return categoryLower.contains('sofa') ||
            nameLower.contains('sofa') ||
            categoryLower.contains('furniture') && categoryLower.isNotEmpty;
      }).toList();

      tableProducts.assignAll(sofas);
    } catch (e) {
      setError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter(int index) {
    selectedFilter.value = index;
    loadTables(); // Reload with filter
  }

  void applySort(String sortOption) {
    sortBy.value = sortOption;

    switch (sortOption) {
      case 'price-low':
        tableProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price-high':
        tableProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        tableProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'newest':
        tableProducts.sort((a, b) => b.id.compareTo(a.id));
        break;
      default:
        // Popular - keep original order
        break;
    }
  }

  void refreshTables() {
    loadTables();
  }

  int get totalSofas => tableProducts.length;

  double get averagePrice {
    if (tableProducts.isEmpty) return 0;
    return tableProducts.fold(0.0, (sum, product) => sum + product.price) /
        tableProducts.length;
  }
}
