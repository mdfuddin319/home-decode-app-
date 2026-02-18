import 'package:get/get.dart';

import '../controller/storage_controller.dart';

class StorageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageController>(() => StorageController());
  }
}
