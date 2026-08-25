 import 'package:equatable/equatable.dart';


/// TODO: Add movie length to the Movie class
abstract class Movie extends Equatable {
final  String title, overview, backdropPath;
final  int movieId;
final  List<int> genres;
final  double voteAverage;
final  String releaseDate;

  const Movie({
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.movieId,
    required this.genres,
    required this.voteAverage,
    required this.releaseDate,
  });
/// Equatable to make it easy to compare objects.
/// Depends on XOR Gate in Logic Gates, its simbol is ^(Bitwise operator).
/// We can use also Equatable package
// @override
// bool operator ==(Object other) =>
//     identical(this, other) ||
//         other is Movie && runtimeType == other.runtimeType &&
//             title == other.title && overview == other.overview &&
//             backdropPath == other.backdropPath && movieId == other.movieId &&
//             genres == other.genres && voteAverage == other.voteAverage &&
//             releaseDate == other.releaseDate;
//
// @override
// int get hashCode =>
//     Object.hash(
//         title,
//         overview,
//         backdropPath,
//         movieId,
//         genres,
//         voteAverage,
//         releaseDate);

  @override
  List<Object?> get props => [
    title,
    overview,
    backdropPath,
    movieId,
    genres,
    voteAverage,
    releaseDate,
  ];




 }
