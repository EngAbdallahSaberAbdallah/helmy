import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:helmy_project/app/components.dart';
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:helmy_project/modules/dream/cubits/draw_bottom_btns/dream_bottom_btn_cubit.dart';
import 'package:helmy_project/modules/dream/widget/dream_bottom_btn.dart';
import 'package:helmy_project/modules/dream/widget/dream_build_app_bar.dart';
import 'package:get/get.dart';
import 'package:helmy_project/network/network_constants.dart';

enum DreamScreens {
  addDream,
  selectInterperter,
  selectPaymentGetway,
  dreamOwner,
}

class AddDream extends StatefulWidget {
  const AddDream({super.key});

  @override
  State<AddDream> createState() => _AddDreamState();
}

class _AddDreamState extends State<AddDream> {
  final DreamController dreamController = Get.find<DreamController>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamBottomBtnCubit, DreamBottomBtnState>(
        builder: (navContext, state) {
      DreamBottomBtnCubit dreamBottomBtnCubit =
          navContext.read<DreamBottomBtnCubit>();

      return WillPopScope(
          onWillPop: () async {
            dreamBottomBtnCubit.bottomCurrentIndex = 0;
            dreamBottomBtnCubit.counter = 0;
            dreamController.resetAllData();
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(children: [
                    DreamBuildAppBar(),
                  ]),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child:
                        // BlocBuilder<AddDreamCubit, AddDreamState>(
                        //     builder: (navContext, state) {
                        //   if (state is AddDreamLoading) {
                        //     return const Center(
                        //       child: CircularProgressIndicator(
                        //         color: ColorsManager.primaryDarkPurple,
                        //       ),
                        //     );
                        //   } else if (state is AddDreamLoaded) {
                        // return
                        NetworkConstants.token.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 173.sp),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child:
                                        dreamBottomBtnCubit.homeLayoutScreens[
                                            dreamBottomBtnCubit
                                                .bottomCurrentIndex]),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 8.h),
                                child: SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height ,
                                    child: const LoginFirst()),
                              )),
                //   } else if (state is AddDreamError) {
                //     return Center(child: state.exceptionWidget);
                //   } else {
                //     return Container();
                //   }
                // })),
                NetworkConstants.token.isNotEmpty
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: DreamBottomButton(),
                      )
                    : const SizedBox()
              ],
            ),
          ));
    });
  }
}