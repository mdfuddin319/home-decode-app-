import 'package:get/get.dart';
import 'package:home_decor_app/screens/beds/controller/beds_controller.dart';

class BedsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BedsController>(() => BedsController());
  }
}
