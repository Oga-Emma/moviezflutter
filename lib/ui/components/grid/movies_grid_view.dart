import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/ui/components/grid/movie_grid_item.dart';
import 'package:moviezflutter/ui/details/movie_details_screen.dart';

class MoviesGridView extends StatelessWidget {
  const MoviesGridView({Key? key, required this.moviesList}) : super(key: key);
  final List<Movie> moviesList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const PageScrollPhysics(),
      itemCount: moviesList.length,
      itemBuilder: (BuildContext context, int index) {
        return MovieGridItem(
            movie: moviesList[index],
            onTap: (item) => Get.to(() => MovieDetailsScreen(movie: item)));
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .65,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
    );
  }
}
