// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../resources/strings_manager.dart';
// 
// import 'about_app_buttons.dart';
// import 'drawer_custom_button.dart';
// import 'drawer_first_buttons.dart';
// import 'drawer_with_logo.dart';
// import 'on_store_buttons.dart';

// class DrawerButtonsListView extends StatelessWidget {
//   const DrawerButtonsListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: ListView(
//         padding: const EdgeInsets.symmetric(
//             horizontal: 16, vertical: 20),
//         children: [
//           const DrawerFirstButtons(),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             'عن تقنين',
//             style: Theme.of(context)
//                 .textTheme
//                 .displayMedium
//                 ?.copyWith(fontSize: 24),
//           ),
//           const AboutAppButtons(),
//           Text(
//             'على المتجر',
//             style: Theme.of(context)
//                 .textTheme
//                 .displayMedium
//                 ?.copyWith(fontSize: 24),
//           ),
//           const OnStoreButtons(),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             'نسخة التطبيق 1.0.0',
//             textAlign: TextAlign.center,
//             style: Theme.of(context)
//                 .textTheme
//                 .headlineSmall
//                 ?.copyWith(fontSize: 13),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           const DrawerWithLogo()
//         ],
//       ),
//     );
//   }
// }
