import 'package:equatable/equatable.dart';

class Recommendation extends Equatable{
  final int movieId;
  final String backdropPath;

  const Recommendation({
    required this.movieId,
    required this.backdropPath,
  });

  @override
  List<Object?> get props => [movieId,backdropPath];
}
