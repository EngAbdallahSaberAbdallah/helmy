part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class VerifyOTPLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class VerifyOTPSuccess extends AuthState {
  final bool isVerified;
  // final AuthResponse userResponse;

  VerifyOTPSuccess(
    this.isVerified,
  );

  @override
  List<Object?> get props => [
        isVerified,
      ];
}

class VerifyOTPError extends AuthState {
  final String error;

  VerifyOTPError(this.error);

  @override
  List<Object?> get props => [error];
}

class LoginLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends AuthState {
  final AuthResponse loginResponse;

  LoginSuccess(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];
}

class LoginError extends AuthState {
  final String error;
  final int errorStatusCode;

  LoginError({required this.error, required this.errorStatusCode});

  @override
  List<Object?> get props => [error, errorStatusCode];
}

class DeleteAccountLoading extends AuthState {
  DeleteAccountLoading();
  @override
  List<Object?> get props => [];
}

class DeleteAccountSuccess extends AuthState {
  DeleteAccountSuccess();

  @override
  List<Object?> get props => [];
}

class DeleteAccountError extends AuthState {
  final String error;
  final int errorStatusCode;

  DeleteAccountError({required this.error, required this.errorStatusCode});

  @override
  List<Object?> get props => [error, errorStatusCode];
}
//
// class GetProfileLoading extends AuthState {
//   @override
//   List<Object?> get props => [];
// }
//
// class GetProfileSuccess extends AuthState {
//   final AuthResponse loginResponse;
//
//   GetProfileSuccess(this.loginResponse);
//
//   @override
//   List<Object?> get props => [loginResponse];
// }
//
// class GetProfileError extends AuthState {
//   final String error;
//
//   GetProfileError(this.error);
//
//   @override
//   List<Object?> get props => [error];
// }

class UpdateProfileLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccess extends AuthState {
  final AuthResponse authResponse;

  UpdateProfileSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class UpdateProfileError extends AuthState {
  final String error;

  UpdateProfileError(this.error);

  @override
  List<Object?> get props => [error];
}

class RegisterLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccess extends AuthState {
  final AuthResponse authResponse;

  RegisterSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class RegisterError extends AuthState {
  final String error;

  RegisterError(this.error);

  @override
  List<Object?> get props => [error];
}

class RegisterWithSocialAccountLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class RegisterWithSocialAccountSuccess extends AuthState {
  final AuthResponse authResponse;

  RegisterWithSocialAccountSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class RegisterWithSocialAccountError extends AuthState {
  final String error;

  RegisterWithSocialAccountError(this.error);

  @override
  List<Object?> get props => [error];
}

class ForgetPasswordLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordSuccess extends AuthState {
  ForgetPasswordSuccess();

  @override
  List<Object?> get props => [];
}

class ForgetPasswordError extends AuthState {
  final String error;

  ForgetPasswordError(this.error);

  @override
  List<Object?> get props => [error];
}

class ResetPasswordLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccess extends AuthState {
  ResetPasswordSuccess();

  @override
  List<Object?> get props => [];
}

class ResetPasswordError extends AuthState {
  final String error;

  ResetPasswordError(this.error);

  @override
  List<Object?> get props => [error];
}

class ChangePasswordLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordSuccess extends AuthState {
  ChangePasswordSuccess();

  @override
  List<Object?> get props => [];
}

class ChangePasswordError extends AuthState {
  final String error;

  ChangePasswordError(this.error);

  @override
  List<Object?> get props => [error];
}

class ResentOTPLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class ResentOTPSuccess extends AuthState {
  ResentOTPSuccess();

  @override
  List<Object?> get props => [];
}

class ResentOTPError extends AuthState {
  final String error;

  ResentOTPError(this.error);

  @override
  List<Object?> get props => [error];
}
