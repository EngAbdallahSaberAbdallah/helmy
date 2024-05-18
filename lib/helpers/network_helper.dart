import 'dart:io';

import 'package:helmy_project/helpers/cache_helper.dart';
import 'package:helmy_project/helpers/services_locator.dart';
import 'package:helmy_project/helpers/shared_prefs.dart';

class NetworkHelper {
  Future<Map<String, String>> getHeadersWithToken(
          // String token
          ) async =>
      {
        HttpHeaders.authorizationHeader:
            'Bearer ${await getIt.get<CacheHelper>().getToken()}'
      };

  Future<Map<String, String>> getHeadersWithTokenAndJsonContentType() async => {
        HttpHeaders.authorizationHeader:
            'Bearer ${await getIt.get<CacheHelper>().getToken()}',
        HttpHeaders.contentTypeHeader: 'application/json'
      };
  Map<String, String> getHeadersWithJsonContentType() =>
      {HttpHeaders.contentTypeHeader: 'application/json'};
  Map<String, String> getHeadersWithMultipartContentType() =>
      {HttpHeaders.contentTypeHeader: 'multipart/form-data'};

  Future<Map<String, String>>
      getHeadersWithMultipartContentTypeWithToken() async => {
            HttpHeaders.authorizationHeader:
                'Bearer ${await getIt.get<CacheHelper>().getToken()}',
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
             'accept': "multipart/form-data",
          };
}
