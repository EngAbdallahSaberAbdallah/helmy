import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../enums/request_methods.dart';
import '../../../helpers/network_helper.dart';
import 'package:http/http.dart' as http;
import '../../../network/network_constants.dart';
import '../../../network/network_layer.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class MyDreamsServices {
  Future<Either<Object, http.Response>> getDreams({required int page}) async =>
      Api().request('${NetworkConstants.dream}?page=$page', RequestMethod.get,
          await NetworkHelper().getHeadersWithToken());

//   Future<Either<Object, http.Response>> addDreamComment({
//   required String dreamId,
//   required String content,
//   required File voiceRecord,
// }) async {
//   var bytes;
//   String base64String;
//   late http.MultipartFile fileRequest;

//   if (voiceRecord.path.isNotEmpty) {
//     bytes = voiceRecord.readAsBytesSync();
//     base64String = base64Encode(bytes);

//     fileRequest = http.MultipartFile.fromString(
//       'voice_record',
//       base64String,
//       filename: path.basename(voiceRecord.path),
//       contentType: MediaType('audio', 'mpeg'), // Adjust the content type as needed
//     );
//   }

//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse(NetworkConstants.addDreamComment),
//   );

//   request.fields.addAll({
//     'dream_id': dreamId,
//     'content': content,
//     'lang': 'ar',
//   });

//   if (voiceRecord.path.isNotEmpty) {
//     request.files.add(fileRequest);
//   }

//   var streamedResponse = await request.send();
//   var response = await http.Response.fromStream(streamedResponse);

//   return Either<Exception, http.Response>.pure(response);
// }

  Future<Either<Object, dio.Response>> addDreamComment(
      {required String dreamId,
      required String content,
      required File voiceRecord}) async {
    // late var bytes;
    // late String base64String;

    // late http.MultipartFile fileRequest;
    late dio.MultipartFile multipartFile;

    late dio.FormData formData;

    if (voiceRecord.path.isNotEmpty) {
      String? mimeType = mime(voiceRecord.path);
      String? mimee = mimeType?.split('/')[0];
      String? type = mimeType?.split('/')[1];
     
      multipartFile = await dio.MultipartFile.fromFile(
        voiceRecord.path,
        filename: path.basename(voiceRecord.path),
        contentType:
            MediaType("audio","mp3" ), //'audio', 'mpeg // mimee!, type!
      );

      formData = dio.FormData.fromMap({
        'voice_record': multipartFile,
        "dream_id": dreamId,
        "content": content,
        "lang": "ar",
      });

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
      'add-dream-comment',
      data: dio.FormData.fromMap({
        if(voiceRecord.path != "")'voice_record':  multipartFile,
        "dream_id": dreamId,
        "content": content,
        "lang": "ar",
      }),
    );

   
    return Right<Object, dio.Response>(dio.Response(requestOptions: RequestOptions(path: ''), data: response.data, statusCode: response.statusCode));
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

  /*
Future<void> uploadAndDeleteRecording() async {
    try {
      final url = Uri.parse('YOUR_UPLOAD_URL'); // Replace with your server's upload URL

      final file = File(audioPath);
      if (!file.existsSync()) {
        print("UPLOADING FILE NOT EXIST+++++++++++++++++++++++++++++++++++++++++++++++++");
        return;
      }
      print("UPLOADING FILE ++++++++++++++++${audioPath}+++++++++++++++++++++++++++++++++");
      final request = http.MultipartRequest('POST', url)
        ..files.add(
          http.MultipartFile(
            'audio',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: 'audio.mp3', // You may need to adjust the file extension
          ),
        );

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        // Upload successful, you can delete the recording if needed
        // Show a snackbar or any other UI feedback for a successful upload
        const snackBar = SnackBar(
          content: Text('Audio uploaded.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // Refresh the UI
        setState(() {
          audioPath = "";
        });
      } else {
        // Handle the error or show an error message
        print('Failed to upload audio. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading audio: $e');
    }
  }

  Future<void> deleteRecording() async {

    if (audioPath.isNotEmpty) {
      try {
        recoding_now=true;
        File file = File(audioPath);
        if (file.existsSync()) {
          file.deleteSync();
          const snackBar = SnackBar(
              content: Text('Recoding deleted'),);
          print("FILE DELETED+++++++++++++++++++++++++++++++++++++++++++++++++");
        }
      } catch (e) {
        print("FILE NOT DELETED++++++++++++++++${e}+++++++++++++++++++++++++++++++++");
      }

      setState(() {
        audioPath = "";
      });
    }
  }
  */
}
