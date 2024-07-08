import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../compontents/error_dialog.dart';
import '../../../../../exceptions/exception_handler.dart';
import '../../../model/interpreter_model.dart';
import '../../../repository/interpreter_repository.dart';

part 'interpreter_state.dart';

class InterpreterCubit extends Cubit<InterpreterState> {
  InterpreterCubit() : super(InterpreterInitial());
  
  int page = 1;

  void getAllInterpreters() async {
    if (state is InterpreterLoading) return;

    final currentState = state;

    var oldInterpreters = <Interpreters>[];

    if (currentState is InterpreterLoaded) {
      oldInterpreters = currentState.interpreters;
    }

    emit(InterpreterLoading(isFirstFetch: page == 1, oldInterpreters: oldInterpreters));

    try {
      await InterpreterRepository()
          .getInterpreters(page: page)
          .then((result) => result.fold((l) => throw l, (interpretersList) {
                var interpreters = (state as InterpreterLoading).oldInterpreters;
                if (page == 1) {
                  interpreters = [];
                  interpreters = interpretersList;
                } else {
                  interpreters.addAll(interpretersList);
                }
                page++;
                emit(InterpreterLoaded(interpreters: interpreters));
              }));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => InterpreterCubit().getAllInterpreters());
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(InterpreterError(exceptionWidget: exceptionWidget));
    }
  }
}
