import 'package:flutter_bloc/flutter_bloc.dart';

import 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(const GenderState(Gender.male));

  void selectGender(Gender gender) {
    emit(GenderState(gender));
  }
}