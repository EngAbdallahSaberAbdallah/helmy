import 'package:dartz/dartz.dart';
import 'package:helmy_project/enums/request_methods.dart';
import 'package:helmy_project/helpers/network_helper.dart';
import 'package:http/http.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/network/network_layer.dart';

class TafsserService{
  Future<Either<Object, Response>> getDreams({required int page}) async => 
  Api().request(
     NetworkConstants.dream, RequestMethod.get,
      await NetworkHelper()
          .getHeadersWithToken());


  Future<Either<Object, Response>> getSingleDream({required String dreamId}) async=>
    Api().request( NetworkConstants.showDream+ dreamId,
     RequestMethod.get, await NetworkHelper().getHeadersWithToken());
}