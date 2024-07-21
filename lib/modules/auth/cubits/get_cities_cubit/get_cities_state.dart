part of 'get_cities_cubit.dart';

abstract class GetCitiesState extends Equatable {
  const GetCitiesState();
}

class CitiesInitial extends GetCitiesState {
  @override
  List<Object> get props => [];
}

class CitiesLoading extends GetCitiesState {
  @override
  List<Object> get props => [];
}

class CitiesSuccess extends GetCitiesState {
  final List<Countries> citiesData;

  const CitiesSuccess(this.citiesData);

  @override
  List<Object> get props => [citiesData];
}

class CitiesError extends GetCitiesState {
  final String errorMessage;

  const CitiesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
