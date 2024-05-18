import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as getPackage;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;

import '../../../app/constants.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../../network/error_handler.dart';
import '../../../network/failure.dart';
import '../../../network/network_constants.dart';
import '../../../resources/routes_manager.dart';
import '../../base/repository/base_repository.dart';
import '../models/auth_response.dart';
import '../models/cities_response.dart';

class AuthRepository extends BaseRepository {
  AuthRepository();

  Future<Either<Failure, bool>> verifyOTP({
    required String otp,
    required String phone,
  }) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.post(NetworkConstants.codeCheck, data: {
          "code": otp
          //  "email": phone,
          ,
          "lang": "ar"
        });

        if (response.statusCode == 200) {
          //success return data
          return Right(true);
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, bool>> resentOTP({
    required String phone,
  }) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.post(NetworkConstants.resentOTP,
            data: {"email": phone, "lang": "en"});

        if (response.statusCode == 200) {
          //success return data
          return const Right(true);
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, AuthResponse>> login({
    required String phoneNumber,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.post(NetworkConstants.login,
            data: {"email": phoneNumber, "password": password, "lang": "ar"});

        // if (response.statusCode == 200) {
          //success return data
          if(response.data['status']){
          
         await getIt.get<CacheHelper>().saveToken(response.data['user']['api_token']);
          List<dynamic> roles = response.data['user']['roles'];
          await getIt.get<CacheHelper>().saveIsInterpreter(roles.isNotEmpty?
          response.data['user']['roles'][0]['name']=='interpreter'? true: false: false);
          Constants.authResponse = AuthResponse.fromJson(response.data);

          return Right(Constants.authResponse);
          
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        }
        if (error.response?.statusCode == 423) {
          getPackage.Get.toNamed(HelmyRoutes.forgetPasswordRoute,
              arguments: false);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  // Future<UserProfile> getProfile() async {
  //   var d = await dio.getDio();
  //   final response = await d.get(
  //     NetworkConstants.userProfile,
  //   );
  //   print('response of update profile is ${response}');
  //   print(
  //       'area and city are ${response.data['area']['name']['ar'].toString()} and ${response.data['area']['city']['name']['ar'].toString()}');
  //   await getIt
  //       .get<CacheHelper>()
  //       .saveCity(response.data['area']['city']['name']['ar'].toString());
  //   await getIt
  //       .get<CacheHelper>()
  //       .saveArea(response.data['area']['name']['ar'].toString());
  //   await getIt.get<CacheHelper>().saveAreaId(response.data['area']['id']);
  //   return UserProfile.fromJson(response.data);
  // }

  Future<Either<Failure, AuthResponse>> register({
    // required String phoneNumber,
    required String name,
    required int countryId,
    required String? email,
    required String? password,
  }) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();

        var data = {
          "name": name,
          "email": email,
          "country_id": countryId,
          "password": password,
          "password_confirmation": password,
          "lang": "ar",
        };

        final response = await d.post(NetworkConstants.register, data: data);

        if (response.statusCode == 200) {
          //success return datarr
          return Right(AuthResponse.fromJson(response.data));
        } else {
          //failure -- return business error
          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, CountriesData>> getCities() async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        late final dynamic response;
        await dio.getDio().then((value) async {
          response = await value.get(NetworkConstants.cities);
        });

        if (response.statusCode == 200) {
          //success return data
          return Right(CountriesData.fromJson(response.data));
        } else {
          //failure -- return business error
          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, bool>> forgetPassword({
    required String phone,
  }) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.post(NetworkConstants.forgetPassword,
            data: {"email": phone, "lang": "en"});

        if (response.statusCode == 200) {
          //success return data
          return const Right(true);
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, bool>> resetPassword({
    required String code,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.post(NetworkConstants.resetPassword, data: {
          "password": password,
          "password_confirmation": password,
          "code": code,
          "lang": "en"
        });

        if (response.statusCode == 200) {
          //success return data
          return const Right(true);
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  Future<Either<Failure, bool>> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String code}) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.post(NetworkConstants.changePassword, data: {
          "password": oldPassword,
          "password_confirmation": newPassword,
          "code": code
        });

        if (response.statusCode == 200) {
          //success return data
          return const Right(true);
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  // update personal data
  Future<Either<Failure, AuthResponse>> updateCustomerPersonalData({
    required String imgPath,
    required String firstName,
    required String lastName,
    required String gender,
    required int areaId,
    required String? email,
    required String? phone,
    required String? address,
  }) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        // FormData formData = FormData();
        // // Add image files to the FormData
        // String imageName = path.basename(imgPath);
        // formData.files.add(
        //   MapEntry(
        //     'images',
        //     await MultipartFile.fromFile(imgPath, filename: imageName),
        //   ),
        // );
        // Create FormData
        // FormData formData = FormData.fromMap({
        //   'images': await MultipartFile.fromFile(
        //     imgPath,
        //     filename: path.basename(imgPath), // You can set the filename as needed
        //   ),
        // });
        // var dioImage = await dio.getDioFile();
        // var responseFile = await dioImage.post(
        //   NetworkConstants.images,
        //   data: formData,
        // );

        var d = await dio.getDio();
        Response? responseFile;
        if (imgPath.isNotEmpty || imgPath != "") {
          String? mimeType = mime(imgPath);
          String? mimee = mimeType?.split('/')[0];
          String? type = mimeType?.split('/')[1];

          var dioFile = await dio.getDioFile();
          final images = await MultipartFile.fromFile(imgPath,
              filename: path.basename(imgPath),
              contentType: MediaType(mimee!, type!));
          dioFile.options.headers["Content-Type"] = "multipart/form-data";
          FormData formData = FormData.fromMap({'image': images});
        

          print('responseFile is $responseFile');
        }
        final response = await d.put(NetworkConstants.userProfile,
            data: Constants.lawyerUpdatePersonalDataRequest(
                imgPath: imgPath.isNotEmpty || imgPath != ""
                    ? responseFile!.data['url']
                    : "",
                firstName: firstName,
                lastName: lastName,
                gender: gender,
                areaId: areaId,
                phone: phone,
                email: email != null || email != "" ? email : "",
                address: address != null || address != "" ? address : ""));

        if (response.statusCode == 200) {
          final authResponse = AuthResponse.fromJson(response.data);
          await getIt.get<CacheHelper>().saveName(firstName);
          await getIt.get<CacheHelper>().saveLastName(lastName);
          await getIt.get<CacheHelper>().saveGender(gender);
          await getIt.get<CacheHelper>().saveAvatar(
              response.data['avatar'] != null
                  ? response.data['avatar'].toString()
                  : "");
          //success return data
          return Right(authResponse);
        } else {
          //failure -- return business error
          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
