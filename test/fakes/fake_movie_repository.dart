import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:moviezflutter/core/utils/types.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/domain/model/movie_details.dart';
import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';

import 'fake_movie.dart';

class FakeMovieRepo extends Fake implements MoviesRepo {
  @override
  Future<ApiResponse<MovieDetails>> getMovie(int page, id) async {
    return Right(movieDetail);
  }

  @override
  Future<ApiResponse<MoviesList>> getMovies(int page) async {
    return Right(MoviesList(hasNext: false, movies: movieList));
  }

  @override
  Future<List<Movie>> getSavedMovies() async {
    return movieList;
  }

  @override
  Future<ApiResponse<MoviesList>> searchMovie(int page, String query) async {
    return Right(MoviesList(hasNext: false, movies: movieList));
  }

  @override
  Future<ApiResponse<MoviesList>> trending(int page, String type) async {
    return Right(MoviesList(hasNext: false, movies: movieList));
  }
}
