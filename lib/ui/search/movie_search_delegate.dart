import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moviezflutter/ui/components/grid/movies_grid_view.dart';
import 'package:moviezflutter/ui/components/loading_widget.dart';
import 'package:moviezflutter/ui/search/search_controller.dart';

class MovieSearchDelegate extends SearchDelegate {
  SearchController get controller => Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    controller.searchMovie(query.trim());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        final movies = controller.movies.value;

        if (movies.data != null) {
          return MoviesGridView(moviesList: movies.data!);
        }

        if (movies.errorMessage != null && movies.errorMessage!.isNotEmpty) {
          return const Text("Error");
        }

        return const LoadingWidget();
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
