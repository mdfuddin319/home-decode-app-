import 'package:get/get.dart';
import '../controller/table_controller.dart';

class TableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableController>(() => TableController());
  }
}
