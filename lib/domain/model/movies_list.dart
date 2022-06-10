import 'package:moviezflutter/domain/model/movie.dart';

class MoviesList {
  final bool hasNext;
  final List<Movie> movies;

  MoviesList({
    required this.hasNext,
    required this.movies,
  });
}
