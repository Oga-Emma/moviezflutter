import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviezflutter/data/local/movie_db.dart';
import 'package:moviezflutter/data/remote/movies_api_service.dart';
import 'package:moviezflutter/data/repository/movie_repo_impl.dart';

import '../fakes/fake_movie.dart';
import '../fakes/fake_movie_response_dto.dart';
import 'movie_repo_impl_test.mocks.dart';

@GenerateMocks([MovieDb, MoviesApiService])
void main() {
  late MoviesRepoImpl repository;
  late MovieDb db;
  late MoviesApiService apiService;

  setUp(() async {
    apiService = MockMoviesApiService();
    db = MockMovieDb();
    repository = MoviesRepoImpl(apiService, db);
  });

  group('MovieRepoImpl', () {
    group(".api", () {
      test("Should return trending movies from api", () async {
        when(apiService.getTrendingMovies(1, "test"))
            .thenAnswer((_) async => Future.value(movieResponse));

        final res = await repository.trending(1, "test");
        final data = res.fold((l) => throw Exception(l.message), (r) => r);
        expect(res.isRight(), true);
        expectLater(movieResponse.results!.length, data.movies.length);
      });

      test("Should return movies from api", () async {
        when(apiService.getMovies(1))
            .thenAnswer((_) async => Future.value(movieResponse));

        final res = await repository.getMovies(1);
        final data = res.fold((l) => throw Exception(l.message), (r) => r);
        expect(res.isRight(), true);
        expectLater(movieResponse.results!.length, data.movies.length);
      });

      test("Should return movies from api", () async {
        when(apiService.searchMovies(1, ""))
            .thenAnswer((_) async => Future.value(movieResponse));

        final res = await repository.searchMovie(1, "");
        final data = res.fold((l) => throw Exception(l.message), (r) => r);
        expect(res.isRight(), true);
        expectLater(movieResponse.results!.length, data.movies.length);
      });

      test("Should return movie details", () async {
        when(apiService.getMovie(1, 1))
            .thenAnswer((_) async => Future.value(singleMovieDetails));

        final res = await repository.getMovie(1, 1);
        final data = res.fold((l) => throw Exception(l.message), (r) => r);
        expect(res.isRight(), true);
        expectLater(singleMovieDetails.id, data.movieId);
      });
    });

    // bookmarkMovie
    // deleteMovie
    group(".db", () {
      test("Should return saved movies from db", () async {
        when(db.getAllMovies()).thenReturn(movieList);

        final res = await repository.getSavedMovies();
        expectLater(movieList[0].movieId, res[0].movieId);
      });

      test("Should call save movie with correct argument", () async {
        await repository.bookmarkMovie(movie);
        verify(db.saveMovie(movie)).called(1);
      });

      test("Should call delete movie with correct argument", () async {
        await repository.deleteMovie(1);
        verify(db.removeMovie(1)).called(1);
      });
    });
  });
}
