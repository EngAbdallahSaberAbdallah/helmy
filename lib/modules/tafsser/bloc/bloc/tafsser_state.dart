part of 'tafsser_bloc.dart';

sealed class DreamState extends Equatable {
  const DreamState();
  
  @override
  List<Object> get props => [];
}

final class DreamInitial extends DreamState {}

final class DreamLoading extends DreamState {}

final class DreamsLoaded extends DreamState {
  final List<DreamDetail> dreams;
  const DreamsLoaded({required this.dreams});

  @override
  List<Object> get props => [dreams];
}

final class SignleDreamLoaded extends DreamState{
  final DreamDetail dreamDetail;
  const SignleDreamLoaded({required this.dreamDetail});
  @override
  List<Object> get props => [dreamDetail];
}

final class DreamError extends DreamState {
  final Widget widget;
  const DreamError({required this.widget});

  @override
  List<Object> get props => [widget];
}
