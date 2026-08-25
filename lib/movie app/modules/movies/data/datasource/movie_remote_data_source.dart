import 'package:clean_architecture_and_solid_principles/movie%20app/core/api/api_consumer.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/core/api/dio_consumer.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';

import '../../domain/entities/movie_details.dart';
import '../../domain/usecases/base.dart';
import '../models/Recommendation_model.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';

abstract class BaseMovieRemoteDataSource
    implements
        GetPopularMovies,
        GetNowPlayingMovies,
        GetTopRatedMovies,
        GetMovieDetails,
        GetRecommendation {}

class MovieRemoteDataSource implements BaseMovieRemoteDataSource {
  final ApiConsumer _api;

  MovieRemoteDataSource({required ApiConsumer api}) : _api = api;

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await _api.get(
      movieBaseURL + MovieEndPoints.nowPlaying,
      queryParameters: {"api_key": apiKey},
    );
    return List<MovieModel>.from(
      (response[results] as List).map((e) => MovieModel.fromJson(e)),
    );
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await _api.get(
      movieBaseURL + MovieEndPoints.popular,
      queryParameters: {"api_key": apiKey},
    );
    return List<MovieModel>.from(
      (response[results] as List).map((e) => MovieModel.fromJson(e)),
    );
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await _api.get(
      movieBaseURL + MovieEndPoints.topRated,
      queryParameters: {"api_key": apiKey},
    );
    return List<MovieModel>.from(
      (response[results] as List).map((e) => MovieModel.fromJson(e)),
    );
  }

  @override
  Future<MovieDetail> getMovieDetails(MovieDetailsParameters parameters) async {
    final response = await _api.get(
      "$movieBaseURL/${parameters.movieId}",
      queryParameters: {"api_key": apiKey},
    );
    return MovieDetailsModel.fromJson(response);
  }

  @override
  Future<List<RecommendationModel>> getRecommendation(
    RecommendationParameters parameters,
  ) async {
    final result = await _api.get(
      "$movieBaseURL/${parameters.id}${MovieEndPoints.recommendations}",
      queryParameters: {"api_key": apiKey},
    );
    return List<RecommendationModel>.from(
      (result[results] as List).map((e) => RecommendationModel.fromJson(e)),
    );
  }

  // @override
  // Future<List<MovieModel>> get(
  //   String path, {
  //   Object? data,
  //   Map<String, dynamic>? queryParameters,
  // }) async {
  //   final response = await _api.get(
  //     "$movieBaseURL$endPoint",
  //     queryParameters: {"api_key": apiKey},
  //   );
  //   return List<MovieModel>.from(
  //     (response[results] as List).map((e) => MovieModel.fromJson(e)),
  //   );
  // }
}

abstract class GetPopularMovies {
  Future<List<MovieModel>> getPopularMovies();
}

abstract class GetNowPlayingMovies {
  Future<List<MovieModel>> getNowPlayingMovies();
}

mixin GetUpcomingMovies {
  final ApiConsumer _api = DioConsumer();

  Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await _api.get(
      movieBaseURL + MovieEndPoints.upComing,
      queryParameters: {"api_key": apiKey},
    );
    return List<MovieModel>.from(
      (response[results] as List).map((e) => MovieModel.fromJson(e)),
    );
  }
}

abstract class GetTopRatedMovies {
  Future<List<MovieModel>> getTopRatedMovies();
}

abstract class GetMovieDetails {
  Future<MovieDetail> getMovieDetails(MovieDetailsParameters parameters);
}

abstract class GetRecommendation {
  Future<List<RecommendationModel>> getRecommendation(
    RecommendationParameters parameters,
  );
}
