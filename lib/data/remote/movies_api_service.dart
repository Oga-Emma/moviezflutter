import 'package:moviezflutter/core/config/app_connect.dart';
import 'package:moviezflutter/core/config/application.dart';
import 'package:moviezflutter/data/dto/movie_details_dto.dart';
import 'package:moviezflutter/data/dto/movie_response_dto.dart';

abstract class MoviesApiService {
  Future<MovieResponseDto> getMovies(int page);
  Future<MovieResponseDto> getTrendingMovies(int page, String type);
  Future<MovieResponseDto> searchMovies(int page, String query);
  Future<MovieDetailsDto> getMovie(int page, var id);
}

class MoviesApiServiceImpl extends AppConnect implements MoviesApiService {
  @override
  Future<MovieResponseDto> getMovies(int page) async {
    final res = await get_("3/discover/movie", query: {
      "api_key": Application.apiKey,
      "page": "$page",
    });
    return MovieResponseDto.fromJson(res);
  }

  @override
  Future<MovieResponseDto> getTrendingMovies(int page, String type) async {
    final res = await get_("3/trending/all/$type", query: {
      "api_key": Application.apiKey,
      "page": "$page",
    });
    return MovieResponseDto.fromJson(res);
  }

  @override
  Future<MovieResponseDto> searchMovies(int page, String query) async {
    final res = await get_("3/search/movie", query: {
      "api_key": Application.apiKey,
      "page": "$page",
      "query": query,
    });
    return MovieResponseDto.fromJson(res);
  }

  @override
  Future<MovieDetailsDto> getMovie(int page, id) async {
    final res = await get_("3/movie/$id", query: {
      "api_key": Application.apiKey,
    });

    return MovieDetailsDto.fromJson(res);
  }
}
