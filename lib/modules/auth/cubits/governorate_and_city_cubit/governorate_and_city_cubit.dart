import 'package:flutter_bloc/flutter_bloc.dart';

class CityCubit extends Cubit<String?> {
  CityCubit() : super(null);

  void selectCity(String selectedCity) {
    emit(selectedCity);
  }

  void resetCity() {
    emit(null);
  }
}

class AreasCubit extends Cubit<String?> {
  AreasCubit() : super(null);

  void selectArea(String? area) {
    if (state != area) {
      emit(area);
    }
  }

  void resetArea() {
    emit(null);
  }
}