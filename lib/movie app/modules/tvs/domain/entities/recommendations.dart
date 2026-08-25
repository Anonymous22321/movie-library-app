import 'package:equatable/equatable.dart';

abstract class TvRecommendations extends Equatable {
  final String backdropPath;
  final int tvId;

  const TvRecommendations({required this.backdropPath, required this.tvId});

  @override
  List<Object?> get props => [backdropPath, tvId];
}
