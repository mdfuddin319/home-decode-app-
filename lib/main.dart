import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'screens/product_details_page/controller/product_details_controller.dart';

void main() async {
  await GetStorage.init();
  Get.put(ProductDetailsController());

  runApp(
    GetMaterialApp(
      title: "Home Decor App",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    ),
  );
}
