import 'package:dartz/dartz.dart';
import '../../../enums/request_methods.dart';
import '../../../helpers/network_helper.dart';
import 'package:http/http.dart';
import '../../../network/network_constants.dart';
import '../../../network/network_layer.dart';

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