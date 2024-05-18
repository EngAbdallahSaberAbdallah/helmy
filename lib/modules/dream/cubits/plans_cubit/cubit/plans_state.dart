part of 'plans_cubit.dart';

sealed class PlansState extends Equatable {
  const PlansState();

  @override
  List<Object> get props => [];
}

final class PlansInitial extends PlansState {}

class PlansLoading extends PlansState {}

class PlansLoaded extends PlansState {
  final List<Plans> plans;

  const PlansLoaded({required this.plans});

  @override
  List<Object> get props => [plans];
}

class PlansError extends PlansState {
  final Widget exceptionWidget;
  const PlansError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}
