import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_manager/local_storage.dart';
import '../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();

  var currentPage = 0.obs;
  var isLastPage = false.obs;

  final List<OnboardingItem> onboardingData = [
    OnboardingItem(
      title: 'Discover Beautiful Designs',
      description:
          'Explore our curated collection of home decor items designed to transform your space.',
      imagePath: 'assets/images/onboarding_img1.jpg',
    ),
    OnboardingItem(
      title: 'Easy Shopping Experience',
      description:
          'Browse, select, and purchase your favorite items with our intuitive interface.',
      imagePath: 'assets/images/onboarding_img2.png',
    ),
    OnboardingItem(
      title: 'Transform Your Home',
      description:
          'Create the perfect living space with our premium quality home decor products.',
      imagePath: 'assets/images/onboarding_img3.jpg',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
    isLastPage.value = index == onboardingData.length - 1;
  }

  void next() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void skip() {
    finishOnboarding();
  }

  void finishOnboarding() async {
    await LocalStorage.setOnboardingCompleted(true);
    Get.offAllNamed(AppPages.initial);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}