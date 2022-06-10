import 'package:get/get.dart';
import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/usecase/get_trending_movies_use_case.dart';

class HomePageController extends GetxController {
  HomePageController({required this.getTrendingMoviesUseCase});
  final GetTrendingMoviesUseCase getTrendingMoviesUseCase;
  final trendingType = "Today".obs;
  set type(String type) {
    if (trendingType.value != type) {
      trendingType.value = type;
      getMovies(refresh: true);
    }
  }

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

    var type = "day";
    if (trendingType.value.contains("week")) {
      type = "week";
    }

    movies.value = Resource<MoviesList>.loading();
    movies.value = await getTrendingMoviesUseCase(1, type);
  }
}
