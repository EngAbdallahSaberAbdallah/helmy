import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../model/interpreter_model.dart';
import '../services/interpreter_services.dart';

class InterpreterRepository {
  Future<Either<Object, List<Interpreters>>> getInterpreters(
          {required int page}) =>
      InterpreterServices().getInterpreters(page: page).then((result) =>
          result.fold(
              (l) => left(l),
              (response) => right((jsonDecode(response.body)['interpreters'])
                  .map<Interpreters>((data) => Interpreters.fromJson(data))
                  .toList())));
}
