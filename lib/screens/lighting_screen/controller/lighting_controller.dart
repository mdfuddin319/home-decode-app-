import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/models/product_model.dart';

class LightingController extends GetxController {
  final PageController pageController = PageController(viewportFraction: 0.92);
  final RxInt currentBanner = 0.obs;

  final banners = <String>[
    'assets/images/onboarding_img1.jpg',
    'assets/images/onboarding_img2.png',
    'assets/images/onboarding_img3.jpg',
  ].obs;

  final suggested = <Product>[].obs;
  final superDeals = <Product>[].obs;

  Timer? _autoTimer;

  @override
  void onInit() {
    super.onInit();
    _loadSampleData();
    _startAutoSlide();
    pageController.addListener(_pageListener);
  }

  void _pageListener() {
    final page = pageController.page?.round() ?? 0;
    if (currentBanner.value != page) currentBanner.value = page;
  }

  void _loadSampleData() {
    suggested.assignAll([
      Product(
        id: 1,
        name: 'Comfy Sofa',
        price: 249.99,
        image: 'assets/images/light1.png',
        rating: 4.6,
        description: 'Modern comfortable sofa',
        category: 'Sofa',
      ),
      Product(
        id: 2,
        name: 'Elegant Chair',
        price: 89.00,
        image: 'assets/images/light4.png',
        rating: 4.3,
        description: 'Stylish chair',
        category: 'Chair',
      ),
    ]);

    superDeals.assignAll([
      Product(
        id: 11,
        name: 'Pendant Lamp',
        price: 49.99,
        image: 'assets/images/light3.png',
        rating: 4.1,
        description: 'Warm lighting',
        category: 'Lighting',
      ),
    ]);
  }

  void _startAutoSlide() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (pageController.hasClients && banners.isNotEmpty) {
        final next = (currentBanner.value + 1) % banners.length;
        pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    _autoTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
