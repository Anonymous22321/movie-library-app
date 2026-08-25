import 'package:equatable/equatable.dart';

import 'genres.dart';

class MovieDetail extends Equatable {
  final String title, overview, backdropPath;
  final int movieId;
  final int runtime;
  final List<Genres> genres;
  final double voteAverage;
  final String releaseDate;

  const MovieDetail({
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.movieId,
    required this.runtime,
    required this.genres,
    required this.voteAverage,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
    title,
    overview,
    backdropPath,
    movieId,
    runtime,
    genres,
    voteAverage,
    releaseDate,
  ];

}
