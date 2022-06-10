import 'package:moviezflutter/core/utils/api_interceptor.dart';
import 'package:moviezflutter/core/utils/types.dart';
import 'package:moviezflutter/data/local/movie_db.dart';
import 'package:moviezflutter/data/remote/movies_api_service.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/domain/model/movie_details.dart';
import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

class MoviesRepoImpl implements MoviesRepo {
  MoviesRepoImpl(this.api, this.db);
  MoviesApiService api;
  MovieDb db;

  @override
  Future<ApiResponse<MoviesList>> trending(int page, String type) {
    return apiInterceptor(() async {
      final res = await api.getTrendingMovies(page, type);
      return MoviesList(
          hasNext: (res.page ?? 1) < (res.totalPages ?? 1),
          movies:
              (res.results ?? []).map((e) => Movie.fromMovieDto(e)).toList());
    });
  }

  @override
  Future<ApiResponse<MoviesList>> getMovies(int page) async {
    return apiInterceptor(() async {
      final res = await api.getMovies(page);
      return MoviesList(
          hasNext: (res.page ?? 1) < (res.totalPages ?? 1),
          movies:
              (res.results ?? []).map((e) => Movie.fromMovieDto(e)).toList());
    });
  }

  @override
  Future<ApiResponse<MoviesList>> searchMovie(int page, String query) {
    return apiInterceptor(() async {
      final res = await api.searchMovies(page, query);
      return MoviesList(
          hasNext: (res.page ?? 1) < (res.totalPages ?? 1),
          movies:
              (res.results ?? []).map((e) => Movie.fromMovieDto(e)).toList());
    });
  }

  @override
  Future<ApiResponse<MovieDetails>> getMovie(int page, id) {
    return apiInterceptor(() async {
      final res = await api.getMovie(page, id);
      return MovieDetails.fromDto(res);
    });
  }

  @override
  Future<List<Movie>> getSavedMovies() async {
    return db.getAllMovies();
  }

  @override
  Future<void> bookmarkMovie(Movie movie) async {
    return db.saveMovie(movie);
  }

  @override
  Future<void> deleteMovie(int id) async {
    return db.removeMovie(id);
  }
}
