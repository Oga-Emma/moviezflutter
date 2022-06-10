import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

class DeletedSavedMovieUseCase {
  MoviesRepo repo;
  DeletedSavedMovieUseCase(this.repo);

  Future<Resource<void>> call(int id) async {
    try {
      return Resource<void>.success((await repo.deleteMovie(id)));
    } catch (err) {
      return Resource.error("Error occurred");
    }
  }
}
