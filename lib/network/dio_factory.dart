import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../helpers/cache_helper.dart';
import 'network_constants.dart';

const String applicationJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLanguage = 'language';

class DioFactory {
  final CacheHelper _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();
    String? token = await _appPreferences.getToken();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: 'Bearer ${token != null ? token : ""}',
      // 'locale': 'en',
      // 'X-Application-Name':'customer'
      // defaultLanguage: language // get it from app prefs
    };

    dio.options = BaseOptions(
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

  Future<Dio> getDioFile() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();
    String? token = await _appPreferences.getToken();
    print('token is $token');
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: 'Bearer ${token != null ? token : ""}',
      'locale': 'ar',
      'X-Application-Name': 'lawyer'
    };

    dio.options = BaseOptions(
        // queryParameters: {
        //   'locale':language
        // },
        baseUrl: NetworkConstants.testImageUrl,
        receiveDataWhenStatusError: true,
        headers: {
          contentType: "multipart/form-data",
          authorization: 'Bearer $token',
          accept: "multipart/form-data",
        },
        receiveTimeout:
            const Duration(milliseconds: NetworkConstants.apiTimeOut),
        sendTimeout: const Duration(milliseconds: NetworkConstants.apiTimeOut));

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true, requestBody: true, responseHeader: true));
    return dio;
  }
}
