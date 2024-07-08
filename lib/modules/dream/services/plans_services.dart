import 'package:dartz/dartz.dart';
import '../../../enums/request_methods.dart';
import '../../../helpers/network_helper.dart';
import 'package:http/http.dart';
import '../../../network/network_constants.dart';
import '../../../network/network_layer.dart';

class PlansServices{
    Future<Either<Object, Response>> getPlans() async => Api().request(
      NetworkConstants.plans,
      RequestMethod.get,
      await NetworkHelper().getHeadersWithToken());
}