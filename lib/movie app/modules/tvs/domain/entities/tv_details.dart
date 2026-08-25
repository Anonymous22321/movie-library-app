import 'package:equatable/equatable.dart';

import '../../../movies/domain/entities/genres.dart';

abstract class TvDetails extends Equatable {
  const TvDetails({
    required this.name,
    required this.overview,
    required this.backdropPath,
    required this.tvId,
    required this.genres,
    required this.voteAverage,
    required this.firstAirDate,
    required this.runtime,
    required this.numberOfSeasons,
  });

  final String name;
  final String overview;
  final String backdropPath;
  final int tvId;
  final List<Genres> genres;
  final double voteAverage;
  final String firstAirDate;
  final int runtime;
  final int numberOfSeasons;

  @override
  List<Object> get props => [
    name,
    overview,
    backdropPath,
    tvId,
    genres,
    voteAverage,
    firstAirDate,
    runtime,
    numberOfSeasons,
  ];
}
