import 'package:clean_architecture_and_solid_principles/movie%20app/core/utilizes/constance.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/movies/domain/entities/movie_details.dart';

import '../../domain/entities/genres.dart';

class MovieDetailsModel extends MovieDetail {
  const MovieDetailsModel({
    required super.title,
    required super.overview,
    required super.backdropPath,
    required super.movieId,
    required super.runtime,
    required super.genres,
    required super.voteAverage,
    required super.releaseDate,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      title: json[title],
      overview: json[overview],
      backdropPath: json[backdropPath]??'',
      movieId: json[ id],
      runtime: json[ runtime],
      genres: List<Genres>.from( json[genres].map((e) => Genres.fromJson(e))),
      voteAverage: json[ voteAverage].toDouble(),
      releaseDate: json[ releaseDate],
    );
  }
}
