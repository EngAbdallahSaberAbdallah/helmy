import 'package:dartz/dartz.dart';
import 'package:helmy_project/enums/request_methods.dart';
import 'package:helmy_project/helpers/network_helper.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/network/network_layer.dart';
import 'package:http/http.dart'as http;

class InterpreterServices{
   Future<Either<Object, http.Response>> getInterpreters({required int page}) async =>
      Api().request('${NetworkConstants.interpreter}',//?page=$page
       RequestMethod.get,
          await NetworkHelper().getHeadersWithToken());
}