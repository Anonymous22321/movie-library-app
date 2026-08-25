import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/failure.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/repository/base_tv_repository.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/usecases/base_tv.dart';
import 'package:dartz/dartz.dart';

import '../entities/seasons.dart';

class GetSeasonUseCase extends BaseTvUseCase<Season, SeasonParameters> {
  final BaseTvRepository repository;

  GetSeasonUseCase(this.repository);

  @override
  Future<Either<Failure, Season>> call(SeasonParameters parameters) async {
    return await repository.getSeason(parameters);
  }
}
