import 'package:get/get.dart';

class BaseController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  void setError(String message) {
    errorMessage.value = message;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
