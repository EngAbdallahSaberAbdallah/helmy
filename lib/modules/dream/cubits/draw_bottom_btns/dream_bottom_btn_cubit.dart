import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widget/info_dream.dart';
import '../../widget/info_dream_owner.dart';
import '../../widget/select_interpreter.dart';
import '../../widget/select_payment_getway.dart';
import '../../../../resources/strings_manager.dart';
part 'dream_bottom_btn_state.dart';

class DreamBottomBtnCubit extends Cubit<DreamBottomBtnState> {
  DreamBottomBtnCubit() : super(DreamBottomBtnInitial());

  int bottomCurrentIndex = 0;

  int counter = 0;

  List<String> titles = [
    tr(StringsManager.addDream),
    tr(StringsManager.selectInterpreter),
    tr(StringsManager.selectPaymentGetway),
    tr(StringsManager.dreamOwner),
  ];

  List<Widget> homeLayoutScreens = [
    const InfoDream(),
    SelectInterpreter(),
    SelectPaymentGetway(),
    const InfoDreamOwner(),
  ];

  void changeBottomBtnIndex(int index) {
    bottomCurrentIndex = index;
    emit(DreamBottomBtnChangeIndex());
  }
}
