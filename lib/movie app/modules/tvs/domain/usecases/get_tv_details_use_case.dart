import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../entities/tv_details.dart';
import '../repository/base_tv_repository.dart';
import 'base_tv.dart';

class GetTvDetailsUseCase
    implements BaseTvUseCase<TvDetails, TvDetailsParameters> {
  final BaseTvRepository tvRepository;

  GetTvDetailsUseCase(this.tvRepository);

  @override
  Future<Either<Failure, TvDetails>> call(TvDetailsParameters parameters) async
  {
    return await tvRepository.getTvDetails(parameters);
  }
}
