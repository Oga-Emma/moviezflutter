import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

class GetMoviesUseCase {
  MoviesRepo repo;
  GetMoviesUseCase(this.repo);

  Future<Resource<MoviesList>> call(int page) async {
    final result = await repo.getMovies(page);

    return result.fold((l) => Resource<MoviesList>.error(l.message),
        (r) => Resource<MoviesList>.success(r));
  }
}
