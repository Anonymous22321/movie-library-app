import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/failure.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/recommendations.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/repository/base_tv_repository.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/usecases/base_tv.dart';
import 'package:dartz/dartz.dart';

import '../../../movies/domain/usecases/base.dart';

class GetTvRecommendationsUseCase
    implements
        BaseTvUseCase<List<TvRecommendations>, RecommendationParameters> {
  final BaseTvRepository repository;

  GetTvRecommendationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TvRecommendations>>> call(
    RecommendationParameters parameters,
  ) async {
    return await repository.getRecommendations(parameters);
  }
}
