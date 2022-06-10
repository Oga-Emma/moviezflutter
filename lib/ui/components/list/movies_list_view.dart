import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/ui/components/empty_state_widget.dart';
import 'package:moviezflutter/ui/components/list/movie_list_item.dart';
import 'package:moviezflutter/ui/details/movie_details_screen.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({Key? key, required this.moviesList}) : super(key: key);
  final List<Movie> moviesList;

  @override
  Widget build(BuildContext context) {
    if (moviesList.isEmpty) {
      return const EmptyStateWidget(
        heading: 'No saved movies',
        body: 'Movies you saved will appear here',
      );
    }
    return ListView.separated(
      itemCount: moviesList.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieListItem(
            movie: moviesList[index],
            onTap: (item) => Get.to(() => MovieDetailsScreen(movie: item)));
      },
      separatorBuilder: (BuildContext context, int index) => const Gap(20),
    );
  }
}
