// import 'package:flutter/material.dart';
// import 'package:tqneen_lawyer/helpers/cache_helper.dart';
// import 'package:tqneen_lawyer/helpers/services_locator.dart';

// import '../../../app/components.dart';
// import '../../../app/functions.dart';
// import '../../../resources/assets_manager.dart';
// import '../../../resources/colors_manager.dart';
// 

// class DrawerAppBar extends StatefulWidget {
//   const DrawerAppBar({
//     super.key,
//   });

//   @override
//   State<DrawerAppBar> createState() => _DrawerAppBarState();
// }

// class _DrawerAppBarState extends State<DrawerAppBar> {
//   late String name='';
//   late String phone='';

//   @override
//   void initState() {
//     super.initState();
   
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: calcHeight(122, context),
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       width: double.infinity,
//       decoration: const BoxDecoration(color: ColorsManager.primaryBlue),
//       child:  
//       ImageWithTwoText(
//         imageUrl: AssetsManager.networkUrl,
//         field: phone.toString(),
//         name: name.toString(),
//       ),
//     );
//   }
// }
