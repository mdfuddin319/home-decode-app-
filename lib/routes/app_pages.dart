import 'package:get/get.dart';
import '../screens/home/home_view.dart';
import '../screens/home/home_binding.dart';
import '../screens/product/product_view.dart';
import '../screens/product/product_binding.dart';
import '../screens/cart/cart_view.dart';
import '../screens/cart/cart_binding.dart';

part 'app_routes.dart';

abstract class AppPages {
  static const String initial = AppRoutes.initial;

  static final routes = [
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
  ];
}
