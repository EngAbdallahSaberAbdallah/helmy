import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../compontents/error_dialog.dart';
import '../../../../../../exceptions/exception_handler.dart';
import '../../../../../tafsser/model/dream_detail.dart';
import '../../../../repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int page = 1;

  void getAllDreams({required bool isFromInterpreter}) async {
    if (state is HomeLoading) return;

    final currentState = state;

    var oldMyDreams = <DreamDetail>[];

    if (currentState is HomeLoaded) {
      oldMyDreams = currentState.dreams;
    }

    emit(HomeLoading(isFirstFetch: page == 1, oldMyDreams: oldMyDreams));

    try {
      await HomeRepository()
          .getDreams(page: page, isFromInterpreter: isFromInterpreter)
          .then((result) => result.fold((l) => throw l, (dreams) {
                var myDreams = (state as HomeLoading).oldMyDreams;
                if (page == 1) {
                  myDreams = [];
                  myDreams = dreams;
                } else {
                  myDreams.addAll(dreams);
                }
                page++;
                emit(HomeLoaded(dreams: myDreams));
              }));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => HomeCubit().getAllDreams(isFromInterpreter: false));
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(HomeError(exceptionWidget: exceptionWidget));
    }
  }
}
