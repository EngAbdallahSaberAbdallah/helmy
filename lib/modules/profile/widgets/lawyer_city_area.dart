// import 'package:flutter/material.dart';

// import '../../../app/components.dart';
// import '../../../resources/colors_manager.dart';
// import '../../../resources/strings_manager.dart';

// class LawyerCityArea extends StatelessWidget {
//   final String cityName;
//   final String areaName;
//   const LawyerCityArea(
//       {super.key, required this.cityName, required this.areaName});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         decoration: BoxDecoration(
//             color: ColorsManager.secondaryCardsBg1,
//             borderRadius: BorderRadius.circular(6)),
//         child: Column(
//           children: [
//             _buildRowData(
//                 title: StringsManager.governorate,
//                 subTitle: cityName,
//                 iconData: Icons.location_on_outlined),
//             _buildSpacer(),
//             _buildDivider(context),
//             _buildSpacer(),
//             _buildRowData(
//                 title: StringsManager.country,
//                 subTitle: areaName,
//                 iconData: Icons.location_city)
//           ],
//         ));
//   }

//   Widget _buildSpacer() {
//     return const SizedBox(
//       height: 16,
//     );
//   }

//   Widget _buildDivider(BuildContext context) {
//     return Container(
//       height: 0.5,
//       width: MediaQuery.of(context).size.width,
//       decoration: const BoxDecoration(
//         color: Colors.black,
//       ),
//     );
//   }

//   Widget _buildRowData(
//       {required String title,
//       required String subTitle,
//       required IconData iconData}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Icon(
//               iconData,
//               size: 24,
//               color: Colors.black,
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             OptionalText(
//                 text: title,
//                 textColor: Colors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400)
//           ],
//         ),
//         OptionalText(
//             text: subTitle,
//             textColor: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.w400)
//       ],
//     );
//   }
// }
