import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';


abstract class BaseTvUseCase<T, P> {
  Future<Either<Failure, T>> call(P parameters);
}

class TvDetailsParameters extends Equatable {
  final int tvId;

  const TvDetailsParameters({required this.tvId});

  @override
  List<Object?> get props => [tvId];
}

class SeasonParameters extends Equatable {
  final int tvId, seasonNumber;

  const SeasonParameters({required this.tvId, required this.seasonNumber});

  @override
  List<Object?> get props => [tvId, seasonNumber];
}
