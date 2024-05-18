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
//     this.fontSize = AppSize.s18,
//     this.fontWeight = FontWeight.w700,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         foregroundColor: ColorsManager.primaryDarkPurple.withOpacity(0.8),
//         shadowColor: ColorsManager.primaryDarkPurple.withOpacity(0.8),
//         minimumSize: Size(double.infinity, calcHeight(AppSize.s56, context)),
//         elevation: AppSize.s0,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(AppSize.s6)),
//         padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
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
//                   size: AppSize.s24.h,
//                   color: ColorsManager.black,
//                 )
//               : SvgPicture.asset(
//                   svgImage!,
//                   width: calcWidth(AppSize.s25, context),
//                   height: calcHeight(AppSize.s25, context),
//                 ),
//           const SizedBox(
//             width: AppSize.s8,
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 5.0),
//               child: AutoSizeText(
//                 title,
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleMedium
//                     ?.copyWith(fontSize: AppSize.s18),
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
//                   padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
//                   alignment: AlignmentDirectional.center,
//                   height: AppSize.s28,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(AppSize.s6),
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
