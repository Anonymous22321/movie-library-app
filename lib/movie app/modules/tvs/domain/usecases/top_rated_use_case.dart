import 'package:clean_architecture_and_solid_principles/movie%20app/core/errors/failure.dart';
import 'package:clean_architecture_and_solid_principles/movie%20app/modules/tvs/domain/usecases/base_tv.dart';
import 'package:dartz/dartz.dart';

import '../../../movies/domain/usecases/base.dart';
import '../entities/tv.dart';
import '../repository/base_tv_repository.dart';

class GetTopRatedTvUseCase extends BaseTvUseCase<List<Tv>, NoParameters>{
  final BaseTvRepository tvRepository;
  GetTopRatedTvUseCase(this.tvRepository);
  @override
  Future<Either<Failure, List<Tv>>> call(NoParameters parameters) async{
   return await tvRepository.getTopRated();
  }

}