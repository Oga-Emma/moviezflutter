import 'package:moviezflutter/core/utils/types.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/domain/model/movie_details.dart';
import 'package:moviezflutter/domain/model/movies_list.dart';

abstract class MoviesRepo {
  Future<ApiResponse<MoviesList>> getMovies(int page);
  Future<ApiResponse<MoviesList>> trending(int page, String type);
  Future<ApiResponse<MoviesList>> searchMovie(int page, String query);
  Future<ApiResponse<MovieDetails>> getMovie(int page, id);

  //db operations
  Future<List<Movie>> getSavedMovies();
  Future<void> bookmarkMovie(Movie movie);
  Future<void> deleteMovie(int id);
}
