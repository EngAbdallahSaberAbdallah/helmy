import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/blocs/auth_bloc/auth_bloc.dart';
import '../../../resources/colors_manager.dart';
import '../models/UserProfile.dart';
import '../../../resources/routes_manager.dart';
import '../../../app/components.dart';
import '../../../app/functions.dart';
import '../../../resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class BtnUpdatePersonalData extends StatelessWidget {
  final GlobalKey<FormState> updatePersonDataFormKey;
  final TextEditingController? rFirstNameController;
  final TextEditingController? rLastNameController;
  final TextEditingController? rEmailController;
  final TextEditingController? rPhoneController;
  final TextEditingController? rAddressController;
  final String areaName;
  final String cityName;
  final UserProfile user;
  final bool isUpdateExistingData;
  final File imgFile;

  const BtnUpdatePersonalData(
      {super.key,
      required this.updatePersonDataFormKey,
      required this.imgFile,
      this.rFirstNameController,
      this.rLastNameController,
      this.rEmailController,
      this.rPhoneController,
      this.rAddressController,
      required this.areaName,
      required this.cityName,
      required this.user,
      required this.isUpdateExistingData});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          loading(context);
        }
        if (state is UpdateProfileSuccess) {
          Navigator.pop(context);

          Navigator.pop(context);
          Get.offNamed(HelmyRoutes.userProfileData);
        }
        if (state is UpdateProfileError) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return DefaultPrimaryButton(color: ColorsManager.primaryDarkPurple,
          buttonText: isUpdateExistingData
              ? tr(StringsManager.save)
              : tr(StringsManager.next),
          showArrow: false,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          onPressed: () {
            if (updatePersonDataFormKey.currentState!.validate()) {
              // updateProfileFunction(context);
            }
          },
          textColor: Colors.white,
        );
      },
    );
  }

  // void updateProfileFunction(BuildContext context) async {

  //   var authBloc = context.read<AuthBloc>();
  //   // var areaId =
  //   // selectedArea!=null ?findAreaIdByName(citiesCubit.citiesData, s  electedArea!):
  //   // int.parse(rAreaIdController.text!);
  //   // var areaId = findAreaIdByName(citiesCubit.citiesData, selectedArea!);
  //   UserData user = UserData(
  //       avatar: imgFile.path,
  //       firstName: rFirstNameController!.text,
  //       lastName: rLastNameController!.text,
  //       email: rEmailController!.text,
  //       address: rAddressController!.text,
  //       phone: rPhoneController!.text,
  //       gender: context.read<GenderCubit>().state.selectedGender.toString() ==
  //               'Gender.male'
  //           ? 'male'
  //           : 'female',
  //       areaId: areaId);
  //   await getIt.get<CacheHelper>().saveCity(cityName);
  //   await getIt.get<CacheHelper>().saveArea(areaName);

  //   authBloc.add(
  //       UpdatePersonalData(user: user, areaName: areaName, cityName: cityName));
  // }
}
