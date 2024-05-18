import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:helmy_project/modules/dream/model/plans.dart';
import 'package:helmy_project/modules/dream/services/plans_services.dart';

class PlansRepository {
  Future<Either<Object, List<Plans>>> getPlans() =>
      PlansServices().getPlans().then((result) => result.fold(
          (l) => left(l),
          (response) => right((jsonDecode(response.body)['plans']
                  ['data']) //TODO: ADD SPECIFIC JSON DATA
              .map<Plans>((data) => Plans.fromJson(data))
              .toList())));
}
