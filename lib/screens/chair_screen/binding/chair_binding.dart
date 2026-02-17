import 'package:get/get.dart';
import 'package:home_decor_app/screens/chair_screen/controller/chair_controller.dart';

class ChairBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChairController>(() => ChairController());
  }
}
