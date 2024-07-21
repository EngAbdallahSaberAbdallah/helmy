// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class DrawerCustomButton extends StatelessWidget {
//   final String title;
//   final IconData? icon;
//   final VoidCallback onTap;
//   final String? svgImage;
//   final String? numberGuardians;
//   final Color containerColor;
//   final Color textColor;
//   final double fontSize;
//   final FontWeight fontWeight;

//   const DrawerCustomButton({
//     super.key,
//     required this.title,
//     required this.onTap,
//     this.icon,
//     this.svgImage,
//     this.numberGuardians,
//     this.containerColor = ColorsManager.primaryDarkPurple,
//     this.textColor = ColorsManager.primaryOffWhite,
//     this.fontSize = 18,
//     this.fontWeight = FontWeight.w700,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         foregroundColor: ColorsManager.primaryDarkPurple.withOpacity(0.8),
//         shadowColor: ColorsManager.primaryDarkPurple.withOpacity(0.8),
//         minimumSize: Size(double.infinity, calcHeight(56, context)),
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(6)),
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         backgroundColor: ColorsManager.trans,
//       ),
//       onPressed: onTap,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           svgImage == null
//               ? Icon(
//                   icon,
//                   size: 24.h,
//                   color: ColorsManager.black,
//                 )
//               : SvgPicture.asset(
//                   svgImage!,
//                   width: calcWidth(25, context),
//                   height: calcHeight(25, context),
//                 ),
//           const SizedBox(
//             width: 8,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 5.0),
//               child: AutoSizeText(
//                 title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleMedium
//                     ?.copyWith(fontSize: 18),
//                 minFontSize: 10,
//                 stepGranularity: 10,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           numberGuardians == null
//               ? const SizedBox()
//               : Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   alignment: AlignmentDirectional.center,
//                   height: 28,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6),
//                       color: containerColor),
//                   child: Text(
//                     numberGuardians!,
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                         color: textColor,
//                         fontSize: fontSize,
//                         fontWeight: fontWeight),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
// }
