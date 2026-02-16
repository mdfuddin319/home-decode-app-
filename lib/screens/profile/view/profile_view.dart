import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 👤 Profile Image
            Obx(
              () => CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(controller.profileImage.value),
              ),
            ),

            const SizedBox(height: 12),

            // 👤 Name
            Obx(
              () => Text(
                controller.userName.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 4),

            // 📧 Email
            Obx(
              () => Text(
                controller.email.value,
                style: const TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 16),

            // ✏️ Edit Button
            ElevatedButton(
              onPressed: () {
                _showEditDialog(controller);
              },
              child: const Text("Edit Profile"),
            ),

            const SizedBox(height: 24),

            // 📊 Stats Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat("Orders", controller.orders),
                  _buildStat("Wishlist", controller.wishlist),
                  _buildStat("Reviews", controller.reviews),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 📋 Menu Section
            _buildMenuItem(Icons.shopping_bag, "My Orders"),
            _buildMenuItem(Icons.favorite, "Wishlist"),
            _buildMenuItem(Icons.settings, "Settings"),
            _buildMenuItem(Icons.logout, "Logout"),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String title, RxInt value) {
    return Obx(
      () => Column(
        children: [
          Text(
            value.value.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  void _showEditDialog(ProfileController controller) {
    final nameController = TextEditingController(
      text: controller.userName.value,
    );

    Get.defaultDialog(
      title: "Edit Name",
      content: TextField(
        controller: nameController,
        decoration: const InputDecoration(labelText: "Name"),
      ),
      textConfirm: "Save",
      onConfirm: () {
        controller.updateName(nameController.text);
        Get.back();
      },
      textCancel: "Cancel",
    );
  }
}
