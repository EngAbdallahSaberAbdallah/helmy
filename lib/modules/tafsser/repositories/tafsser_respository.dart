import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:helmy_project/modules/tafsser/model/dream_detail.dart';
import 'package:helmy_project/modules/tafsser/service/tafsser_service.dart';

class TafsserRepository {
  Future<Either<Object, List<DreamDetail>>> getDreams({required int page}) =>
      TafsserService().getDreams(page: page).then((result) => result.fold(
          (l) => left(l),
          (response) => right((jsonDecode(response.body)['Dreams']['data'])
              .map<DreamDetail>((data) => DreamDetail.fromJson(data))
              .toList())));

  Future<Either<Object, DreamDetail>> getSingleDream(
          {required String dreamId}) =>
      TafsserService().getSingleDream(dreamId: dreamId).then((result) =>
          result.fold(
              (l) => left(l),
              (response) => right(
                  DreamDetail.fromJson(jsonDecode(response.body)['dream']))));
}
