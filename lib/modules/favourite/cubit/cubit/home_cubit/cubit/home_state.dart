part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}


final class HomeLoading extends HomeState {
  final List<DreamDetail> oldMyDreams;
  final bool isFirstFetch;

  const HomeLoading({required this.oldMyDreams, required this.isFirstFetch});
}

final class HomeLoaded extends HomeState {
  final List<DreamDetail> dreams;
  const HomeLoaded({required this.dreams});

  @override
  List<Object> get props => [dreams];
}

final class HomeError extends HomeState {
  final Widget exceptionWidget;
  const HomeError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}
