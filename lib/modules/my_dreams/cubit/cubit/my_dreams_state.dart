part of 'my_dreams_cubit.dart';

sealed class MyDreamsState extends Equatable {
  const MyDreamsState();

  @override
  List<Object> get props => [];
}

final class MyDreamsInitial extends MyDreamsState {}

final class MyDreamLoading extends MyDreamsState {
  final List<DreamDetail> oldMyDreams;
  final bool isFirstFetch;

  const MyDreamLoading({required this.oldMyDreams, required this.isFirstFetch});
}

final class MyDreamsLoaded extends MyDreamsState {
  final List<DreamDetail> dreams;
  const MyDreamsLoaded({required this.dreams});

  @override
  List<Object> get props => [dreams];
}

final class MyDreamsError extends MyDreamsState {
  final Widget exceptionWidget;
  const MyDreamsError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}

final class AddDreamLoading extends MyDreamsState {
  const AddDreamLoading();
}

final class AddDreamsLoaded extends MyDreamsState {
  final bool status;
  const AddDreamsLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

final class AddDreamsError extends MyDreamsState {
  final Widget exceptionWidget;
  const AddDreamsError({required this.exceptionWidget});

  @override
  List<Object> get props => [exceptionWidget];
}
