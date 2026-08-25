import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/movie_details.dart';
import '../repository/base_movies_repository.dart';
import 'base.dart';

class GetMovieDetailsUseCase implements BaseMovieUseCase<MovieDetail,MovieDetailsParameters> {
  final BaseMoviesRepository moviesRepository;


  GetMovieDetailsUseCase(this.moviesRepository);


  @override
  Future<Either<Failure, MovieDetail>> call(MovieDetailsParameters parameters) async{
    return await moviesRepository.getMovieDetails(parameters);
  }
}