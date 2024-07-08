import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../services/home_services.dart';
import '../../tafsser/model/dream_detail.dart';

class HomeRepository {
  Future<Either<Object, List<DreamDetail>>> getDreams(
          {required int page, required bool isFromInterpreter}) =>
      HomeServices()
          .getDreams(page: page, isFromInterpreter: isFromInterpreter)
          .then((result) => result.fold(
              (l) => left(l),
              (response) => right((jsonDecode(response.body)['Dreams']['data'])
                  .map<DreamDetail>((data) => DreamDetail.fromJson(data))
                  .toList())));
}
