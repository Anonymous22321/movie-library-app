import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/movie.dart';
import '../repository/base_movies_repository.dart';
import 'base.dart';

class GetNowPlayingMoviesUseCase implements BaseMovieUseCase<List<Movie>,NoParameters> {
  final BaseMoviesRepository moviesRepository;

  GetNowPlayingMoviesUseCase(this.moviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async{
    return await moviesRepository.getNowPlayingMovies();
  }

}
