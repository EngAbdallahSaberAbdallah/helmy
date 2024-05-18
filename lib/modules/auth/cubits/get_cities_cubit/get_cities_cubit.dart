import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cities_response.dart';
import '../../repository/auth_repository.dart';

part 'get_cities_state.dart';

class GetCitiesCubit extends Cubit<GetCitiesState> {
  final AuthRepository authRepository;

  static GetCitiesCubit get(context) => BlocProvider.of(context);

  GetCitiesCubit(this.authRepository) : super(CitiesInitial());

  List<Countries> citiesData = [];

  void getCities() {
    emit(CitiesLoading());
    authRepository.getCities().then((result) {
      result.fold((failure) {
        emit(CitiesError(failure.message));
      }, (response) {
        citiesData = response.countries!;
        emit(CitiesSuccess(response.countries!));
      });
    });
  }
}
