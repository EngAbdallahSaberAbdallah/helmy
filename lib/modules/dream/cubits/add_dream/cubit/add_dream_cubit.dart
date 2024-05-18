import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/compontents/error_dialog.dart';
import 'package:helmy_project/exceptions/exception_handler.dart';
import 'package:helmy_project/helpers/snackbar_helper.dart';
import 'package:helmy_project/modules/dream/cubits/draw_bottom_btns/dream_bottom_btn_cubit.dart';
import 'package:helmy_project/modules/dream/model/dream.dart';
import 'package:helmy_project/modules/dream/repository/add_dream_respository.dart';

part 'add_dream_state.dart';

class AddDreamCubit extends Cubit<AddDreamState> {
  AddDreamCubit() : super(AddDreamInitial());

  void addDream({required Dream dream, required BuildContext context}) async {
    emit(AddDreamLoading());
    try {
      await DreamRepository()
          .addDream(dream: dream)
          .then((result) => result.fold((l) => throw l, (r) {
             
                Get.back();
                SnackBarHelper.showSuccessSnackBar(
                    'الحلم', 'تم اضافة الحلم بنجاح');
                // emit(AddDreamLoaded());
              }));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => AddDreamCubit().addDream(dream: dream, context: context));
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(AddDreamError(exceptionWidget: exceptionWidget));
    }
  }
}
