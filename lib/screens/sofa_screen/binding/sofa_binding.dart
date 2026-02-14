import 'package:get/get.dart';
import '../controller/sofa_controller.dart';

class SofaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SofaController>(() => SofaController());
  }
}
