// import 'package:flutter/material.dart';
// import 'package:meds_alert/core/const/app_colors.dart';
// import 'package:meds_alert/core/util/utils.dart';
// import 'package:news_application_2/configs/color/color.dart';

// Widget imagePickAlert({
//   void Function()? onCameraPressed,
//   void Function()? onGalleryPressed,
// }) {
//   return AlertDialog(
//     backgroundColor: AppColors.lightColor,
//     title: Text(
//       "Pick a source:",
//       style: Utils.googleFontsCustomStyleT('title'),
//     ),
//     content: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           leading: const Icon(Icons.camera_alt),
//           title: Text(
//             "Camera",
//             style: Utils.googleFontsCustomStyleT('body'),
//           ),
//           onTap: onCameraPressed,
//         ),
//         ListTile(
//           leading: const Icon(Icons.image),
//           title: Text(
//             "Gallery",
//             style: Utils.googleFontsCustomStyleT('body'),
//           ),
//           onTap: onGalleryPressed,
//         ),
//       ],
//     ),
//   );
// }
