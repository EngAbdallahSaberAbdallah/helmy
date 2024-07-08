import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../auth/widgets/web_view_page.dart';
import '../../../controller/dream_controller.dart';
import '../../draw_bottom_btns/dream_bottom_btn_cubit.dart';
import '../../../widget/test_web_view.dart';
import '../../../../../compontents/error_dialog.dart';
import '../../../../../exceptions/exception_handler.dart';
import '../../../../../helpers/snackbar_helper.dart';
import '../../../model/dream_model.dart';
import '../../../repository/add_dream_repository.dart';

part 'add_dream_state.dart';

class AddDreamCubit extends Cubit<AddDreamState> {
  AddDreamCubit() : super(AddDreamInitial());

  void addDream(
      {required DreamModel dream, required BuildContext context}) async {
    emit(AddDreamLoading());
    try {
      await DreamRepository()
          .addDream(dream: dream)
          .then((result) => result.fold((l) => throw l, (r) {
                Get.back();
                // SnackBarHelper.showSuccessSnackBar(
                //     'الحلم', 'تم اضافة الحلم بنجاح');
                Get.to(() => WebViewExample(url: r));

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
