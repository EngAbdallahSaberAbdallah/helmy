import 'dart:io';

import 'cache_helper.dart';
import 'services_locator.dart';
import 'shared_prefs.dart';

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
