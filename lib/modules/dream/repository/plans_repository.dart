import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../model/plans_model.dart';
import '../services/plans_services.dart';

class PlansRepository {
  Future<Either<Object, List<PlanModel>>> getPlans() =>
      PlansServices().getPlans().then((result) => result.fold(
          (l) => left(l),
          (response) => right((jsonDecode(response.body)['plans'])
              .map<PlanModel>((data) => PlanModel.fromJson(data))
              .toList())));
}
