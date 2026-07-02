
import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/entities/genres.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/tvs/domain/entities/tv_details.dart';

class TvDetailsModel extends TvDetails {
  const TvDetailsModel({
    required super.name,
    required super.overview,
    required super.backdropPath,
    required super.tvId,
    required super.genres,
    required super.voteAverage,
    required super.firstAirDate,
    required super.runtime,
    required super.numberOfSeasons,
  });

  factory TvDetailsModel.fromJson(Map<String, dynamic> json) {
    final runtimeList = json['episode_run_time'] as List?;
    return TvDetailsModel(
      name: json[name],
      overview: json[overview],
      backdropPath: json[backdropPath]??'',
      tvId: json[id],
      genres: List.from(json[genres].map((genre) => Genres.fromJson(genre))),
      voteAverage: json[voteAverage],
      firstAirDate: json[firstAirDate],
      runtime:(runtimeList != null && runtimeList.isNotEmpty)
          ? runtimeList[0] as int
          : 0,
      numberOfSeasons: json[numberOfSeasons],
    );
  }
}
