import 'package:get/get.dart';

import '../controller/lighting_controller.dart';

class LightingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LightingController>(() => LightingController());
  }
}
