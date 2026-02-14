// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../core/values/app_strings.dart';
// import '../../core/theme/app_colors.dart';
// import '../../core/theme/text_styles.dart';
// import 'home_controller.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.find<HomeController>();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.surfaceColor,
//         elevation: 0,
//         title: Text(
//           AppStrings.appName,
//           style: TextStyles.headlineSmall.copyWith(
//             color: AppColors.primaryColor,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Stack(
//               children: [
//                 const Icon(
//                   Icons.shopping_cart,
//                   color: AppColors.textColorPrimary,
//                 ),
//                 Obx(
//                   () => Positioned(
//                     right: 0,
//                     top: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: AppColors.errorColor,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 16,
//                         minHeight: 16,
//                       ),
//                       child: Text(
//                         '${controller.cartItemCount.value}',
//                         style: const TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 10,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             onPressed: () => Get.toNamed('/cart'),
//           ),
//           IconButton(
//             icon: const Icon(Icons.person, color: AppColors.textColorPrimary),
//             onPressed: () => Get.toNamed('/profile'),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(child: Column(children: [

//           ],
//         )),
//     );
//   }
// }
