import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';

import '../../domain/entities/recommendations.dart';

class TvRecommendationsModel extends TvRecommendations {
  const TvRecommendationsModel({required super.backdropPath, required super.tvId});

  factory TvRecommendationsModel.fromJson(Map<String, dynamic> json) {
    return TvRecommendationsModel(
      backdropPath: json[backdropPath],
      tvId: json[id],
    );
  }
}
