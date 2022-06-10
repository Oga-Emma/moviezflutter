import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/domain/model/movie_details.dart';
import 'package:moviezflutter/domain/model/resource.dart';
import 'package:moviezflutter/domain/usecase/bookmark_movie_use_case.dart';
import 'package:moviezflutter/domain/usecase/delete_saved_movie_use_case.dart';
import 'package:moviezflutter/domain/usecase/get_movie_details_use_case.dart';
import 'package:moviezflutter/domain/usecase/get_saved_movies_use_case.dart';
import 'package:moviezflutter/ui/home/saved/saved_page_controller.dart';

class MovieDetailsController extends GetxController {
  MovieDetailsController({
    required this.getMovieDetailsUseCase,
    required this.getSavedMoviesUseCase,
    required this.bookmarkMovieUseCase,
    required this.deletedSavedMovieUseCase,
  });

  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetSavedMoviesUseCase getSavedMoviesUseCase;
  final BookmarkMovieUseCase bookmarkMovieUseCase;
  final DeletedSavedMovieUseCase deletedSavedMovieUseCase;

  late final ScrollController scrollController;
  final animValue = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    getSavedMovies(force: true);
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset <= 150) {
          animValue.value = (150 - scrollController.offset) / 150;
        }
      });
  }

  final cache = <dynamic, Resource<MovieDetails>>{};
  final movie = Resource<MovieDetails>.loading().obs;
  Future<void> getMovie(id) async {
    movie.value = Resource<MovieDetails>.loading();

    if (!cache.containsKey(id) || cache[id]!.status != Status.success) {
      final res = await getMovieDetailsUseCase(1, id);
      cache[id] = res;
    }

    movie.value = cache[id]!;
  }

  final savedMovies = Resource<List<Movie>>.loading().obs;
  Future<void> getSavedMovies({bool force = false}) async {
    if (force || !savedMovies.value.isSuccess) {
      savedMovies.value = Resource<List<MovieDetails>>.loading();
      savedMovies.value = await getSavedMoviesUseCase();
    }
  }

  void bookmarkMovie(Movie movie) {
    bookmarkMovieUseCase(movie).then((value) => refreshList());
  }

  void removeBookmark(int id) {
    deletedSavedMovieUseCase(id).then((value) => refreshList());
  }

  void refreshList() {
    getSavedMovies(force: true);
    Get.find<SavedPageController>().getMovies(refresh: true);
  }
}
