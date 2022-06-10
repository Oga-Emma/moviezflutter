import 'dart:convert';

MovieResponseDto movieResponseDtoFromJson(String str) =>
    MovieResponseDto.fromJson(json.decode(str));
String movieResponseDtoToJson(MovieResponseDto data) =>
    json.encode(data.toJson());

class MovieResponseDto {
  MovieResponseDto({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MovieResponseDto.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(MovieDto.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  var page;
  List<MovieDto>? results;
  var totalPages;
  var totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}

MovieDto resultsFromJson(String str) => MovieDto.fromJson(json.decode(str));
String resultsToJson(MovieDto data) => json.encode(data.toJson());

class MovieDto {
  MovieDto({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.firstAired,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  MovieDto.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<int>() : [];
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    firstAired = json['first_air_date'];
    title = json['title'];
    name = json['name'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  var id;
  String? originalLanguage;
  String? originalTitle;
  String? originalName;
  String? overview;
  var popularity;
  String? posterPath;
  String? releaseDate;
  String? firstAired;
  String? title;
  String? name;
  bool? video;
  var voteAverage;
  var voteCount;

  String? get date => releaseDate ?? firstAired;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdrop_path'] = backdropPath;
    map['genre_ids'] = genreIds;
    map['id'] = id;
    map['original_language'] = originalLanguage;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['poster_path'] = posterPath;
    map['release_date'] = releaseDate;
    map['first_air_date'] = firstAired;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }

  String get movieTitle =>
      name ?? title ?? originalTitle ?? originalName ?? "N/A";
}
