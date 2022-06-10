import 'package:moviezflutter/data/dto/movie_details_dto.dart';
import 'package:moviezflutter/domain/model/movie.dart';

class MovieDetails extends Movie {
  MovieDetails({
    var adult,
    var backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    var movieId,
    this.imdbId,
    var originalLanguage,
    this.originalTitle,
    var overview,
    var popularity,
    var posterPath,
    this.productionCompanies,
    this.productionCountries,
    var releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    var title,
    var video,
    var voteAverage,
    var voteCount,
  }) : super(
          movieId: movieId,
          adult: adult,
          backdropPath: backdropPath,
          originalLanguage: originalLanguage,
          overview: overview,
          posterPath: posterPath,
          releaseDate: releaseDate,
          title: title,
          video: video,
          voteAverage: double.parse("$voteAverage").toInt(),
          voteCount: double.parse("$voteCount").toInt(),
        );

  factory MovieDetails.fromDto(MovieDetailsDto dto) {
    return MovieDetails(
      adult: dto.adult,
      backdropPath: dto.backdropPath,
      belongsToCollection: dto.belongsToCollection,
      budget: dto.budget,
      genres: dto.genres,
      homepage: dto.homepage,
      movieId: dto.id ?? 0,
      imdbId: dto.imdbId,
      originalLanguage: dto.originalLanguage,
      originalTitle: dto.originalTitle,
      overview: dto.overview,
      popularity: dto.popularity,
      posterPath: dto.posterPath,
      productionCompanies: dto.productionCompanies,
      productionCountries: dto.productionCountries,
      releaseDate: dto.releaseDate,
      revenue: dto.revenue,
      runtime: dto.runtime,
      spokenLanguages: dto.spokenLanguages,
      status: dto.status,
      tagline: dto.tagline,
      title: dto.title,
      video: dto.video,
      voteAverage: dto.voteAverage,
      voteCount: dto.voteCount,
    );
  }

  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  String? imdbId;
  String? originalTitle;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
}
