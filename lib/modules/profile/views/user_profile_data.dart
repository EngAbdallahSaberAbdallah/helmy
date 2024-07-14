// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../auth/widgets/register_fill_name_row.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../auth/cubits/gender_cubit/gender_cubit.dart';
// import '../../auth/cubits/get_cities_cubit/get_cities_cubit.dart';
// import '../../auth/cubits/governorate_and_city_cubit/governorate_and_city_cubit.dart';
// import '../../auth/widgets/gavernorate_and_city_widgets.dart';
// import '../../auth/widgets/phone_and_gender_row.dart';

// import '../widgets/build_avatar.dart';
// import '../../../app/components.dart';
// import '../../../app/functions.dart';
// import '../../../helpers/cache_helper.dart';
// import '../../../helpers/services_locator.dart';
// import '../../../helpers/validation.dart';
// import '../models/UserProfile.dart';
// import '../widgets/btn_update_personal_data.dart';
// import '../../../resources/colors_manager.dart';
// import '../../../resources/strings_manager.dart';
// import 'package:easy_localization/easy_localization.dart';
// import '../../../resources/values_manager.dart';

// int rAreaId = 0;

// TextEditingController rAreaIdController = TextEditingController();

// class UserProfileData extends StatefulWidget {
//   final UserProfile authResponse;
//   final bool isFromUpdateLawyerData;
//   const UserProfileData(
//       {super.key,
//       required this.authResponse,
//       required this.isFromUpdateLawyerData});

//   @override
//   State<UserProfileData> createState() => _UserProfileDataState();
// }

// class _UserProfileDataState extends State<UserProfileData> {
//   TextEditingController? rFirstNameController = TextEditingController();

//   TextEditingController? rLastNameController = TextEditingController();

//   TextEditingController? rEmailController = TextEditingController();

//   TextEditingController? rPhoneController = TextEditingController();

//   TextEditingController? rAddressController = TextEditingController();

//   TextEditingController? rCityController = TextEditingController();
//   TextEditingController? rAreaController = TextEditingController();
//   final _updateProfileFormKey = GlobalKey<FormState>();

//   File imgFile = File("");

//   UserProfile? user;

//   @override
//   void initState() {
//     super.initState();

//     user = widget.authResponse!;

//     getIt.get<CacheHelper>().getPhone().then((value) {
//       rPhoneController!.text = value!;
//     });
//     getIt.get<CacheHelper>().getName().then((value) {
//       rFirstNameController!.text = value!;
//     });
//     getIt.get<CacheHelper>().getLastName().then((value) {
//       rLastNameController!.text = value!;
//     });
//     // getIt.get<CacheHelper>().getEmail().then((value) {
//     //   rEmailController!.text = value! ?? "";
//     // });
//     getIt.get<CacheHelper>().getCity().then((value) {
//       rCityController!.text = value! ?? "";
//     });
//     getIt.get<CacheHelper>().getArea().then((value) {
//       print('value of area is $value');
//       rAreaController!.text = value! ?? "";
//     });
//     getIt.get<CacheHelper>().getAreaId().then((value) {
//       setState(() {
//         rAreaId = value ?? 0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     rFirstNameController?.dispose();
//     rAddressController?.dispose();
//     rEmailController?.dispose();
//     rLastNameController?.dispose();
//     rPhoneController?.dispose();
//     rCityController?.dispose();
//     rAreaController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => GenderCubit(),
//         ),
//         BlocProvider(
//           create: (context) => CityCubit(),
//         ),
//         BlocProvider(
//           create: (context) => AreasCubit(),
//         ),
//         BlocProvider(
//           create: (context) => GetCitiesCubit(getIt.get())..getCities(),
//         ),
//       ],
//       child: Scaffold(
//         // floatingActionButton: const WhatsAppIcon(),
//         appBar: defaultAppBar(
//             appBarTitle: tr(StringsManager.completeProfileData),
//             hasBackBtn: true),
//         body: _buildBody(),
//       ),
//     );
//   }

//   Widget _buildBody() {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         // const SizedBox(
//         //   height: 51,
//         // ),
//         _buildUploadImgWidget(),
//         const SizedBox(
//           height: 51,
//         ),
//         OptionalText(
//             text: tr(StringsManager.personalDataInfo),
//             fontSize: 18,
//             textColor: Colors.black,
//             fontWeight: FontWeight.w700),
//         const SizedBox(
//           height: 31,
//         ),
//         _buildUserInfoFields()
//       ],
//     );
//   }

//   //upload image
//   Widget _buildUploadImgWidget() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         BuildAvatar(
//             width: 100,
//             height: 100,
//             imgPath: imgFile.path != ""
//                 ? imgFile.path.toString()
//                 : user!.avatar != null
//                     ? user!.avatar.toString()
//                     : "",
//             isFile: imgFile.path != "" ? true : false),
//         const SizedBox(
//           height: 12,
//         ),
//         GestureDetector(
//           onTap: () async {
//             final pickedFile =
//                 await ImagePicker().pickImage(source: ImageSource.gallery);
//             if (pickedFile != null) {
//               var result = await compressFile(File(pickedFile.path));
//               setState(() {
//                 File file = File(pickedFile.path);

//                 file.writeAsBytesSync(result);
//                 imgFile = file;
//               });
//             }
//           },
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Icon(
//                 Icons.camera_alt_outlined,
//                 color: Colors.black,
//                 size: 20,
//               ),
//               const SizedBox(
//                 width: 8,
//               ),
//               OptionalText(
//                   text: tr(StringsManager.changeImageProfile),
//                   fontSize: 16,
//                   textColor: Colors.black,
//                   fontWeight: FontWeight.w400)
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   // fields for user info
//   Widget _buildUserInfoFields() {
//     return Form(
//         key: _updateProfileFormKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             RegisterFillNameRow(
//               firstController: rFirstNameController,
//               lastController: rLastNameController,
//             ),
//             PhoneAndGenderRow(
//                 phoneController: rPhoneController, isReadOnly: false),
//             const OptionalTextWithHint(
//               title: StringsManager.email,
//             ),
//             CustomTextFormField(
//               hint: StringsManager.enterEmail,
//               heightOfTextFormField: 51,
//               textInputType: TextInputType.emailAddress,
//               controller: rEmailController,
//               borderColor: ColorsManager.borderGrey,
//               onChanged: (value) {},
//               formatter: [
//                 FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
//               ],
//               validator: (value) => value!.isEmpty
//                   ? null
//                   : ValidationHelper.validateEmail(context, value),
//               sufixIconBackground: Theme.of(context).dividerColor,
//             ),
//             CityAndAreaRow(
//               cityName:
//                   rCityController!.text.isNotEmpty ? rCityController!.text : "",
//               areaName:
//                   rAreaController!.text.isNotEmpty ? rAreaController!.text : "",
//               countryIdController: rAreaIdController,
//             ),
//             const OptionalTextWithHint(
//               title: StringsManager.address,
//               bottomPadding: AppSize.s13,
//               topPadding: AppSize.s31,
//             ),
//             CustomTextFormField(
//               hint: StringsManager.enterAddress,
//               borderColor: ColorsManager.borderGrey,
//               heightOfTextFormField: 51,
//               onChanged: (value) {},
//               controller: rAddressController,
//               sufixIconBackground: Theme.of(context).dividerColor,
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             BtnUpdatePersonalData(
//               updatePersonDataFormKey: _updateProfileFormKey,
//               imgFile: imgFile,
//               rAddressController: rAddressController!,
//               rEmailController: rEmailController!,
//               rFirstNameController: rFirstNameController!,
//               rLastNameController: rLastNameController!,
//               rPhoneController: rPhoneController!,
//               areaName: rAreaController!.text,
//               cityName: rCityController!.text,
//               user: user!,
//               isUpdateExistingData: widget.isFromUpdateLawyerData,
//             ),
//           ],
//         ));
//   }
// }
