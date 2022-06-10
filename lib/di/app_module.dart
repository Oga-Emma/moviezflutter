import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/core/config/network_manager.dart';
import 'package:moviezflutter/data/local/movie_db.dart';
import 'package:moviezflutter/data/remote/movies_api_service.dart';
import 'package:moviezflutter/data/repository/movie_repo_impl.dart';
import 'package:moviezflutter/domain/repository/movies_repo.dart';
import 'package:moviezflutter/domain/usecase/bookmark_movie_use_case.dart';
import 'package:moviezflutter/domain/usecase/delete_saved_movie_use_case.dart';
import 'package:moviezflutter/domain/usecase/get_movie_details_use_case.dart';
import 'package:moviezflutter/domain/usecase/get_movies_use_case.dart';
import 'package:moviezflutter/domain/usecase/get_saved_movies_use_case.dart';
import 'package:moviezflutter/domain/usecase/get_trending_movies_use_case.dart';
import 'package:moviezflutter/domain/usecase/search_movies_use_case.dart';
import 'package:moviezflutter/ui/details/movie_details_controller.dart';
import 'package:moviezflutter/ui/home/discover/discover_page_controller.dart';
import 'package:moviezflutter/ui/home/home/home_page_controller.dart';
import 'package:moviezflutter/ui/home/home_screen_controller.dart';
import 'package:moviezflutter/ui/home/saved/saved_page_controller.dart';
import 'package:moviezflutter/ui/search/search_controller.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    //Utils
    Get.put(Connectivity(), permanent: true);
    Get.put(NetworkManager(Get.find()), permanent: true);

    //db
    final db = await MovieDbImpl.create();
    Get.put<MovieDb>(db, permanent: true);

    //data layer
    Get.lazyPut<MoviesApiService>(() => MoviesApiServiceImpl());
    Get.lazyPut<MoviesRepo>(() => MoviesRepoImpl(Get.find(), Get.find()));

    //use cases
    Get.lazyPut(() => GetMoviesUseCase(Get.find()));
    Get.lazyPut(() => GetTrendingMoviesUseCase(Get.find()));
    Get.lazyPut(() => SearchMoviesUseCase(Get.find()));
    Get.lazyPut(() => GetMovieDetailsUseCase(Get.find()));
    Get.lazyPut(() => GetSavedMoviesUseCase(Get.find()));
    Get.lazyPut(() => BookmarkMovieUseCase(Get.find()));
    Get.lazyPut(() => DeletedSavedMovieUseCase(Get.find()));

    //controller
    Get.put(DiscoverPageController(getMoviesUseCase: Get.find()));
    Get.put(SavedPageController(getSavedMoviesUseCase: Get.find()));

    Get.put(MovieDetailsController(
        getMovieDetailsUseCase: Get.find(),
        getSavedMoviesUseCase: Get.find(),
        bookmarkMovieUseCase: Get.find(),
        deletedSavedMovieUseCase: Get.find()));
    Get.lazyPut(() => SearchController(searchMovieUseCase: Get.find()),
        fenix: true);

    Get.put(HomePageController(getTrendingMoviesUseCase: Get.find()));

    Get.put(HomeScreenController(
        connectivityManager: Get.find(), networkManager: Get.find()));

    await Future.delayed(Duration.zero);
  }
}
