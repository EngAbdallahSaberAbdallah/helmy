part of 'add_dream_cubit.dart';

sealed class AddDreamState extends Equatable {
  const AddDreamState();

  @override
  List<Object> get props => [];
}

final class AddDreamInitial extends AddDreamState {}

final class AddDreamLoading extends AddDreamState {}

final class AddDreamLoaded extends AddDreamState {}

final class AddDreamError extends AddDreamState {
  final Widget exceptionWidget;
  const AddDreamError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}
