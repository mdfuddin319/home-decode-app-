import 'package:get/get.dart';
import 'package:home_decor_app/screens/table_screen/controller/table_controller.dart';

class TableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableController>(() => TableController());
  }
}
