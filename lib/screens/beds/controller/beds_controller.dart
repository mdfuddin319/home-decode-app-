import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/base_controller.dart';
import '../../../core/models/product_model.dart';
import '../../../apihelper/repositories/api_repository.dart';

class BedsController extends BaseController {
  final ApiRepository _apiRepository = ApiRepository();

  final PageController featurePageController = PageController();
  final RxInt currentFeatureIndex = 0.obs;

  var sofaProducts = <Product>[].obs;
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

  final List<Map<String, String>> featureBanners = [
    {
      "image": "assets/images/beds7.png",
      "title": "Luxury Comfort",
      "desc": "Experience premium quality beds",
    },
    {
      "image": "assets/images/beds8.png",
      "title": "Modern Design",
      "desc": "Stylish beds for your home",
    },
    {
      "image": "assets/images/beds9.png",
      "title": "Best Deals",
      "desc": "Grab beds at great prices",
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loadbeds();
    _autoSlideFeatures();
  }

  void _autoSlideFeatures() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (featurePageController.hasClients) {
        currentFeatureIndex.value++;

        if (currentFeatureIndex.value >= featureBanners.length) {
          currentFeatureIndex.value = 0;
        }

        featurePageController.animateToPage(
          currentFeatureIndex.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void loadbeds() async {
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

      sofaProducts.assignAll(sofas);
    } catch (e) {
      setError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter(int index) {
    selectedFilter.value = index;
    loadbeds(); // Reload with filter
  }

  void applySort(String sortOption) {
    sortBy.value = sortOption;

    switch (sortOption) {
      case 'price-low':
        sofaProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price-high':
        sofaProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        sofaProducts.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'newest':
        sofaProducts.sort((a, b) => b.id.compareTo(a.id));
        break;
      default:
        // Popular - keep original order
        break;
    }
  }

  void refreshSofas() {
    loadbeds();
  }

  int get totalSofas => sofaProducts.length;

  double get averagePrice {
    if (sofaProducts.isEmpty) return 0;
    return sofaProducts.fold(0.0, (sum, product) => sum + product.price) /
        sofaProducts.length;
  }
}
