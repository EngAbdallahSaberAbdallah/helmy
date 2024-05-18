import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helmy_project/compontents/error_dialog.dart';
import 'package:helmy_project/exceptions/exception_handler.dart';
import 'package:helmy_project/modules/my_dreams/repository/my_dreams_repository.dart';
import 'package:helmy_project/modules/tafsser/model/dream_detail.dart';

part 'my_dreams_state.dart';

class MyDreamsCubit extends Cubit<MyDreamsState> {
  MyDreamsCubit() : super(MyDreamsInitial());

  int page = 1;

  void getAllDreams() async {
    if (state is MyDreamLoading) return;

    final currentState = state;

    var oldMyDreams = <DreamDetail>[];

    if (currentState is MyDreamsLoaded) {
      oldMyDreams = currentState.dreams;
    }

    emit(MyDreamLoading(isFirstFetch: page == 1, oldMyDreams: oldMyDreams));

    try {
      await MyDreamsRepository()
          .getDreams(page: page)
          .then((result) => result.fold((l) => throw l, (dreams) {
                var myDreams = (state as MyDreamLoading).oldMyDreams;
                if (page == 1) {
                  myDreams = [];
                  myDreams = dreams;
                } else {
                  myDreams.addAll(dreams);
                }
                page++;
                emit(MyDreamsLoaded(dreams: myDreams));
              }));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => MyDreamsCubit().getAllDreams());
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(MyDreamsError(exceptionWidget: exceptionWidget));
    }
  }

  void addDreamComment(  {required String dreamId,
          required String content,
          required File voiceRecord})async{
              emit( AddDreamLoading());
        await MyDreamsRepository().addDreamComment(dreamId: dreamId, content: content, voiceRecord: voiceRecord).then((result) => result.fold(
            (l) => emit(AddDreamsError(
                exceptionWidget:
                    ExceptionHandler.getExceptionWidget(l, () =>getAllDreams() ))),
            (status) => emit(AddDreamsLoaded(status: status))));
          }
}
