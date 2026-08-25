import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/recommendation.dart';
import '../repository/base_movies_repository.dart';
import 'base.dart';

class GetRecommendationUseCase
    extends BaseMovieUseCase<List<Recommendation>, RecommendationParameters> {
   GetRecommendationUseCase({required this.baseMoviesRepository});

  final BaseMoviesRepository baseMoviesRepository;

  @override
  Future<Either<Failure, List<Recommendation>>> call(
    RecommendationParameters parameters,
  ) async{
    return await baseMoviesRepository.getRecommendation(parameters);
  }
}
