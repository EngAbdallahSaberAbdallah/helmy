import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/helpers/snackbar_helper.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:helmy_project/modules/dream/cubits/add_dream/cubit/add_dream_cubit.dart';
import 'package:helmy_project/modules/dream/cubits/draw_bottom_btns/dream_bottom_btn_cubit.dart';
import 'package:helmy_project/modules/dream/model/dream.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class DreamBottomButton extends StatefulWidget {
  DreamBottomButton({super.key});

  @override
  State<DreamBottomButton> createState() => _DreamBottomButtonState();
}

class _DreamBottomButtonState extends State<DreamBottomButton> {
  final DreamController dreamController = Get.find<DreamController>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamBottomBtnCubit, DreamBottomBtnState>(
        builder: (navContext, state) {
      DreamBottomBtnCubit dreamBottomBtnCubit =
          navContext.read<DreamBottomBtnCubit>();
      return Container(
          height: 82.sp,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16.sp),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: ColorsManager.primaryDarkPurple,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: dreamBottomBtnCubit.bottomCurrentIndex == 0
              ? SizedBox(
                  height: 48.sp,
                  child: _buildNextButton(
                      dreamBottomBtnCubit: dreamBottomBtnCubit))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 48.sp,
                          child: _buildBackButton(
                              dreamBottomBtnCubit: dreamBottomBtnCubit)),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 48.sp,
                          child: _buildNextButton(
                              dreamBottomBtnCubit: dreamBottomBtnCubit)),
                    )
                  ],
                ));
    });
  }

  Widget _buildBackButton({required DreamBottomBtnCubit dreamBottomBtnCubit}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.buttonDarkColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        onPressed: () {
          // if (dreamBottomBtnCubit.counter == 4) {
          //   dreamBottomBtnCubit.counter--;
          // }

          if (dreamBottomBtnCubit.bottomCurrentIndex > 0) {
            if (dreamBottomBtnCubit.bottomCurrentIndex == 1) {
              dreamController.isCompleteDreamData.value = false;
              dreamController.title.value = '';
              dreamController.description.value = '';
              dreamController.voiceRecord.value = '';
            } else if (dreamBottomBtnCubit.bottomCurrentIndex == 2) {
              dreamController.isComleteInterperterData.value = false;
              dreamController.hasSeletedInterpreter.value = false;
            } else if (dreamBottomBtnCubit.bottomCurrentIndex == 3) {
              dreamController.isCompletePlanData.value = false;
              dreamController.hasSeletedPlan.value = false;
            } else if (dreamBottomBtnCubit.bottomCurrentIndex == 4) {
              dreamController.isCompleteDreamOwnerData.value = false;
              dreamController.hasSelectedAge.value = false;
              dreamController.hasSelectedDreamTime.value = false;
              dreamController.hasSelectedEmployed.value = false;
              dreamController.hasSelectedGender.value = false;
              dreamController.hasSelectedGuidancePrayer.value = false;
              dreamController.hasSelectedHaveChildrens.value = false;
              dreamController.hasSelectedMaritalStatus.value = false;
              dreamController.hasSelectedMentalIllness.value = false;
            }

            dreamBottomBtnCubit.counter--;
            dreamBottomBtnCubit.bottomCurrentIndex--;
          }

          dreamBottomBtnCubit
              .changeBottomBtnIndex(dreamBottomBtnCubit.bottomCurrentIndex);
          print(
              'bttom inde is ${dreamBottomBtnCubit.bottomCurrentIndex} , counter is ${dreamBottomBtnCubit.counter}');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_left,
              color: ColorsManager.white,
              size: 32,
            ),
            Text(
              tr(StringsManager.back),
              style: getRegularStyle(
                  color: ColorsManager.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }

  Widget _buildNextButton({required DreamBottomBtnCubit dreamBottomBtnCubit}) {
    return
        // BlocBuilder<AddDreamCubit, AddDreamState>(builder: (context, state) {
        //   if (state is AddDreamLoading) {
        //     return const Center(
        //       child:   CircularProgressIndicator(),

        //     );
        //   } else if (state is AddDreamLoaded) {
        //     return
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.secondaryBtnBg,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: () {
              if (dreamBottomBtnCubit.bottomCurrentIndex <= 3) {
                if (dreamBottomBtnCubit.bottomCurrentIndex == 0) {
                  if (dreamController.validationOnDreamData()) {
                    dreamBottomBtnCubit.counter++;
                    dreamBottomBtnCubit.bottomCurrentIndex++;
                  } else {}
                } else if (dreamBottomBtnCubit.bottomCurrentIndex == 1) {
                  if (dreamController.validateionOnInterperterData()) {
                    dreamBottomBtnCubit.counter++;
                    dreamBottomBtnCubit.bottomCurrentIndex++;
                  } else {
                    SnackBarHelper.showErrorSnackBar(
                        tr(StringsManager.completeData),
                        tr(StringsManager.selectInterpreter));
                  }
                } else if (dreamBottomBtnCubit.bottomCurrentIndex == 2) {
                  if (dreamController.validationOnPlanData()) {
                    dreamBottomBtnCubit.counter++;
                    dreamBottomBtnCubit.bottomCurrentIndex++;
                  } else {
                    SnackBarHelper.showErrorSnackBar(
                        tr(StringsManager.completeData),
                        tr(StringsManager.selectPaymentGetway));
                  }
                } else if (dreamBottomBtnCubit.bottomCurrentIndex == 3) {
                  if (dreamController.validateionOnDreamOwnerData()) {
                    dreamBottomBtnCubit.counter++;
                    dreamBottomBtnCubit.bottomCurrentIndex++;
                  } else {
                    SnackBarHelper.showErrorSnackBar(
                        tr(StringsManager.completeData),
                        tr(StringsManager.dreamOwner));
                  }
                }
              }

              if (dreamBottomBtnCubit.counter >= 4) {
                // Get.offAll(()=> Registration());

                final file = File(dreamController.voiceRecord.value);

                context.read<AddDreamCubit>().addDream(
                      context: context,
                      dream: Dream(
                          title: dreamController.title.value,
                          description: dreamController.description.value,
                          userId: dreamController.userId.value,
                          interpreterId: dreamController.interpreterId.value,
                          planId: dreamController.planId.value,
                          countryId: dreamController.countryId.value,
                          materialStatus: dreamController.maritalStatus.value,
                          age: dreamController.age.value,
                          gender: dreamController.gender.value,
                          employed: dreamController.employed.value,
                          haveChildrens: dreamController.haveChildrens.value,
                          dreamTime: dreamController.dreamTime.value,
                          mentalIllness: dreamController.mentalIllness.value,
                          guidancePrayer: dreamController.guidancePrayer.value,
                          notification: 0,
                          voiceRecord: file
                          // You may need to adjust the file extension
                          ),
                    );
                dreamBottomBtnCubit.counter=0;
                dreamBottomBtnCubit.bottomCurrentIndex=0;
              }
              dreamBottomBtnCubit
                  .changeBottomBtnIndex(dreamBottomBtnCubit.bottomCurrentIndex);
              print(
                  'bttom inde is ${dreamBottomBtnCubit.bottomCurrentIndex} and counter is counter is ${dreamBottomBtnCubit.counter}');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  dreamBottomBtnCubit.bottomCurrentIndex == 3
                      ? tr(StringsManager.payingOff)
                      : tr(StringsManager.next),
                  style: getRegularStyle(
                      color: ColorsManager.primaryDarkPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const Icon(
                  Icons.arrow_right,
                  color: ColorsManager.primaryDarkPurple,
                  size: 32,
                )
              ],
            ));
    //     } else if (state is AddDreamError) {
    //     return  Center(child: Text('لا يوجد اتصال بالانترنت', style: getRegularStyle(color: Colors.white),));
    //   } else {
    //     return Container();
    //   }
    // });
  }
}
