import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';

import '../../domain/entities/episodes.dart';

class EpisodesModel extends Episodes {
  const EpisodesModel({
    required super.name,
    required super.overview,
    required super.stillPath,
    required super.airDate,
    required super.episodeNumber,
    required super.seasonNumber,
    required super.episodeId,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) {
    return EpisodesModel(
      name: json[name],
      overview: json[overview],
      stillPath: json[stillPath]??'',
      airDate: json[airDate],
      episodeNumber: json[episodeNumber],
      seasonNumber: json[seasonNumber],
      episodeId: json[showId],
    );
  }
}
