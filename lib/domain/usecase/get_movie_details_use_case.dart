import 'package:moviezflutter/domain/model/movie_details.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

class GetMovieDetailsUseCase {
  MoviesRepo repo;
  GetMovieDetailsUseCase(this.repo);

  Future<Resource<MovieDetails>> call(int page, id) async {
    final result = await repo.getMovie(page, id);

    return result.fold((l) => Resource<MovieDetails>.error(l.message),
        (r) => Resource<MovieDetails>.success(r));
  }
}
