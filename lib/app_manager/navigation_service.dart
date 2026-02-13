import 'package:get/get.dart';

class NavigationService {
  static Future<void> navigateTo(String routeName, {Object? arguments}) async {
    await Get.toNamed(routeName, arguments: arguments);
  }

  static Future<void> navigateWithArguments(
    String routeName,
    Object arguments,
  ) async {
    await Get.toNamed(routeName, arguments: arguments);
  }

  static Future<void> navigateReplacement(
    String routeName, {
    Object? arguments,
  }) async {
    await Get.offNamed(routeName, arguments: arguments);
  }

  static Future<void> navigateAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) async {
    await Get.offAllNamed(routeName, arguments: arguments);
  }

  static void goBack() {
    Get.back();
  }

  static void goBackWithResult(dynamic result) {
    Get.back(result: result);
  }

  static Future<void> navigateWithTransition(
    String routeName, {
    Object? arguments,
  }) async {
    await Get.toNamed(routeName, arguments: arguments);
  }
}
