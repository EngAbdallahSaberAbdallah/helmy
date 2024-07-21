import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../model/dream_model.dart';
import '../services/add_dream_services.dart';

class DreamRepository{
  Future<Either<Object, String>> addDream({required DreamModel dream}) =>
      AddDreamServices().addDream(dream: dream).then((result) => result.fold(
          (l) => left(l),
          (response) => right((response.data['payment_url']))));
              
}