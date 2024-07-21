import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart' as g;
import '../exceptions/exceptions.dart';
import 'package:http/http.dart';
import '../enums/request_methods.dart';

class Api {
  final Duration _timeOut = const Duration(minutes: 1);

  Future<Either<Exception, Response>> request(String requestUrl,
      RequestMethod requestMethod, Map<String, String> headers,
      {Map<String, dynamic> body = const {},
      List<MultipartFile> files = const []}) async {
    try {
      final DateTime startTime = DateTime.now();
      final Uri uri = Uri.parse(requestUrl);
      late Response response;
      switch (requestMethod) {
        case RequestMethod.get:
          response = await _get(uri, headers);
          break;
        case RequestMethod.post:
          response = await _post(uri, headers, body: body);
          break;
        case RequestMethod.patch:
          response = await _patch(uri, headers, body: body);
          break;
        case RequestMethod.put:
          response = await _put(uri, headers, body: body);
          break;
        case RequestMethod.delete:
          response = await _delete(uri, headers, body: body);
          break;
        case RequestMethod.postMultiPart:
          StreamedResponse streamedResponse = (await _postMultipart(
              uri, headers,
              body: Map<String, String>.from(body), files: files));
          response = await Response.fromStream(streamedResponse);
          break;
        case RequestMethod.putMultiPart:
          StreamedResponse streamedResponse = (await _putMultipart(uri, headers,
              body: Map<String, String>.from(body), files: files));
          response = await Response.fromStream(streamedResponse);
          break;
      }
      final DateTime endTime = DateTime.now();
      print('=============================');
      print(
          '$requestUrl executed in ${endTime.difference(startTime).inMilliseconds} milliseconds');
      print(body);
      print(response.statusCode);
      print(response.body);
      print(headers.toString());
      print('=============================');
      // if (response.statusCode == 401) {
      //   g.Get.offAll(() => const LoginScreen());
      //   return left(json.decode(response.body)['message'] == null &&
      //           json.decode(response.body)['msg'] == null
      //       ? AppExceptions.authorizationException
      //       : Exception(json.decode(response.body)['message'] ??
      //           json.decode(response.body)['msg'] ??
      //           'NA'));
      // } else
       if (response.statusCode >= 500) {
        return left(AppExceptions.internalServerError);
      } else if (response.statusCode < 500 && response.statusCode > 399) {
        String errorMessage = json.decode(response.body)['message'] ??
            json.decode(response.body)['msg'] ??
            'NA';
        return left(errorMessage == 'NA'
            ? AppExceptions.defaultException
            : Exception(errorMessage));
      } else if (response.statusCode > 199 && response.statusCode < 300) {
        return right(response);
      } else {
        return left(AppExceptions.defaultException);
      }
    } on SocketException catch (_) {
      return left(AppExceptions.networkError);
    } on TimeoutException catch (_) {
      return left(AppExceptions.timeOutException);
    } on Exception catch (e) {
      return left(e);
    } catch (e) {
      print(e.toString());
      return left(e as Exception);
    }
  }

  Future<Response> _get(Uri uri, Map<String, String> headers) =>
      get(uri, headers: headers).timeout(_timeOut);

  Future<Response> _patch(Uri uri, Map<String, String> headers,
          {Map<String, dynamic> body = const {}}) =>
      patch(uri, headers: headers, body: json.encode(body)).timeout(_timeOut);

  Future<Response> _put(Uri uri, Map<String, String> headers,
          {Map<String, dynamic> body = const {}}) =>
      put(uri, headers: headers, body: json.encode(body)).timeout(_timeOut);

  Future<Response> _post(Uri uri, Map<String, String> headers,
      {Map<String, dynamic> body = const {}}) {
    print(4);

    return post(uri, headers: headers, body: json.encode(body))
        .timeout(_timeOut);
  }

  Future<Response> _delete(Uri uri, Map<String, String> header,
          {Map<String, dynamic> body = const {}}) =>
      delete(uri, headers: header, body: json.encode(body)).timeout(_timeOut);

  Future<StreamedResponse> _postMultipart(Uri uri, Map<String, String> headers,
      {Map<String, String> body = const {},
      List<MultipartFile> files = const []}) async {
    MultipartRequest request = MultipartRequest('POST', uri);
    request.files.addAll(files);
    request.fields.addAll(body);
    request.headers.addAll(headers);
    return request.send().timeout(_timeOut);
  } 

  Future<StreamedResponse> _putMultipart(Uri uri, Map<String, String> headers,
      {Map<String, String> body = const {},
      List<MultipartFile> files = const []}) async {
    MultipartRequest request = MultipartRequest('PUT', uri);
    request.files.addAll(files);
    request.fields.addAll(body);
    request.headers.addAll(headers);
    return request.send().timeout(_timeOut);
  }
}
