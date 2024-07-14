import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<int> {
  TimerCubit() : super(60);

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    emit(60);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state > 0) {
        emit(state - 1);
      } else {
        _timer?.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    emit(60);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}