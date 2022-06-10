import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/objectbox.g.dart';

abstract class MovieDb {
  void saveMovie(Movie movie);
  void removeMovie(int id);
  List<Movie> getAllMovies();
}

class MovieDbImpl implements MovieDb {
  /// The Store of this app.
  late final Store store;
  late final Box<Movie> movieBox;

  MovieDbImpl._create(this.store) {
    movieBox = store.box<Movie>();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<MovieDbImpl> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return MovieDbImpl._create(store);
  }

  @override
  List<Movie> getAllMovies() {
    return movieBox.getAll();
  }

  @override
  void saveMovie(Movie movie) {
    print("saving");
    final res = movieBox.put(movie);
    print("saved");
    print("saved => ${res}");

    print(movieBox.getAll());
  }

  @override
  void removeMovie(int id) {
    movieBox.remove(id);
  }
}
