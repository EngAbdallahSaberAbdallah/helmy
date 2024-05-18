import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:helmy_project/modules/dream/model/dream.dart';
import 'package:helmy_project/modules/dream/services/add_dream_services.dart';

class DreamRepository{
  Future<Either<Object, bool>> addDream({required Dream dream}) =>
      AddDreamServices().addDream(dream: dream).then((result) => result.fold(
          (l) => left(l),
          (response) => right((response.data['status']))));
              
}