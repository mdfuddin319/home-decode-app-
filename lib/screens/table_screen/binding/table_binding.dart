import 'package:get/get.dart';
import '../controller/table_controller.dart';

class SofaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableController>(() => TableController());
  }
}
