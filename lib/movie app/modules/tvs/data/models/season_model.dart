import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';

import '../../domain/entities/seasons.dart';
import 'episodes_model.dart';

class SeasonModel extends Season {
  const SeasonModel({
    required super.name,
    required super.episodes,
    required super.seasonId,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) {
    return SeasonModel(
      name: json[name],
      episodes: List<EpisodesModel>.from(
        json[episodes].map((episode) => EpisodesModel.fromJson(episode)),
      ),
      seasonId: json[id],
    );
  }
}
