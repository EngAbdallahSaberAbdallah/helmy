part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}


class GetProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class GetProfileSuccess extends ProfileState {
  final UserProfile authResponse;

  GetProfileSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class GetProfileError extends ProfileState {
  final String error;

  GetProfileError(this.error);

  @override
  List<Object?> get props => [error];
}