import 'package:clean_architecture_and_solid_principles/movie%20app/core/api/api_consumer.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/core/api/dio_consumer.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/features/notifications/presentation/controller/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '../../modules/movies/data/datasource/movie_remote_data_source.dart';
import '../../modules/movies/data/repository/movie_repository.dart';
import '../../modules/movies/domain/repository/base_movies_repository.dart';
import '../../modules/movies/domain/usecases/get_movie_details.dart';
import '../../modules/movies/domain/usecases/get_now_playing_movies.dart';
import '../../modules/movies/domain/usecases/get_popular_movies.dart';
import '../../modules/movies/domain/usecases/get_recommendation.dart';
import '../../modules/movies/domain/usecases/get_top_rated_movies.dart';
import '../../modules/movies/presentation/controller/movie_controller.dart';
import '../../modules/tvs/data/datasource/base_tv_remote_datasource.dart';
import '../../modules/tvs/data/repository/tv_repository.dart';
import '../../modules/tvs/domain/repository/base_tv_repository.dart';
import '../../modules/tvs/domain/usecases/get_season_use_case.dart';
import '../../modules/tvs/domain/usecases/get_tv_details_use_case.dart';
import '../../modules/tvs/domain/usecases/on_the_air_use_case.dart';
import '../../modules/tvs/domain/usecases/popular_use_case.dart';
import '../../modules/tvs/domain/usecases/recommendation_use_case.dart';
import '../../modules/tvs/domain/usecases/top_rated_use_case.dart';
import '../../modules/tvs/presentation/controller/tv_controller.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  /// Movie Use Cases
  getIt.registerLazySingleton(
    () => GetNowPlayingMoviesUseCase(getIt<BaseMoviesRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetPopularMoviesUseCase(getIt<BaseMoviesRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetTopRatedMoviesUseCase(getIt<BaseMoviesRepository>()),
  );

  getIt.registerLazySingleton(
    () => GetMovieDetailsUseCase(getIt<BaseMoviesRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetRecommendationUseCase(
      baseMoviesRepository: getIt<BaseMoviesRepository>(),
    ),
  );

  /// Tv Use Cases
  getIt.registerLazySingleton(
    () => GetOnTheAirUseCase(getIt<BaseTvRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetPopularTvUseCase(getIt<BaseTvRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetTopRatedTvUseCase(getIt<BaseTvRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetTvDetailsUseCase(getIt<BaseTvRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetTvRecommendationsUseCase(getIt<BaseTvRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetSeasonUseCase(getIt<BaseTvRepository>()),
  );

  /// Repository
  getIt.registerLazySingleton<BaseMoviesRepository>(
    () => MovieRepository(getIt<BaseMovieRemoteDataSource>()),
  );

  getIt.registerLazySingleton<BaseTvRepository>(
    () => TvRepository(getIt<BaseTvRemoteDatasource>()),
  );

  /// Data Source
  getIt.registerLazySingleton<BaseMovieRemoteDataSource>(
    () => MovieRemoteDataSource(api: getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<BaseTvRemoteDatasource>(
    () => TvRemoteDatasource(api: getIt<ApiConsumer>()),
  );

  /// Api Consumer
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer());

  /// Firebase Messaging
  getIt.registerLazySingleton<FirebaseMessaging>(
    () => FirebaseMessaging.instance,
  );

  /// Controller
  getIt.registerFactory<MovieController>(
    () => MovieController(
      getIt<GetNowPlayingMoviesUseCase>(),
      getIt<GetPopularMoviesUseCase>(),
      getIt<GetTopRatedMoviesUseCase>(),
      getIt<GetMovieDetailsUseCase>(),
      getIt<GetRecommendationUseCase>(),
    ),
  );
  getIt.registerFactory<TvController>(
    () => TvController(
      getPopularUseCase: getIt<GetPopularTvUseCase>(),
      getTopRatedUseCase: getIt<GetTopRatedTvUseCase>(),
      getOnTheAirUseCase: getIt<GetOnTheAirUseCase>(),
      getTvDetailsUseCase: getIt<GetTvDetailsUseCase>(),
      getTvRecommendationsUseCase: getIt<GetTvRecommendationsUseCase>(),
      getSeasonUseCase: getIt<GetSeasonUseCase>(),
    ),
  );
  // Exception For notification as notifications are app-wide background services.
  getIt.registerSingleton<NotificationController>(
    NotificationController(getIt<FirebaseMessaging>()),
  );
}
