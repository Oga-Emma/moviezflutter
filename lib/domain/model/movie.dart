import 'package:moviezflutter/data/dto/movie_response_dto.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Movie {
  Movie({
    this.title = "",
    this.adult = false,
    this.backdropPath = "",
    this.id = 0,
    this.movieId = 0,
    this.originalLanguage = "",
    this.overview = "",
    this.posterPath = "",
    this.releaseDate = "",
    this.firstAired = "",
    this.video = false,
    this.voteAverage = 0,
    this.voteCount = 0,
  });

  factory Movie.fromMovieDto(MovieDto movie) {
    return Movie(
      adult: movie.adult ?? false,
      backdropPath: movie.backdropPath ?? "",
      movieId: movie.id,
      originalLanguage: movie.originalLanguage ?? "",
      overview: movie.overview ?? "",
      posterPath: movie.posterPath ?? "",
      releaseDate: movie.date ?? "",
      title: movie.movieTitle,
      video: movie.video ?? false,
      voteAverage: double.parse("${movie.voteAverage}").toInt(),
      voteCount: double.parse("${movie.voteCount}").toInt(),
    );
  }

  bool adult;
  String backdropPath;
  int movieId;
  int id;
  String originalLanguage;
  String overview;
  String posterPath;
  String releaseDate;
  String firstAired;
  String title;
  bool video;
  int voteAverage;
  int voteCount;

  int get rating => (5 - (voteAverage % 5)).toInt();
}
