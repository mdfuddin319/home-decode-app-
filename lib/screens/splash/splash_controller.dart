import 'dart:async';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../app_manager/local_storage.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoPlayerController;
  var isVideoInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    try {
      // Try to initialize video player with video asset
      // If the video doesn't exist, it will fall back to the timer
      videoPlayerController = VideoPlayerController.asset(
        'assets/video/home_decore_splace_screen_vid.mp4',
      );

      await videoPlayerController.initialize();
      await videoPlayerController.setVolume(0); // Mute the video
      await videoPlayerController.play();
      isVideoInitialized.value = true;

      // Listen to video playback to navigate after video ends
      videoPlayerController.addListener(videoListener);
    } catch (e) {
      print('Video not found or error initializing: $e');
      print('Using fallback timer...');
      // If video fails to load, use the timer fallback
      startTimerFallback();
    }
  }

  void videoListener() {
    if (videoPlayerController.value.isInitialized &&
        videoPlayerController.value.position.inSeconds >=
            videoPlayerController.value.duration.inSeconds - 1) {
      // Video ended (with 1 second buffer), navigate to next screen
      navigateToNextScreen();
    }
  }

  void startTimerFallback() {
    Timer(const Duration(seconds: 3), () {
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    // Remove listener to prevent memory leaks if video was playing
    if (isVideoInitialized.value) {
      videoPlayerController.removeListener(videoListener);
    }

    bool isOnboardingCompleted = LocalStorage.getOnboardingCompleted();

    if (isOnboardingCompleted) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }

  @override
  void onClose() {
    if (isVideoInitialized.value) {
      videoPlayerController.dispose();
    }
    super.onClose();
  }
}

// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// class SplashController extends GetxController {
//   late VideoPlayerController videoPlayerController;

//   var isVideoInitialized = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     initVideo();
//   }

//   void initVideo() async {
//     videoPlayerController = VideoPlayerController.asset(
//       "assets/video/home_decore_splace_screen_vid.mp4",
//     );

//     await videoPlayerController.initialize();

//     isVideoInitialized.value = true;

//     videoPlayerController.setLooping(false);
//     videoPlayerController.play();

//     videoPlayerController.addListener(() {
//       if (videoPlayerController.value.position ==
//           videoPlayerController.value.duration) {
//         Get.offNamed('/home');
//       }
//     });
//   }

//   @override
//   void onClose() {
//     videoPlayerController.dispose();
//     super.onClose();
//   }
// }
