import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviezflutter/domain/model/movies_list.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';
import 'package:moviezflutter/domain/usecase/get_movies_use_case.dart';

import '../fakes/fake_movie.dart';
import '../fakes/fake_movie_repository.dart';
import 'repo.mocks.dart';

@GenerateMocks([MoviesRepo])
void main() {
  late MoviesRepo repository;

  group('GetSavedMovieUseCase', () {
    test("Should call repository method", () async {
      //given
      repository = MockMoviesRepo();
      final useCase = GetMoviesUseCase(repository);
      when(repository.getMovies(1)).thenAnswer(
          (_) async => Right(MoviesList(hasNext: true, movies: movieList)));

      //when
      final res = await useCase(1);

      //then
      verify(repository.getMovies(1)).called(1);
    });

    test("Should return correct response from repository", () async {
      repository = FakeMovieRepo();
      final useCase = GetMoviesUseCase(repository);

      final res = await useCase(1);
      expect(res.isSuccess, true);
    });
  });
}
