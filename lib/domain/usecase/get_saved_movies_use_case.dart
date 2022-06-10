import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

class GetSavedMoviesUseCase {
  MoviesRepo repo;
  GetSavedMoviesUseCase(this.repo);

  Future<Resource<List<Movie>>> call() async {
    try {
      return Resource<List<Movie>>.success((await repo.getSavedMovies()));
    } catch (err) {
      return Resource.error("Error occurred");
    }
  }
}
