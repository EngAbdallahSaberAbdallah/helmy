import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:helmy_project/modules/base/repository/base_repository.dart';

import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../../network/error_handler.dart';
import '../../../network/failure.dart';
import '../../../network/network_constants.dart';
import '../models/UserProfile.dart';

class ProfileRepository extends BaseRepository {
  Future<Either<Failure, UserProfile>> getProfile() async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.get(NetworkConstants.userProfile);

        if (response.statusCode == 200) {
          final data = response.data;

          UserProfile userProfile = UserProfile.fromJson(response.data);

          await getIt.get<CacheHelper>().savePhone(userProfile.phone!);

          await getIt.get<CacheHelper>().saveName(userProfile.firstName!);
          await getIt.get<CacheHelper>().saveLastName(userProfile.lastName!);
          await getIt.get<CacheHelper>().saveGender(userProfile.gender!);
          await getIt.get<CacheHelper>().saveAvatar(
              userProfile.avatar != null ? userProfile.avatar! : "");

          if (data['area'] != {}) {
            await getIt
                .get<CacheHelper>()
                .saveCity(data['area']['city']['name']['ar'].toString());
            await getIt
                .get<CacheHelper>()
                .saveArea(data['area']['name']['ar'].toString());
            await getIt.get<CacheHelper>().saveAreaId(data['area']['id']);
          }

          return Right(UserProfile.fromJson(response.data));
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

  Future<UserProfile> getUserProfile() async {
    var d = await dio.getDio();
    final response = await d.get(
      NetworkConstants.userProfile,
    );
    print('response of update profile is ${response}');
    print(
        'area and city are ${response.data['area']['name']['ar'].toString()} and ${response.data['area']['city']['name']['ar'].toString()}');
    await getIt
        .get<CacheHelper>()
        .saveCity(response.data['area']['city']['name']['ar'].toString());
    await getIt
        .get<CacheHelper>()
        .saveArea(response.data['area']['name']['ar'].toString());
    await getIt.get<CacheHelper>().saveAreaId(response.data['area']['id']);
    return UserProfile.fromJson(response.data);
  }
}
