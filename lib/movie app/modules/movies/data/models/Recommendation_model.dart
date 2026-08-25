import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';

import '../../domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({
    required super.movieId,
    required super.backdropPath,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      movieId: json[id],
      backdropPath: json[backdropPath],
    );
  }
}
