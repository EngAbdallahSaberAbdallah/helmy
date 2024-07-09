// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
// import '../widgets/build_header.dart';
// import '../widgets/build_avatar.dart';
// import '../../../app/components.dart';
// import '../../../resources/colors_manager.dart';
// import '../../../resources/routes_manager.dart';
// import '../../../resources/strings_manager.dart';
// import '../cubit/profile_cubit.dart';
// import '../models/UserProfile.dart';
//
// class UserFullProfile extends StatefulWidget {
//   const UserFullProfile({super.key});
//
//   @override
//   State<UserFullProfile> createState() => _UserFullProfileState();
// }
//
// class _UserFullProfileState extends State<UserFullProfile> {
//   late UserProfile user;
//
//   @override
//   void initState() {
//     super.initState();
//     getUserInfo();
//   }
//
//   getUserInfo() async {
//     BlocProvider.of<ProfileCubit>(context).getProfile();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildBody();
//   }
//
//   Widget _buildBody() {
//     return BlocBuilder<ProfileCubit, ProfileState>(
//       builder: (context, state) {
//         if (state is GetProfileSuccess) {
//           user = state.authResponse;
//           print('lawyer at full profile is $user');
//
//           return ListView(
//             padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 16),
//             children: [
//               _buildLawyerInfo(),
//               const SizedBox(
//                 height: 32,
//               ),
//               _buildLawyerProfileData(),
//               _paddingTop(height: 25),
//               const BuildDivider(height: 0.2),
//               _paddingTop(height: 25),
//             ],
//           );
//         } else {
//           return const Center(
//             child: Loading(
//               color: ColorsManager.primaryDarkPurple,
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   _buildLawyerProfileData() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BuildHeader(
//           name: tr(StringsManager.profileData),
//           onTapIcon: () {
//             Get.toNamed(HelmyRoutes.editUserProfileData, arguments: {
//               'authResponse': user,
//               'isFromUpdateUserData': true
//             });
//           },
//           iconData: IconlyLight.edit_square,
//         ),
//         const SizedBox(
//           height: 30,
//         ),
//         OptionalText(
//             text: tr(StringsManager.phoneNumber),
//             fontSize: 16,
//             textColor: Colors.black,
//             fontWeight: FontWeight.w400),
//         const SizedBox(
//           height: 15,
//         ),
//         OptionalText(
//             text: user.phone.toString(),
//             fontSize: 16,
//             textColor: Colors.black,
//             fontWeight: FontWeight.w400),
//         const SizedBox(
//           height: 10,
//         ),
//         Row(
//           children: [
//             _buildIconInsideContainer(
//                 color: ColorsManager.primaryDarkPurple, iconData: Icons.done),
//             const SizedBox(
//               width: 3,
//             ),
//             OptionalText(
//                 text: tr(StringsManager.phoneNumberVerified),
//                 fontSize: 13,
//                 textColor: ColorsManager.primaryDarkPurple,
//                 fontWeight: FontWeight.w400),
//           ],
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         //  lawyer.email!=null || lawyer.email!.isNotEmpty?  Column(
//         //   mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: [
//         //       OptionalText(
//         //           text: tr(StringsManager.email),
//         //           fontSize: 16,
//         //           fontColor: Colors.black,
//         //           fontWeight: FontWeight.w400),
//         //       const SizedBox(
//         //         height: 15,
//         //       ),
//         //       OptionalText(
//         //           text: lawyer.email.toString(),
//         //           fontSize: 16,
//         //           fontColor: Colors.black,
//         //           fontWeight: FontWeight.w400),
//         //     ],
//         // ): const SizedBox()
//       ],
//     );
//   }
//
//   Widget _buildIconForHeaders({required IconData iconData}) {
//     return Icon(iconData, color: Colors.black, size: 23);
//   }
//
//   Widget _buildImageForHeaders({required String imagePath}) {
//     return SvgPicture.asset(
//       imagePath,
//       width: 24,
//       height: 24,
//     );
//   }
//
//   Widget _buildIconInsideContainer(
//       {required IconData iconData, required Color color}) {
//     return Container(
//       padding: const EdgeInsets.all(1),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(width: 1.5, color: color),
//       ),
//       child: Icon(
//         iconData,
//         color: color,
//         size: 12,
//       ),
//     );
//   }
//
//   Widget _paddingTop({required double height}) {
//     return SizedBox(
//       height: height,
//     );
//   }
//
//   Widget _buildLawyerInfo() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         BuildAvatar(
//           width: 100,
//           height: 100,
//           imgPath: user.avatar != null ? user.avatar.toString() : "",
//           isFile: false,
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             OptionalText(
//                 text: user.fullName.toString(),
//                 fontSize: 20,
//                 textColor: Colors.black,
//                 fontWeight: FontWeight.w400),
//             const SizedBox(
//               width: 4,
//             ),
//             IconButton(
//               onPressed: () {
//                 Get.toNamed(HelmyRoutes.editUserProfileData, arguments: {
//                   'authResponse': user,
//                   'isFromUpdateUserData': true
//                 });
//               },
//               icon: const Icon(
//                 IconlyLight.edit_square,
//                 color: Colors.black,
//                 size: 24,
//               ),
//             )
//           ],
//         ),
//         const SizedBox(
//           width: 12,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Icon(
//               IconlyLight.location,
//               color: Colors.black,
//               size: 16,
//             ),
//             const SizedBox(
//               width: 6,
//             ),
//             OptionalText(
//                 text: "${user.area!.name!.ar} ${user.area!.city!.name!.ar}",
//                 fontSize: 13,
//                 textColor: Colors.black,
//                 fontWeight: FontWeight.w400),
//           ],
//         )
//       ],
//     );
//   }
// }
