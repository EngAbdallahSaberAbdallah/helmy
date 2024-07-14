import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helmy_project/app/functions.dart';
import 'package:helmy_project/helpers/cache_helper.dart';
import 'package:helmy_project/helpers/services_locator.dart';
import 'package:helmy_project/modules/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:helmy_project/modules/auth/cubits/get_cities_cubit/get_cities_cubit.dart';
import 'package:helmy_project/modules/auth/cubits/governorate_and_city_cubit/governorate_and_city_cubit.dart';
import 'package:helmy_project/modules/auth/views/login_view.dart';
import 'package:helmy_project/modules/auth/widgets/gavernorate_and_city_widgets.dart';
import 'package:helmy_project/modules/profile/cubit/profile_cubit.dart';
import 'package:helmy_project/modules/profile/widgets/profile_layout.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/resources/routes_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import '../../../app/components.dart';
import '../../auth/widgets/build_header_image.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String? image = '';
  late String? name = '';
  late String? email = '';
  late String? userCountryId = '';

  final userNameController = TextEditingController();
  final rCountryIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetCitiesCubit>().getCities();
    getUserInfo();
  }

  @override
  void dispose() {
    userNameController.dispose();
    rCountryIdController.dispose();
    super.dispose();
  }

  void getUserInfo() async {
    image = await getIt.get<CacheHelper>().getAvatar() ?? "";
    name = await getIt.get<CacheHelper>().getName() ?? "";
    email = await getIt.get<CacheHelper>().getEmail() ?? "";
    userCountryId = await getIt.get<CacheHelper>().getAreaId().toString() ?? "";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ProfileLayout(
        child: Column(
      children: [
        _buildField(
            title: tr(StringsManager.name), controller: userNameController),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.w),
            child: CityAndAreaRow(countryIdController: rCountryIdController)),
        SizedBox(
          height: 25.h,
        ),

        _buildSubmitBtn(),
        // _buildCard(
        //     title: tr(StringsManager.changePassword),
        //     icon: Icons.edit,
        //     cardBackgroundColor: ColorsManager.buttonDarkColor,
        //     titleColor: ColorsManager.white,
        //     hasArrow: false,
        //     onPressed: () {}),
      ],
    ));
  }

  Widget _buildSubmitBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 54.h,
      margin: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.w),
      child: CustomElevatedButton(
        onPressed: () {
          if (rCountryIdController.text.isNotEmpty) {
            var citiesCubit = context.read<GetCitiesCubit>();
            var selectedCountry = context.read<CityCubit>().state;
            var countryId =
                findAreaIdByName(citiesCubit.citiesData, selectedCountry!);

            context.read<ProfileCubit>().updateProfile(
                name: userNameController.text.isNotEmpty
                    ? userNameController.text
                    : name!,
                countryId: rCountryIdController.text.isNotEmpty
                    ? countryId.toString()
                    : userCountryId!);
          } else {
            context.read<ProfileCubit>().updateProfile(
                name: userNameController.text.isNotEmpty
                    ? userNameController.text
                    : name!,
                countryId: userCountryId!);
          }
        },
        btnBackgroundColor: ColorsManager.primaryDarkPurple,
        btnName: tr(StringsManager.save),
        btnNameColor: Colors.white,
      ),
    );
  }

  Widget _buildField(
      {required String title, required TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.w),
      child: CustomTextFormField(
          controller: controller,
          hint: title,
          onChanged: (value) {},
          validator: (value) {
            if (value!.isEmpty) {
              return tr(StringsManager.enterDreamName);
            }
            return null;
          },
          sufixIconBackground: ColorsManager.white,
          borderColor: ColorsManager.primaryDarkPurple,
          heightOfTextFormField: 54),
    );
  }

  Widget _buildCard(
      {required String title,
      required IconData icon,
      required Color cardBackgroundColor,
      required Color titleColor,
      required bool hasArrow,
      required dynamic onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48.h,
        margin: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 24.w),
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
        decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.sp,
                  offset: const Offset(0, 5),
                  spreadRadius: 0.5)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: titleColor, size: 22.sp),
                SizedBox(width: 10.sp),
                Text(title,
                    style: getRegularStyle(
                      color: titleColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
            if (hasArrow)
              Icon(Icons.arrow_forward_ios,
                  color: ColorsManager.white, size: 20.sp)
          ],
        ),
      ),
    );
  }
}
