import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:helmy_project/exceptions/exception_handler.dart';
import 'package:helmy_project/modules/tafsser/model/dream_detail.dart';
import 'package:helmy_project/modules/tafsser/repositories/tafsser_respository.dart';
part 'tafsser_event.dart';
part 'tafsser_state.dart';

class TafsserBloc extends Bloc<TafsserEvent, DreamState> {
  TafsserBloc() : super(DreamInitial()) {

    
  int page = 1;

    on<TafsserEvent>((event, emit) async {
      if (event is GetDreams) {
        emit(DreamLoading());
        await TafsserRepository().getDreams(page: page).then((result) => result.fold(
            (l) => emit(DreamError(
                widget:
                    ExceptionHandler.getExceptionWidget(l, () => add(event)))),
            (dreams) => emit(DreamsLoaded(dreams: dreams))));
      } else if (event is GetSingleDream) {
        emit(DreamLoading());
       await TafsserRepository().getSingleDream(dreamId: event.dreamId).then(
            (result) => result.fold(
                (l) => emit(DreamError(
                    widget: ExceptionHandler.getExceptionWidget(
                        l, () => add(event)))),
                (dream) => emit(SignleDreamLoaded(dreamDetail: dream))));
      }
    });
  }
}
