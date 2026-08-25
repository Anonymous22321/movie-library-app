import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/failure.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/recommendations.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/tv.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/tv_details.dart';
import 'package:dartz/dartz.dart';

import '../../../movies/domain/usecases/base.dart';
import '../entities/seasons.dart';
import '../usecases/base_tv.dart';

abstract class BaseTvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAir();

  Future<Either<Failure, List<Tv>>> getPopular();

  Future<Either<Failure, List<Tv>>> getTopRated();

  Future<Either<Failure, TvDetails>> getTvDetails(
    TvDetailsParameters parameters,
  );

  Future<Either<Failure, List<TvRecommendations>>> getRecommendations(
    RecommendationParameters parameters,
  );
  Future<Either<Failure, Season>> getSeason(SeasonParameters parameters);
}
