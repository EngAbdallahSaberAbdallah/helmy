import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helmy_project/compontents/error_dialog.dart';
import 'package:helmy_project/exceptions/exception_handler.dart';
import 'package:helmy_project/helpers/snackbar_helper.dart';
import 'package:helmy_project/modules/favourite/model/favourite_model.dart';
import 'package:helmy_project/modules/favourite/repository/favourite_repository.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesInitial());

int page = 1;


  void getFavouriteDreams() async {
    if (state is FavouritesLoading) return;

    final currentState = state;

    var oldMyDreams = <FavouriteModel>[];

    if (currentState is FavouritesLoaded) {
      oldMyDreams = currentState.favouriteModel;
    }

    emit(FavouritesLoading(isFirstFetch: page == 1, oldMyDreams: oldMyDreams));

    try {
      await FavouriteRepository()
          .getFouriteDreams(page: page)
          .then((result) => result.fold((l) => throw l, (dreams) {
                var myDreams = (state as FavouritesLoading).oldMyDreams;
                if (page == 1) {
                  myDreams = [];
                  myDreams = dreams;
                } else {
                  myDreams.addAll(dreams);
                }
                page++;
                emit(FavouritesLoaded(favouriteModel: myDreams));
              }));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => FavouritesCubit().getFavouriteDreams());
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(FavouritesError(exceptionWidget: exceptionWidget));
    }
  }

  void addFavouiteDream({required String dreamId, required int rating, required BuildContext context}) async {
    emit(AddFavouriteDreamLoading());
    try {
      await FavouriteRepository().addFavouriteDream(dreamId: dreamId, rating: rating).then((result) =>
          result.fold((l) => throw l, (r) {  

            // Get.back();
            
            SnackBarHelper.showSuccessSnackBar('الحلم', 'تم اضافة الحلم الي قائمة المفضلة بنجاح');
            // emit(AddDreamLoaded());
    }));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => FavouritesCubit().addFavouiteDream(dreamId: dreamId, rating: rating, context: context));
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(AddFavouriteDreamError(exceptionWidget: exceptionWidget));
    }
  }

  void deleteFavouriteDream({required String dreamId, required BuildContext context}) async {
    emit(DeleteFavouriteDreamLoading());
    try {
      await FavouriteRepository().removeFavouriteDream(dreamId: dreamId).then((result) =>
          result.fold((l) => throw l, (r) {  

            Get.back();
            
            SnackBarHelper.showSuccessSnackBar('الحلم', 'تم حذف الحلم من قائمة المفضلة بنجاح');
            // emit(AddDreamLoaded());
    }));
    } catch (e) {
      final Widget exceptionWidget = ExceptionHandler.getExceptionWidget(
          e, () => FavouritesCubit().deleteFavouriteDream(dreamId: dreamId, context: context));
      Get.dialog(
        ErrorDialog(error: ExceptionHandler.getExceptionMessage(e)),
      );
      emit(DeleteFavouriteDreamError(exceptionWidget: exceptionWidget));
    }
  }
}
