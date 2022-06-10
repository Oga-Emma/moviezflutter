import 'package:get/get.dart';
import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/usecase/get_movies_use_case.dart';

class DiscoverPageController extends GetxController {
  DiscoverPageController({required this.getMoviesUseCase});
  final GetMoviesUseCase getMoviesUseCase;

  @override
  void onReady() {
    getMovies();
    super.onReady();
  }

  final movies = Resource<MoviesList>.loading().obs;
  Future<void> getMovies({bool refresh = false}) async {
    if (!refresh && movies.value.isSuccess) {
      return;
    }

    movies.value = Resource<MoviesList>.loading();
    movies.value = await getMoviesUseCase(1);
  }
}
