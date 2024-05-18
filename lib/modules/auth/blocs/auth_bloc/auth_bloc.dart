import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/modules/auth/views/login_view.dart';
import 'package:helmy_project/modules/home/view/home_page.dart';
import 'package:helmy_project/modules/payment/view/payment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/cache_helper.dart';
import '../../../../helpers/services_locator.dart';
import '../../../../helpers/snackbar_helper.dart';
import '../../../../resources/routes_manager.dart';
import '../../models/auth_response.dart';
import '../../models/user_model.dart';
import '../../repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<Login>(_login);
    on<Register>(_register);
    on<VerifyOTP>(_verifyOTP);
    on<ResentOTP>(_resentOTP);
    on<ForgetPassword>(_forgetPassword);
    on<ResetPassword>(_resetPassword);
    on<ChangePassword>(_changePassword);
    // on<UpdatePersonalData>(_updateCustomerPersonalData);
  }

  FutureOr<void> _verifyOTP(VerifyOTP event, Emitter<AuthState> emit) async {
    emit(VerifyOTPLoading());
    try {
      final result = await authRepository.verifyOTP(
          phone: event.phoneNumber, otp: event.otp);
      result.fold(
        (failure) {
          debugPrint("Error occurred: ${failure.message}");
          SnackBarHelper.showErrorSnackBar('Error', failure.message.toString());
          emit(VerifyOTPError(failure.message));
        },
        (response) async {
          // await getIt.get<CacheHelper>().saveToken(response.data!.token!);
          // await getIt.get<CacheHelper>().savePhone(response.data!.phone!);

          // await getIt.get<CacheHelper>().saveAvatar(
          //     response.data!.avatar != null ? response.data!.avatar! : "");
          // await getIt
          //     .get<CacheHelper>()
          //     .saveFirstName(response.data!.firstName!);
          // await getIt.get<CacheHelper>().saveLastName(response.data!.lastName!);
          // await getIt.get<CacheHelper>().saveGender(response.data!.gender!);
          emit(VerifyOTPSuccess(true));
        },
      );
    } catch (e) {
      emit(VerifyOTPError(e.toString()));
      SnackBarHelper.showErrorSnackBar('Error', e.toString());
    }
  }

  FutureOr<void> _resentOTP(ResentOTP event, Emitter<AuthState> emit) async {
    emit(ResentOTPLoading());
    await authRepository.resentOTP(phone: event.mail).then((result) {
      result.fold((error) {
        emit(ResentOTPError(error.toString()));
        SnackBarHelper.showErrorSnackBar(tr('failed'), error.message);
      }, (response) async {
        emit(ResentOTPSuccess());
      });
    });
  }

//   @override
//   Stream<AuthState> mapEventToState(AuthEvent event) async* {
//     if (event is CheckAvailabilityEvent) {
//       try {
//         // Fetch availability status from the API
//         bool isAvailable = await fetchAvailabilityFromApi();
//
//         if (isAvailable) {
//           yield AuthAvailableState();
//         } else {
//           yield AuthUnavailableState();
//         }
//       } catch (e) {
//         yield AuthErrorState();
//       }
//     }
//   }
//
//   Future<bool> fetchAvailabilityFromApi() async {
//     // Replace with your API call to fetch availability
//     // Return true if available, false otherwise
//     return true;
//   }
// }

  FutureOr<void> _login(Login event, Emitter<AuthState> emit) async {
    emit(LoginLoading());
    await authRepository
        .login(phoneNumber: event.phoneNumber, password: event.password)
        .then((result) {
      result.fold((error) {
        emit(LoginError(error: error.message, errorStatusCode: error.code));
        SnackBarHelper.showErrorSnackBar(tr('failed'), error.message);
      }, (response) async {
        print('response of login is $response');
        // AuthResponse authResponse = AuthResponse.fromJson(response.data as Map<String, dynamic>);
        // if (response.data!.isActive == true) {

        // await getIt.get<CacheHelper>().savePhone(response.data!.phone!);

        // await getIt
        //     .get<CacheHelper>()
        //     .saveName(response.data!.name!);
        // await getIt.get<CacheHelper>().saveLastName(response.data!.lastName!);
        // await getIt.get<CacheHelper>().saveGender(response.data!.gender!);
        // await getIt.get<CacheHelper>().saveAvatar(
        //     response.data!.avatar != null ? response.data!.avatar! : "");
        Get.back();

        if (response.data!.roles!.length > 0) {
          Get.offAllNamed(HelmyRoutes.interpreterStartRoute);
        } else {
          Get.offAllNamed(HelmyRoutes.userStartRoute);
        }

        // } else {
        //   SnackBarHelper.showErrorSnackBar(
        //       "خطأ", "يرجي التواصل مع خدمة العملاء");
        // }
        emit(LoginSuccess(response));

        //TODO: ADD THIS
        // await getIt.get<CacheHelper>().saveEmail(response.data!.user!.email! == null || response.data!.user!.email!.isEmpty?"": response.data!.email!);
      });
    });
  }

  FutureOr<void> _register(
    Register event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegisterLoading());
    await authRepository
        .register(
            name: event.user.name.toString(),
            countryId: event.user.countryId!,
            // phone
            email: event.user.email,
            password: event.password)
        .then((result) {
      result.fold((error) {
        emit(RegisterError(error.message));
        SnackBarHelper.showErrorSnackBar(tr('failed'), error.message);
      }, (response) async {
        emit(RegisterSuccess(response));
      });
    });
  }

  FutureOr<void> _forgetPassword(
      ForgetPassword event, Emitter<AuthState> emit) async {
    emit(ForgetPasswordLoading());
    await authRepository
        .forgetPassword(phone: event.phoneNumber)
        .then((result) {
      result.fold((error) {
        emit(ForgetPasswordError(error.toString()));
        SnackBarHelper.showErrorSnackBar(tr('failed'), error.message);
      }, (response) async {
        emit(ForgetPasswordSuccess());
      });
    });
  }

  FutureOr<void> _resetPassword(
      ResetPassword event, Emitter<AuthState> emit) async {
    emit(ResetPasswordLoading());
    await authRepository
        .resetPassword(code: event.code, password: event.password)
        .then((result) {
      result.fold((error) {
        emit(ResetPasswordError(error.toString()));
        SnackBarHelper.showErrorSnackBar(tr('failed'), error.message);
      }, (response) async {
        emit(ResetPasswordSuccess());
        // Get.offAllNamed(HelmyRoutes.resetPasswordDoneRoute, arguments: true);
        Get.offAll(() => const LoginView());
        await getIt.get<SharedPreferences>().remove('prefsKeyToken');
      });
    });
  }

  FutureOr<void> _changePassword(
      ChangePassword event, Emitter<AuthState> emit) async {
    emit(ResetPasswordLoading());
    await authRepository
        .changePassword(
            oldPassword: event.oldPassword,
            newPassword: event.newPassword,
            code: event.code)
        .then((result) {
      result.fold((error) {
        emit(ResetPasswordError(error.toString()));
        SnackBarHelper.showErrorSnackBar(tr('failed'), error.message);
      }, (response) async {
        emit(ResetPasswordSuccess());
        Get.offNamed(HelmyRoutes.resetPasswordDoneRoute, arguments: false);
      });
    });
  }

  // FutureOr<void> _updateCustomerPersonalData(
  //   UpdatePersonalData event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(UpdateProfileLoading());
  //   print('area id in update lawyer personal ${event.user.countryId!}');
  //   await authRepository
  //       .updateCustomerPersonalData(
  //     imgPath: event.user.avatar!,
  //     firstName: event.user.name!,
  //     lastName: event.user.lastName!,
  //     phone: event.user.phone!,
  //     email: event.user.email!,
  //     address: event.user.address!,
  //     areaId: event.user.countryId!,
  //     gender: event.user.gender!,
  //   )
  //       .then((result) {
  //     result.fold((error) {
  //       emit(UpdateProfileError(error.message));
  //       SnackBarHelper.showErrorSnackBar(tr('failed'), error.message);
  //     }, (response) async {
  //       emit(UpdateProfileSuccess(response));

  //       print('response of update user is $response');
  //       // await getIt.get<CacheHelper>().saveToken(response.data!.token!);
  //     });
  //   });
  // }
}
