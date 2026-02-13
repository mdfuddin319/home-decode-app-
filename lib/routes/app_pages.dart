import 'package:get/get.dart';
import 'package:home_decor_app/screens/onboarding/onboarding_binding.dart';
import 'package:home_decor_app/screens/onboarding/onboarding_view.dart';
import '../screens/home/home_view.dart';
import '../screens/home/home_binding.dart';
import '../screens/product/product_view.dart';
import '../screens/product/product_binding.dart';
import '../screens/cart/cart_view.dart';
import '../screens/cart/cart_binding.dart';
import '../screens/wishlist/view/wishlist_view.dart';
import '../screens/wishlist/binding/wishlist_binding.dart';

part 'app_routes.dart';

abstract class AppPages {
  static const String initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.initial,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.product,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
  ];
}
