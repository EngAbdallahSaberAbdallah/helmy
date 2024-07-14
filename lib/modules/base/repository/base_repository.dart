import '../../../helpers/services_locator.dart';
import '../../../network/dio_factory.dart';
import '../../../network/network_info.dart';

abstract class BaseRepository {
  late NetworkInfo networkInfo;
  late DioFactory dio;

  BaseRepository(){
    networkInfo=getIt.get<NetworkInfo>();
    dio=getIt.get<DioFactory>();
  }
}