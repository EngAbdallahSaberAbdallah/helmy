import 'package:dartz/dartz.dart';
import '../../../enums/request_methods.dart';
import '../../../helpers/network_helper.dart';
import '../../../network/network_constants.dart';
import '../../../network/network_layer.dart';
import 'package:http/http.dart'as http;

class InterpreterServices{
   Future<Either<Object, http.Response>> getInterpreters({required int page}) async =>
      Api().request('${NetworkConstants.interpreter}',//?page=$page
       RequestMethod.get,
          await NetworkHelper().getHeadersWithToken());
}