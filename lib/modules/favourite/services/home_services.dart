import 'package:dartz/dartz.dart';
import '../../../enums/request_methods.dart';
import '../../../helpers/network_helper.dart';
import 'package:http/http.dart' as http;
import '../../../network/network_constants.dart';
import '../../../network/network_layer.dart';

class HomeServices {
  Future<Either<Object, http.Response>> getDreams(
          {required int page, required bool isFromInterpreter}) =>
      Api().request(
          '${isFromInterpreter ? NetworkConstants.interpreterDreams : NetworkConstants.dream}?page=$page',
          RequestMethod.get,
          NetworkHelper().getHeadersWithJsonContentType());
}
