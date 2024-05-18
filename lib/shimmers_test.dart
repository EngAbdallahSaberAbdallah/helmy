// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../app/functions.dart';
// import '../../../../resources/values_manager.dart';
// import '../../../app/components.dart';
// import '../../../resources/colors_manager.dart';
// import '../../../resources/strings_manager.dart';
//
// class CurrentReservationsItem extends StatelessWidget {
//   const CurrentReservationsItem({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: calcWidth(291, context),
//       padding: const EdgeInsets.only(left: AppSize.s10, right: AppSize.s10),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(AppSize.s8),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Icon(Icons.check_circle_outline,
//                   color: ColorsManager.primaryBlue, size: 20),
//               const SizedBox(width: AppSize.s6),
//               AutoSizeText(
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 'تمت قبول طلب استشارتك بنجاح',
//                 style: Theme.of(context).textTheme.displayMedium?.copyWith(
//                   color: ColorsManager.primaryBlue,
//                 ),
//                 maxFontSize: AppSize.s11,
//                 minFontSize: AppSize.s8,
//                 presetFontSizes: const [
//                   AppSize.s11,
//                   AppSize.s10,
//                   AppSize.s8,
//                 ],
//               ),
//               const Spacer(),
//               Text(
//                 '20:00 دقيقة',
//                 style: Theme.of(context).textTheme.displayMedium?.copyWith(
//                     fontSize: AppSize.s12, color: ColorsManager.primaryBlue),
//               )
//             ],
//           ),
//           SizedBox(height: calcHeight(AppSize.s11, context),),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: AppSize.s14, horizontal: AppSize.s15),
//             decoration: BoxDecoration(
//               border: Border.all(color: ColorsManager.primaryDark80),
//               borderRadius: BorderRadius.circular(AppSize.s8),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: AlignmentDirectional.bottomEnd,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(AppSize.s4),
//                     child: Image.network(
//                       '',
//                       fit: BoxFit.cover,
//                       height: calcHeight(AppSize.s50, context),
//                       width: calcWidth(AppSize.s50, context),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: AppSize.s14,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         '',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context)
//                             .textTheme
//                             .displayMedium
//                             ?.copyWith(fontSize: AppSize.s12),
//                       ),
//                       const SizedBox(
//                         height: AppSize.s8,
//                       ),
//                       Text(
//                         '',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: calcHeight(AppSize.s11, context),),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 StringsManager.dateApplication,
//                 style: Theme.of(context).textTheme.displayMedium?.copyWith(
//                   fontSize: AppSize.s12,),
//               ),
//               const SizedBox(width: AppSize.s6),
//               Text(
//                 '08-10-2023',
//                 style: Theme.of(context).textTheme.displayMedium?.copyWith(
//                   fontSize: AppSize.s12,),
//               ),
//               const SizedBox(width: AppSize.s6),
//               Text(
//                 '1:52 مساءً',
//                 style: Theme.of(context).textTheme.displayMedium?.copyWith(
//                   fontSize: AppSize.s12,),
//               )
//             ],
//           ),
//           SizedBox(height: calcHeight(AppSize.s11, context),),
//           Row(
//             children: [
//               Expanded(
//                 child: DefaultPrimaryButton(
//                   textColor: Theme.of(context).primaryColorDark,
//                   buttonText: StringsManager.completePayment,
//                   fontWeight: FontWeight.w400,
//                   onPressed: () {},
//                   textSize: AppSize.s13,
//                   showArrow: true,
//                 ),
//               ),
//               const SizedBox(
//                 width: AppSize.s15,
//               ),
//               Expanded(
//                   child: DefaultOutlineButton(
//                     borderColor: Theme.of(context).primaryColorLight,
//                     textColor: Theme.of(context).primaryColorLight,
//                     buttonText: StringsManager.bookingDetails,
//                     onPressed: () {},
//                   ))
//             ],
//           ),
//           const SizedBox(
//             height: AppSize.s8,
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// // class CurrentReservationsStatusAndTime extends StatelessWidget {
// //   const CurrentReservationsStatusAndTime({
// //     super.key,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       mainAxisAlignment: MainAxisAlignment.start,
// //       children: [
// //         const Icon(Icons.check_circle_outline,
// //             color: ColorsManager.primaryBlue, size: 20),
// //         const SizedBox(width: AppSize.s6),
// //         AutoSizeText(
// //           maxLines: 2,
// //           overflow: TextOverflow.ellipsis,
// //           textAlign: TextAlign.center,
// //           'تمت قبول طلب استشارتك بنجاح',
// //           style: Theme.of(context).textTheme.displayMedium?.copyWith(
// //             color: ColorsManager.primaryBlue,
// //           ),
// //           maxFontSize: AppSize.s11,
// //           minFontSize: AppSize.s8,
// //           presetFontSizes: const [
// //             AppSize.s11,
// //             AppSize.s10,
// //             AppSize.s8,
// //           ],
// //         ),
// //         const Spacer(),
// //         Text(
// //           '20:00 دقيقة',
// //           style: Theme.of(context).textTheme.displayMedium?.copyWith(
// //               fontSize: AppSize.s12, color: ColorsManager.primaryBlue),
// //         )
// //       ],
// //     );
// //   }
// // }
//
// // class CurrentReservationsApplicationDateRow extends StatelessWidget {
// //   const CurrentReservationsApplicationDateRow({
// //     super.key,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       mainAxisAlignment: MainAxisAlignment.start,
// //       children: [
// //         Text(
// //           StringsManager.dateApplication,
// //           style: Theme.of(context).textTheme.displayMedium?.copyWith(
// //             fontSize: AppSize.s12,),
// //         ),
// //         const SizedBox(width: AppSize.s6),
// //         Text(
// //           '08-10-2023',
// //           style: Theme.of(context).textTheme.displayMedium?.copyWith(
// //             fontSize: AppSize.s12,),
// //         ),
// //         const SizedBox(width: AppSize.s6),
// //         Text(
// //           '1:52 مساءً',
// //           style: Theme.of(context).textTheme.displayMedium?.copyWith(
// //             fontSize: AppSize.s12,),
// //         )
// //       ],
// //     );
// //   }
// // }
