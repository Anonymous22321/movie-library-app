import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';

import '../../domain/entities/tv.dart';

class TvModel extends Tv {
  const TvModel(
    super.name,
    super.overview,
    super.backdropPath,
    super.tvId,
    super.genres,
    super.voteAverage,
    super.firstAirDate,
  );

  factory TvModel.fromJson(Map<String, dynamic> json) {
    return TvModel(
      json[name],
      json[overview],
      json[backdropPath],
      json[id],
      List.from(json[genreIds].map((genre) => genre)),
      json[voteAverage],
      json[firstAirDate],
    );
  }
}
