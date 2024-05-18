part of 'interpreter_cubit.dart';

sealed class InterpreterState extends Equatable {
  const InterpreterState();

  @override
  List<Object> get props => [];
}

final class InterpreterInitial extends InterpreterState {}

final class InterpreterLoading extends InterpreterState {
  final List<Interpreters> oldInterpreters;
  final bool isFirstFetch;

  const InterpreterLoading({required this.oldInterpreters, required this.isFirstFetch});
}

final class InterpreterLoaded extends InterpreterState {
  final List<Interpreters> interpreters;
  const InterpreterLoaded({required this.interpreters});

  @override
  List<Object> get props => [interpreters];
}

final class InterpreterError extends InterpreterState {
  final Widget exceptionWidget;
  const InterpreterError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}
