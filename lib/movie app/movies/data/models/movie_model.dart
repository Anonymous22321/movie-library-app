import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';

import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.title,
    required super.overview,
    required super.backdropPath,
    required super.movieId,
    required super.genres,
    required super.voteAverage,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json[title],
      overview: json[overview],
      backdropPath: json[backdropPath]??'',
      movieId: json[id],
      genres: List<int>.from(json[genreIds].map((e) => e)),
      voteAverage: json[voteAverage].toDouble(),
      releaseDate: json[releaseDate],
    );
  }
}
