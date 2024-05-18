import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:helmy_project/enums/request_methods.dart';
import 'package:helmy_project/helpers/network_helper.dart';
import 'package:helmy_project/modules/dream/model/dream.dart';
import 'package:http/http.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/network/network_layer.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import 'package:dio/dio.dart';

class AddDreamServices {
  // Future<Either<Object, Response>> addDream({required Dream dream}) async => Api().request(
  //     NetworkConstants.addDream,
  //     RequestMethod.post,
  //     await NetworkHelper().getHeadersWithTokenAndJsonContentType(),
  //     body: dream.toJson(),files: [dream.voiceRecord]);

  Future<Either<Object, dio.Response>> addDream({required Dream dream}) async {
    // late var bytes;
    // late String base64String;

    // late http.MultipartFile fileRequest;
    late dio.MultipartFile multipartFile;

    late dio.FormData formData;

    if (dream.voiceRecord.path.isNotEmpty) {
      String? mimeType = mime(dream.voiceRecord.path);
      String? mimee = mimeType?.split('/')[0];
      String? type = mimeType?.split('/')[1];

      multipartFile = await dio.MultipartFile.fromFile(
        dream.voiceRecord.path,
        filename: path.basename(dream.voiceRecord.path),
        contentType:
            MediaType("audio", "mp3"), //'audio', 'mpeg // mimee!, type!
      );

      // formData = dio.FormData.fromMap({
      //   'voice_record': multipartFile,
      //   "dream_id": dreamId,
      //   "content": content,
      //   "lang": "ar",
      // });

      // "audio": path.basename(voiceRecord.path),
      // formData = dio.FormData.fromMap({
      //   "dream_id": dreamId,
      //   "content": content,
      //   'voice_record': voiceRecord,
      //   "lang": "ar"
      // });
    }

    var dioFile = await getDioFile();
    final response = await dioFile.post(
       NetworkConstants.addDream,
      data: dio.FormData.fromMap({
        if (dream.voiceRecord.path != "") 'voice_record': multipartFile,
        "lang": "ar",
        'title': dream.title,
        'description': dream.description,
        'user_id': 1,
        'interpreter_id': dream.interpreterId,
        'plan_id': dream.planId,
        'country_id': 1, //TODO:update this later
        'marital_status': dream.materialStatus,
        'age': dream.age,
        'gender': dream.gender,
        'employed': dream.employed,
        'have_childrens': dream.haveChildrens,
        'dream_time': dream.dreamTime,
        'mental_illness': dream.mentalIllness,
        'guidance_prayer': dream.guidancePrayer,
        'notification': 0,
      }),
    );

    return Right<Object, dio.Response>(dio.Response(
        requestOptions: RequestOptions(path: ''),
        data: response.data,
        statusCode: response.statusCode));
  }

  Future<dio.Dio> getDioFile() async {
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
}
