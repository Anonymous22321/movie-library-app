import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';


/// making callable class to use it as function and make abstract class
/// to avoid name conflict when working with others.

abstract class BaseMovieUseCase<T, P> {
  Future<Either<Failure, T>> call(P parameters);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object?> get props => [];
}

class MovieDetailsParameters extends Equatable {
  final int movieId;
  const MovieDetailsParameters({required this.movieId});
  @override
  List<Object?> get props => [movieId];
}

class RecommendationParameters extends Equatable {
  final int id;

  const RecommendationParameters({required this.id});

  @override
  List<Object?> get props => [id];
}

