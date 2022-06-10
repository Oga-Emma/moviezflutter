import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

class GetTrendingMoviesUseCase {
  MoviesRepo repo;
  GetTrendingMoviesUseCase(this.repo);

  Future<Resource<MoviesList>> call(int page, String type) async {
    final result = await repo.trending(page, type);

    return result.fold((l) => Resource<MoviesList>.error(l.message),
        (r) => Resource<MoviesList>.success(r));
  }
}
