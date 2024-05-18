import 'package:dartz/dartz.dart';
import 'package:helmy_project/enums/request_methods.dart';
import 'package:helmy_project/helpers/network_helper.dart';
import 'package:http/http.dart';
import 'package:helmy_project/network/network_constants.dart';
import 'package:helmy_project/network/network_layer.dart';

class FavouriteServices {
  Future<Either<Object, Response>> getFavouriteDreams(
          {required int page}) async =>
      Api().request('${NetworkConstants.favourite}?page=$page',
          RequestMethod.get, await NetworkHelper().getHeadersWithToken());

  Future<Either<Object, Response>> addFavouriteDream({required String dreamId, required int rating}) async =>
      Api().request(NetworkConstants.favourite, RequestMethod.post,
          await NetworkHelper().getHeadersWithTokenAndJsonContentType(),
          body: {
            "lang":"ar",
            "dream_id":dreamId,
           if(rating > 0) "rating":rating.toString()
           
          },);

  Future<Either<Object, Response>> removeFavouriteDream({required String dreamId}) async =>
      Api().request('${NetworkConstants.favourite}/$dreamId',
          RequestMethod.delete, await NetworkHelper().getHeadersWithToken());
}
