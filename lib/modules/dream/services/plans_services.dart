import 'package:dartz/dartz.dart';
import 'package:helmy_project/enums/request_methods.dart';
import 'package:helmy_project/helpers/network_helper.dart';
import 'package:http/http.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/network/network_layer.dart';

class PlansServices{
    Future<Either<Object, Response>> getPlans() async => Api().request(
      NetworkConstants.plans,
      RequestMethod.get,
      await NetworkHelper().getHeadersWithToken());
}