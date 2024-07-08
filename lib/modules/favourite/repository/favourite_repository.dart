import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../model/favourite_model.dart';
import '../services/favourite_services.dart';

class FavouriteRepository {
  Future<Either<Object, List<FavouriteModel>>> getFouriteDreams(
          {required int page}) =>
      FavouriteServices().getFavouriteDreams(page: page).then((result) =>
          result.fold(
              (l) => left(l),
              (response) => right((jsonDecode(response.body)['favorites']
                      ['data'])
                  .map<FavouriteModel>((data) => FavouriteModel.fromJson(data))
                  .toList())));

  Future<Either<Object, bool>> addFavouriteDream({required String dreamId, required int rating}) =>
      FavouriteServices().addFavouriteDream(dreamId: dreamId, rating: rating).then((result) => result.fold(
          (l) => left(l),
          (response) => right((jsonDecode(response.body)['status']))));

  Future<Either<Object, bool>> removeFavouriteDream({required String dreamId}) =>
      FavouriteServices().removeFavouriteDream(dreamId: dreamId).then((result) => result.fold(
          (l) => left(l),
          (response) => right((jsonDecode(response.body)['status']))));
}
