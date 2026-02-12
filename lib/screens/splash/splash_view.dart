// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import '../../core/theme/app_colors.dart';
// import '../../core/values/app_strings.dart';
// import 'splash_controller.dart';

// class SplashView extends StatelessWidget {
//   const SplashView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final SplashController controller = Get.put(SplashController());

//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             // Video Player
//             Obx(() {
//               if (controller.isVideoInitialized.value) {
//                 return Center(
//                   child: AspectRatio(
//                     aspectRatio:
//                         controller.videoPlayerController.value.aspectRatio,
//                     child: VideoPlayer(controller.videoPlayerController),
//                   ),
//                 );
//               } else {
//                 // Fallback UI while video loads
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // App Logo/Icon
//                       Container(
//                         width: 120,
//                         height: 120,
//                         decoration: BoxDecoration(
//                           color: AppColors.whiteColor,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.blackColor.withOpacity(0.1),
//                               blurRadius: 20,
//                               offset: const Offset(0, 10),
//                             ),
//                           ],
//                         ),
//                         child: const Icon(
//                           Icons.chair,
//                           size: 60,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       // App Name
//                       Text(
//                         AppStrings.appName,
//                         style: const TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       // Subtitle
//                       const Text(
//                         'Beautiful Home Decor Ideas',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: AppColors.whiteColor,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                       const SizedBox(height: 50),
//                       // Loading indicator
//                       const CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           AppColors.whiteColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             }),

//             // Overlay with app branding (optional)
//             Container(
//               padding: const EdgeInsets.all(20.0),
//               alignment: Alignment.bottomCenter,
//               child: Text(
//                 '© ${DateTime.now().year} Home Decor',
//                 style: const TextStyle(
//                   color: AppColors.whiteColor,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../core/theme/app_colors.dart';
import 'splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isVideoInitialized.value) {
          return Center(
            child: AspectRatio(
              aspectRatio: controller.videoPlayerController.value.aspectRatio,
              child: VideoPlayer(controller.videoPlayerController),
            ),
          );
        } else {
          // Optional blank/loader while video initializes
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
      }),
    );
  }
}
