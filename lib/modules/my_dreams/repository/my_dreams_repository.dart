import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../services/my_dreams_services.dart';
import '../../tafsser/model/dream_detail.dart';

class MyDreamsRepository {
  Future<Either<Object, List<DreamDetail>>> getDreams({required int page}) =>
      MyDreamsServices().getDreams(page: page).then((result) => result.fold(
          (l) => left(l),
          (response) => right((jsonDecode(response.body)['Dreams']['data'])
              .map<DreamDetail>((data) => DreamDetail.fromJson(data))
              .toList())));

  Future<Either<Object, bool>> addDreamComment(
          {required String dreamId,
          required String content,
          required File voiceRecord}) =>
      MyDreamsServices()
          .addDreamComment(
              dreamId: dreamId, content: content, voiceRecord: voiceRecord)
          .then((result) => result.fold(
              (l) => left(l),
              (response) => right(response.data['status'])
          ));
}
