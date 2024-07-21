// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:helmy_project/resources/colors_manager.dart';
// import 'package:helmy_project/resources/routes_manager.dart';
// import 'package:helmy_project/resources/strings_manager.dart';
// import '../../../app/functions.dart';
// import '../../../resources/assets_manager.dart';
// 
// import '../cubits/bottom_nav_bar_cubit.dart';

// class StartViewAppBar extends StatelessWidget {
//   final String title;
//   final String imageUrl;

//   const StartViewAppBar({
//     super.key,
//     required this.title,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     var cubit = context.read<BottomNavBarCubit>();
//     return Container(
//       height: calcHeight(73, context),
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: cubit.bottomNavigationBarCurrentIndex != 4
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SvgPicture.asset(
//                   AssetsManager.tqneenLogoWithTextLight,
//                   height: calcHeight(48, context),
//                   width: calcWidth(44.4, context),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         tr(StringsManager.home),
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleSmall
//                             ?.copyWith(fontSize: 16),
//                         maxLines: 1,
//                         textAlign: TextAlign.start,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         title,
//                         style: Theme.of(context)
//                             .textTheme
//                             .displayMedium
//                             ?.copyWith(fontSize: 18),
//                         maxLines: 2,
//                         textAlign: TextAlign.start,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                     ],
//                   ),
//                 ),
//                 InkWell(
//                     onTap: () =>
//                         Navigator.pushNamed(context, AzkarRoutes.drawerRoute),
//                     borderRadius: BorderRadius.circular(100),
//                     child: ClipOval(
//                       child: Container(
//                         height: calcHeight(48, context),
//                         width: calcWidth(48, context),
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: imageUrl != null || imageUrl.isEmpty
//                             ? SvgPicture.asset(
//                                 AssetsManager.accountImage,
//                                 fit: BoxFit.cover,
//                                 height: calcHeight(74, context),
//                                 width: calcWidth(74, context),
//                               )
//                             : Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                                 height: calcHeight(74, context),
//                                 width: calcWidth(74, context),
//                                 loadingBuilder: (BuildContext context,
//                                     Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return Center(
//                                     child: Loading(
//                                       color: ColorsManager.primaryBlue,
//                                       value:
//                                           loadingProgress.expectedTotalBytes !=
//                                                   null
//                                               ? loadingProgress
//                                                       .cumulativeBytesLoaded /
//                                                   loadingProgress
//                                                       .expectedTotalBytes!
//                                               : null,
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                     )),
//               ],
//             )
//           : Container(
//               height: calcHeight(48, context),
//               alignment: AlignmentDirectional.center,
//               child: Text(
//                 title,
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 maxLines: 1,
//                 textAlign: TextAlign.center,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//     );
//   }
// }
