import 'package:equatable/equatable.dart';

abstract class Tv extends Equatable{
  final String name;
  final String overview;
  final String backdropPath;
  final int tvId;
  final List<int> genreIds;
  final double voteAverage;
  final String firstAirDate;

 const Tv(this.name, this.overview, this.backdropPath, this.tvId, this.genreIds,
      this.voteAverage, this.firstAirDate);
  @override
  List<Object> get props => [
        name,
        overview,
        backdropPath,
        tvId,
        genreIds,
        voteAverage,
        firstAirDate,
  ];
}