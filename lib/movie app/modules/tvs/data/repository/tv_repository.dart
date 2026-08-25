import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/exceptions.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/failure.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/movies/domain/usecases/base.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/data/datasource/base_tv_remote_datasource.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/recommendations.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/seasons.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/tv.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/tv_details.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/repository/base_tv_repository.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/usecases/base_tv.dart';
import 'package:dartz/dartz.dart';

class TvRepository implements BaseTvRepository {
  final BaseTvRemoteDatasource baseTvRemoteDataSource;

  TvRepository(this.baseTvRemoteDataSource);

  @override
  Future<Either<Failure, List<Tv>>> getOnTheAir() async {
    try {
      final result = await baseTvRemoteDataSource.getOnTheAir();
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopular() async {
    try {
      final result = await baseTvRemoteDataSource.getPopular();
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRated() async {
    try {
      final result = await baseTvRemoteDataSource.getTopRated();
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TvDetails>> getTvDetails(
    TvDetailsParameters parameters,
  ) async {
    try {
      final result = await baseTvRemoteDataSource.getTvDetails(parameters);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TvRecommendations>>> getRecommendations(
    RecommendationParameters parameters,
  ) async {
    try {
      final result = await baseTvRemoteDataSource.getTvRecommendations(
        parameters,
      );
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Season>> getSeason(SeasonParameters parameters) async {
    try {
      final result = await baseTvRemoteDataSource.getSeason(parameters);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorModel.statusMessage));
    }
  }
}
