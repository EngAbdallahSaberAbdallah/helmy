
import 'package:dartz/dartz.dart';
import 'package:helmy_project/enums/request_methods.dart';
import 'package:helmy_project/helpers/network_helper.dart';
import 'package:http/http.dart' as http;
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/network/network_layer.dart';

class HomeServices{
   Future<Either<Object, http.Response>> getDreams({required int page})  =>
      Api().request('${NetworkConstants.dream}?page=$page', RequestMethod.get,
           NetworkHelper().getHeadersWithJsonContentType());
}