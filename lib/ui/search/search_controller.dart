import 'package:get/get.dart';
import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/usecase/search_movies_use_case.dart';

class SearchController extends GetxController {
  SearchController({required this.searchMovieUseCase});
  final SearchMoviesUseCase searchMovieUseCase;

  final movies = Resource<MoviesList>.loading().obs;
  Future<void> searchMovie(String query) async {
    movies.value = Resource<MoviesList>.loading();
    movies.value = await searchMovieUseCase(1, query);
  }
}
