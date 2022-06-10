import 'package:get/get.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/usecase/get_saved_movies_use_case.dart';

class SavedPageController extends GetxController {
  SavedPageController({required this.getSavedMoviesUseCase});
  final GetSavedMoviesUseCase getSavedMoviesUseCase;

  @override
  void onReady() {
    getMovies();
    super.onReady();
  }

  final movies = Resource<List<Movie>>.loading().obs;
  Future<void> getMovies({bool refresh = false}) async {
    if (!refresh && movies.value.isSuccess) {
      return;
    }
    movies.value = Resource<List<Movie>>.loading();
    movies.value = await getSavedMoviesUseCase();
  }

  final filter = "".obs;
  List<Movie> get movieList => (movies.value.data ?? [])
      .where((element) => element.title.toLowerCase().contains(filter.value))
      .toList();
}
