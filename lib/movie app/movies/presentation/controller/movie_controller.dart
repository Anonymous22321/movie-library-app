import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/entities/movie.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/entities/movie_details.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/entities/recommendation.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/usecases/get_movie_details.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/usecases/get_popular_movies.dart';
import 'package:get/get.dart';

import '../../domain/usecases/base.dart';
import '../../domain/usecases/get_recommendation.dart';
import '../../domain/usecases/get_top_rated_movies.dart';

class MovieController extends GetxController {
  /// usecases
  final GetNowPlayingMoviesUseCase _getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;
  final GetRecommendationUseCase _getRecommendationUseCase;

  MovieController(
    this._getNowPlayingMoviesUseCase,
    this._getPopularMoviesUseCase,
    this._getTopRatedMoviesUseCase,
    this._getMovieDetailsUseCase,
    this._getRecommendationUseCase,
  );

  /// Lists
  final RxList<Movie> nowPlayingMovies = <Movie>[].obs;
  final RxList<Movie> popularMovies = <Movie>[].obs;
  final RxList<Movie> topRatedMovies = <Movie>[].obs;
  final RxList<Recommendation> recommendationMovies = <Recommendation>[].obs;


  // State for holding a single movie details item
  // (Rxn represents a nullable observable)
  Rxn<MovieDetail> movieDetails = Rxn<MovieDetail>();
  RxInt currentScreen = 0.obs;

  /// error
  final RxnString error = RxnString();

  /// loading
  final RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    fetchNowPlayingMovies();
    fetchPopularMovies();
    fetchTopRatedMovies();
  }
void changeScreen(int index) {
    currentScreen.value = index;
}


  Future<void> fetchNowPlayingMovies() async {
    _isLoading.value = true;

    final result = await _getNowPlayingMoviesUseCase(const NoParameters());
    result.fold((fail) => error.value = fail.errMessage, (success) {
      nowPlayingMovies.value = success;
    });
    _isLoading.value = false;
  }

  Future<void> fetchPopularMovies() async {
    _isLoading.value = true;

    final result = await _getPopularMoviesUseCase(const NoParameters());
    result.fold((fail) => error.value = fail.errMessage, (success) {
      popularMovies.value = success;
      print(popularMovies[0]);
    });
    _isLoading.value = false;
  }

  Future<void> fetchTopRatedMovies() async {
    _isLoading.value = true;

    final result = await _getTopRatedMoviesUseCase(const NoParameters());
    result.fold((fail) => error.value = fail.errMessage, (success) {
      topRatedMovies.value = success;
    });
    _isLoading.value = false;
  }

  Future<void> fetchMovieDetails(int movieId) async {
    _isLoading.value = true;
    final result = await _getMovieDetailsUseCase(
      MovieDetailsParameters(movieId: movieId),
    );
    result.fold(
      (fail) => error.value = fail.errMessage,
      (success) => movieDetails.value = success,
    );
    await fetchRecommendation(movieId);
    _isLoading.value = false;
  }

  Future<void> fetchRecommendation(int movieId) async {
    _isLoading.value = true;
    final result = await _getRecommendationUseCase(
      RecommendationParameters(id: movieId),
    );
    result.fold(
      (fail) => error.value = fail.errMessage,
      (success) => recommendationMovies.value = success,
    );
    _isLoading.value = false;
  }

  String? errorOccurred() {
    if(error.value != null){
      if(error.value!.contains("Invalid API")){
        return "Unauthorized request";
      }
      if(error.value!.contains("not be found")){
        return "Movie not found";
      }
      else {
        return error.value!;
      }
    }
    return null;
  }
}
