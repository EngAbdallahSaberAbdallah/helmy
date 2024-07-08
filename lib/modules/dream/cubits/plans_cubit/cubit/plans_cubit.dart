import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../compontents/error_dialog.dart';
import '../../../../../exceptions/exception_handler.dart';
import '../../../model/plans_model.dart';
import '../../../repository/plans_repository.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit() : super(PlansInitial());
  void getAllPlans() async {
    emit(PlansLoading());
    try {
      await PlansRepository().getPlans().then((result) => result.fold(
          (l) => throw l, (plans) => emit(PlansLoaded(plans: plans))));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => PlansCubit().getAllPlans());
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(PlansError(exceptionWidget: exceptionWidget));
    }
  }
}
