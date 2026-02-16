import 'package:get/get.dart';

class ProfileController extends GetxController {
  var userName = "Md Farhanuddin".obs;
  var email = "farhan@example.com".obs;
  var profileImage =
      "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde".obs;

  var orders = 12.obs;
  var wishlist = 5.obs;
  var reviews = 3.obs;

  void updateName(String name) {
    userName.value = name;
  }
}
