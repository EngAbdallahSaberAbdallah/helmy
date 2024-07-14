import 'package:flutter_bloc/flutter_bloc.dart';

import 'pin_code_state.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  PinCodeCubit() : super(PinCodeState(false, ''));

  // methods to update the state based on the pin code changes and completion status
  void onPinCodeChanged(String value) {
    if (value.length < 6) {
      emit(state.copyWith(isCompleted: false));
    }
  }

  void onPinCodeCompleted(String value) {
    emit(state.copyWith(isCompleted: true, otp: value));
  }
}
