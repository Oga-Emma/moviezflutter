import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

class BookmarkMovieUseCase {
  MoviesRepo repo;
  BookmarkMovieUseCase(this.repo);

  Future<Resource<void>> call(Movie movie) async {
    try {
      return Resource<void>.success((await repo.bookmarkMovie(movie)));
    } catch (err) {
      return Resource.error("Error occurred");
    }
  }
}
