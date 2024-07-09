import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:helmy_project/helpers/network_helper.dart';
import 'package:helmy_project/modules/auth/models/auth_response.dart';
import 'package:mime_type/mime_type.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../base/repository/base_repository.dart';

import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../../network/error_handler.dart';
import '../../../network/failure.dart';
import '../../../network/network_constants.dart';
import '../models/UserProfile.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class ProfileRepository extends BaseRepository {
  Future<Dio> getDioFile() async {
    Dio dio = Dio();

    Map<String, String> headers =
        await NetworkHelper().getHeadersWithMultipartContentTypeWithToken();
    dio.options = BaseOptions(
        // queryParameters: {
        //   'locale':language
        // },
        // baseUrl: NetworkConstants.testImageUrl,
        baseUrl: NetworkConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: headers,
        receiveTimeout:
            const Duration(milliseconds: NetworkConstants.apiTimeOut),
        sendTimeout: const Duration(milliseconds: NetworkConstants.apiTimeOut));

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true, requestBody: true, responseHeader: true));
    return dio;
  }

  Future<Either<Failure, bool>> updateProfile(
      {String imagePath = "", String name = "", String countryId = ""}) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      late MultipartFile multipartFile;

      try {
        if (imagePath.isNotEmpty) {
          String? mimeType = mime(imagePath);
          String? mimee = mimeType?.split('/')[0];
          String? type = mimeType?.split('/')[1];

          multipartFile = await MultipartFile.fromFile(
            imagePath,
            filename: path.basename(imagePath),
            contentType: MediaType(mimee!, type!),
          );
        }
        var dioFile = await getDioFile();
        final response = await dioFile.post(
          NetworkConstants.updateProfile,
          data: FormData.fromMap({
            if (imagePath.isNotEmpty) "avatar": multipartFile,
            if (name.isNotEmpty) "name": name,
            if (countryId.isNotEmpty) "country_id": int.parse(countryId),
            if (imagePath.isNotEmpty || name.isNotEmpty || countryId.isNotEmpty)
              "lang": "ar",
          }),
        );

        if (response.statusCode == 200) {
          final data = response.data;

          // UserProfile userProfile = UserProfile.fromJson(response.data);
          //
          // await getIt.get<CacheHelper>().savePhone(userProfile.phone!);
          //
          // await getIt.get<CacheHelper>().saveName(userProfile.firstName!);
          // await getIt.get<CacheHelper>().saveLastName(userProfile.lastName!);
          // await getIt.get<CacheHelper>().saveGender(userProfile.gender!);
          // await getIt.get<CacheHelper>().saveAvatar(
          //     userProfile.avatar != null ? userProfile.avatar! : "");

          // if (data['area'] != {}) {
          //   await getIt
          //       .get<CacheHelper>()
          //       .saveCity(data['area']['city']['name']['ar'].toString());
          //   await getIt
          //       .get<CacheHelper>()
          //       .saveArea(data['area']['name']['ar'].toString());
          //   await getIt.get<CacheHelper>().saveAreaId(data['area']['id']);
          // }

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

  Future<AuthResponse> getUserProfile() async {
    var d = await dio.getDio();
    final response = await d.get(
      NetworkConstants.userProfile,
    );

    if (response.data['status'] && response.data['msg'] == "") {
      await getIt.get<CacheHelper>().saveName(response.data['users']['name']);
      await getIt.get<CacheHelper>().saveEmail(response.data['users']['email']);

      await getIt.get<CacheHelper>().saveAvatar(
          response.data['users']['avatar_url'] != null
              ? response.data['users']['avatar_url'].toString()
              : "");

      await getIt
          .get<CacheHelper>()
          .saveAreaId(response.data['users']['country_id']);

      List<dynamic> roles = response.data['users']['roles'];
      await getIt.get<CacheHelper>().saveIsInterpreter(roles.isNotEmpty
          ? response.data['users']['roles'][0]['name'] == 'interpreter'
              ? true
              : false
          : false);
    }
    return AuthResponse.fromJson(response.data);
  }
}
