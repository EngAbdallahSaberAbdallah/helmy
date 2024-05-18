import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helmy_project/compontents/error_dialog.dart';
import 'package:helmy_project/exceptions/exception_handler.dart';
import 'package:helmy_project/modules/dream/model/plans.dart';
import 'package:helmy_project/modules/dream/repository/plans_repository.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit() : super(PlansInitial());
   void getAllDreams()async{
     emit(PlansLoading());
     try{
  await PlansRepository().getPlans().then((result) => result.fold(
            (l) =>throw l,
            (plans) => emit(PlansLoaded(plans: plans))));
     }catch (e){
      final Widget exceptionWidget =
            ExceptionHandler.getExceptionWidget(e, () => PlansCubit().getAllDreams());
        Get.dialog(
          ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
        );
        emit(PlansError(exceptionWidget: exceptionWidget));
     }
      
  }

}
