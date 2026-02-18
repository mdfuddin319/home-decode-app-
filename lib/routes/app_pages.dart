import 'package:get/get.dart';
import 'package:home_decor_app/screens/lighting_screen/binding/lighting_binding.dart';
import 'package:home_decor_app/screens/lighting_screen/view/lighting_view.dart';
import 'package:home_decor_app/screens/onboarding/onboarding_binding.dart';
import 'package:home_decor_app/screens/onboarding/onboarding_view.dart';
import '../screens/beds/binding/beds_binding.dart';
import '../screens/beds/view/beds_screen.dart';
import '../screens/chair_screen/binding/chair_binding.dart';
import '../screens/chair_screen/view/chair_view.dart';
import '../screens/home/home_view.dart';
import '../screens/home/home_binding.dart';
import '../screens/product/product_view.dart';
import '../screens/product/product_binding.dart';
import '../screens/cart/cart_view.dart';
import '../screens/cart/cart_binding.dart';
import '../screens/profile/binding/profile_binding.dart';
import '../screens/profile/view/profile_view.dart';
import '../screens/storage_screen/binding/storage_binding.dart';
import '../screens/storage_screen/view/storage_view.dart';
import '../screens/table_screen/binding/table_binding.dart';
import '../screens/sofa_screen/binding/sofa_binding.dart';
import '../screens/sofa_screen/view/sofa_screen.dart';
import '../screens/table_screen/view/table_view.dart';
import '../wishlist/binding/wishlist_binding.dart';
import '../wishlist/view/wishlist_view.dart';

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
    GetPage(
      name: AppRoutes.lighting,
      page: () => const LightingView(),
      binding: LightingBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.beds,
      page: () => const BedsScreen(),
      binding: BedsBinding(),
    ),
    GetPage(
      name: AppRoutes.chair,
      page: () => const ChairView(),
      binding: ChairBinding(),
    ),
    GetPage(
      name: AppRoutes.storage,
      page: () => const StorageView(),
      binding: StorageBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
