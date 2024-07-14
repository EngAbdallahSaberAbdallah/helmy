part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class Login extends AuthEvent {
  final String phoneNumber;
  final String password;

  Login({required this.phoneNumber, required this.password});

  @override
  List<Object?> get props => [phoneNumber, password];
}

class Register extends AuthEvent {
  final UserData user;
  final String password;

  Register({required this.user, required this.password});

  @override
  List<Object?> get props => [user, password];
}

class RegisterWithSocialAccount extends AuthEvent {
  final UserData user;
  final BuildContext context;

  RegisterWithSocialAccount({required this.user, required this.context});

  @override
  List<Object?> get props => [
        user,
      ];
}

class DeleteAccount extends AuthEvent {
  final BuildContext context;
  DeleteAccount({required this.context});

  @override
  List<Object?> get props => [];
}

class VerifyOTP extends AuthEvent {
  final String otp;
  final String phoneNumber;

  VerifyOTP({required this.otp, required this.phoneNumber});

  @override
  List<Object?> get props => [otp, phoneNumber];
}

class VerifyOTPEmailVerification extends AuthEvent {
  final String otp;
  final String email;

  VerifyOTPEmailVerification({required this.otp, required this.email});

  @override
  List<Object?> get props => [otp, email];
}

class VerifyEmailWithCode extends AuthEvent {
  final String otp;
  final String email;

  VerifyEmailWithCode({required this.otp, required this.email});

  @override
  List<Object?> get props => [otp, email];
}

class ForgetPassword extends AuthEvent {
  final String phoneNumber;

  ForgetPassword({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class ResetPassword extends AuthEvent {
  final String code;
  final String password;
  final bool isRestFromRoot;

  ResetPassword(this.password,
      {required this.code, required this.isRestFromRoot});

  @override
  List<Object?> get props => [code, password];
}

class ChangePassword extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  final String code;

  ChangePassword(
      {required this.oldPassword,
      required this.newPassword,
      required this.code});

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class UpdatePassword extends AuthEvent {
  final String oldPassword;
  final String newPassword;
  final String passwordConfirm;

  UpdatePassword(
      {required this.oldPassword,
      required this.newPassword,
      required this.passwordConfirm});

  @override
  List<Object?> get props => [oldPassword, newPassword, passwordConfirm];
}

class GetProfile extends AuthEvent {
  final AuthResponse authResponse;

  GetProfile({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class ResentOTP extends AuthEvent {
  final String mail;

  ResentOTP({required this.mail});

  @override
  List<Object?> get props => [mail];
}

class UpdatePersonalData extends AuthEvent {
  final UserData user;
  final String areaName;
  final String cityName;

  UpdatePersonalData(
      {required this.user, required this.areaName, required this.cityName});

  @override
  List<Object?> get props => [user, areaName, cityName];
}
