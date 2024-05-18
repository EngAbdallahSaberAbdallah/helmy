import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/app/components.dart';
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:helmy_project/modules/dream/cubits/draw_bottom_btns/dream_bottom_btn_cubit.dart';

class DreamBuildAppBar extends StatelessWidget {
  DreamBuildAppBar({super.key});

   final DreamController dreamController = Get.find<DreamController>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamBottomBtnCubit, DreamBottomBtnState>(
        builder: (navContext, state) {
      DreamBottomBtnCubit dreamBottomBtnCubit =
          navContext.read<DreamBottomBtnCubit>();
      return CustomAppBar(
          onTapBackBtn: () {
            dreamBottomBtnCubit.bottomCurrentIndex = 0;
            dreamBottomBtnCubit.counter =0;
           dreamController.resetAllData();
          
            Get.back();
            // print('dream bottom btn is ${dreamBottomBtnCubit.bottomCurrentIndex}');
          },
          title: dreamBottomBtnCubit
              .titles[dreamBottomBtnCubit.bottomCurrentIndex],
          widget: const SizedBox(
            width: 50,
          ));
    });
  }
}
