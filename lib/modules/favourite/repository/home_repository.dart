import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:helmy_project/modules/favourite/services/home_services.dart';
import 'package:helmy_project/modules/tafsser/model/dream_detail.dart';

class HomeRepository {
 Future<Either<Object, List<DreamDetail>>> getDreams({required int page}) =>
      HomeServices().getDreams(page: page).then((result) => result.fold(
          (l) => left(l),
          (response) => right((jsonDecode(response.body)['Dreams']['data'])
              .map<DreamDetail>((data) => DreamDetail.fromJson(data))
              .toList())));
}