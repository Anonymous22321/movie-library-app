import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/recommendations.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/entities/tv_details.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/usecases/get_season_use_case.dart';
import 'package:get/get.dart';

import '../../../movies/domain/usecases/base.dart';
import '../../domain/entities/seasons.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/base_tv.dart';
import '../../domain/usecases/get_tv_details_use_case.dart';
import '../../domain/usecases/on_the_air_use_case.dart';
import '../../domain/usecases/popular_use_case.dart';
import '../../domain/usecases/recommendation_use_case.dart';
import '../../domain/usecases/top_rated_use_case.dart';

class TvController extends GetxController {
  final GetPopularTvUseCase getPopularUseCase;
  final GetTopRatedTvUseCase getTopRatedUseCase;
  final GetOnTheAirUseCase getOnTheAirUseCase;
  final GetTvDetailsUseCase getTvDetailsUseCase;
  final GetTvRecommendationsUseCase getTvRecommendationsUseCase;
  final GetSeasonUseCase getSeasonUseCase;

  /// Lists
  final RxList<Tv> popularTvList = <Tv>[].obs;
  final RxList<Tv> topRatedTvList = <Tv>[].obs;
  final RxList<Tv> onTheAirTvList = <Tv>[].obs;
  final RxList<TvRecommendations> recommendations = <TvRecommendations>[].obs;
  final RxList<Season> seasons = <Season>[].obs;

  final Rxn<TvDetails> tvDetails = Rxn<TvDetails>();

  /// error
  final RxnString errorMessage = RxnString();

  /// loading
  final RxBool _isLoading = false.obs;

  RxBool get isLoading => _isLoading;


  var selectedSeasonIndex = 0.obs;
  var selectedTab = 0.obs;

  // Method to update the index when a user selects a new season
  void changeSeason(int index) {
    selectedSeasonIndex.value = index;
  }
  void changeTab(int index) {
    selectedTab.value = index;
  }

  TvController({
    required this.getPopularUseCase,
    required this.getTopRatedUseCase,
    required this.getOnTheAirUseCase,
    required this.getTvDetailsUseCase,
    required this.getTvRecommendationsUseCase,
    required this.getSeasonUseCase,
  });

  @override
  void onInit() {
    fetchPopular();
    fetchTopRated();
    fetchOnTheAir();
    super.onInit();
  }

  Future<void> fetchPopular() async {
    _isLoading.value = true;
    final result = await getPopularUseCase(const NoParameters());
    result.fold(
      (failure) => errorMessage.value = failure.errMessage,
      (success) => popularTvList.value = success,
    );
    _isLoading.value = false;
  }

  Future<void> fetchTopRated() async {
    _isLoading.value = true;
    final result = await getTopRatedUseCase(const NoParameters());
    result.fold(
      (failure) => errorMessage.value = failure.errMessage,
      (success) => topRatedTvList.value = success,
    );
    _isLoading.value = false;
  }

  Future<void> fetchOnTheAir() async {
    _isLoading.value = true;
    final result = await getOnTheAirUseCase(const NoParameters());
    result.fold(
      (failure) => errorMessage.value = failure.errMessage,
      (success) => onTheAirTvList.value = success,
    );
    _isLoading.value = false;
  }

  Future<void> fetchTvDetails(int tvId) async {
    _isLoading.value = true;
    selectedSeasonIndex.value=0;
    final result = await getTvDetailsUseCase(TvDetailsParameters(tvId: tvId));
    result.fold(
      (failure) => errorMessage.value = failure.errMessage,
      (success) => tvDetails.value = success,
    );
    await fetchTvRecommendations(tvId);
    await fetchSeason(tvId, 1);
    _isLoading.value = false;
  }

  Future<void> fetchTvRecommendations(int tvId) async {
    _isLoading.value = true;
    final result = await getTvRecommendationsUseCase(
      RecommendationParameters(id: tvId),
    );
    result.fold(
      (failure) => errorMessage.value = failure.errMessage,
      (success) => recommendations.value = success,
    );
    _isLoading.value = false;
  }

  Future<void> fetchSeason(int tvId, int seasonNumber) async {
    _isLoading.value = true;
    seasons.clear();
    for (var i = 1; i <= tvDetails.value!.numberOfSeasons; i++) {
      final result = await getSeasonUseCase(
        SeasonParameters(tvId: tvId, seasonNumber: i),
      );
      result.fold(
        (failure) => errorMessage.value = failure.errMessage,
        (success) => seasons.add(success),
      );
    }
    _isLoading.value = false;
  }

  String? errorOccurred() {
    if(errorMessage.value != null){
      if(errorMessage.value!.contains("Invalid API")){
        return "Unauthorized request";
      }
      if(errorMessage.value!.contains("not be found")){
        return "TV not found";
      }
      else {
        return errorMessage.value!;
      }
    }
    return null;
  }

}
