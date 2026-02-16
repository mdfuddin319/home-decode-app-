import 'package:get/get.dart';
import '../screens/sofa_screen/binding/sofa_binding.dart';
import '../screens/sofa_screen/view/sofa_screen.dart';
import '../screens/splash/splash_view.dart';
import '../screens/splash/splash_binding.dart';
import '../screens/onboarding/onboarding_view.dart';
import '../screens/onboarding/onboarding_binding.dart';
import '../screens/home/home_view.dart';
import '../screens/home/home_binding.dart';
import '../screens/product/product_view.dart';
import '../screens/product/product_binding.dart';
import '../screens/cart/cart_view.dart';
import '../screens/cart/cart_binding.dart';
import '../screens/table_screen/binding/table_binding.dart';
import '../screens/table_screen/view/table_screen.dart';
import '../screens/wishlist/view/wishlist_view.dart';
import '../screens/wishlist/binding/wishlist_binding.dart';

part 'app_routes.dart';

abstract class AppPages {
  static const String initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
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
    GetPage(
      name: AppRoutes.sofa,
      page: () => const SofaView(),
      binding: SofaBinding(),
    ),
    GetPage(
      name: AppRoutes.table,
      page: () => const TableView(),
      binding: TableBinding(),
    ),
  ];
}
