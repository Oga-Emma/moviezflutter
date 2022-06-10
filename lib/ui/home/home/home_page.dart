import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/ui/components/empty_state_widget.dart';
import 'package:moviezflutter/ui/components/grid/movies_grid_view.dart';
import 'package:moviezflutter/ui/components/loading_widget.dart';
import 'package:moviezflutter/ui/components/movie_carousel_item.dart';
import 'package:moviezflutter/ui/details/movie_details_screen.dart';
import 'package:moviezflutter/ui/home/home/home_page_controller.dart';
import 'package:moviezflutter/ui/home/home_screen_controller.dart';
import 'package:moviezflutter/ui/home/saved/saved_page_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  HomePageController get homeController => HomePageController.it;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Moviez"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Saved Movies",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.find<HomeScreenController>().changePage(2);
                    },
                    child: const Text("View All"),
                  )
                ],
              ),
              const Gap(20),
              SizedBox(
                height: Get.height / 3,
                child: savedMoviesArea(),
              ),
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trending",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "What people are watching",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      width: 130,
                      height: 40,
                      child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0)),
                          value: homeController.trendingType.value,
                          items: ["Today", "This week"]
                              .map((e) => DropdownMenuItem(
                                    child: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            homeController.type = value!;
                          }),
                    ),
                  )
                ],
              ),
              const Divider(),
              const Gap(20),
              Obx(() {
                final movies = homeController.movies.value;

                if (movies.data != null) {
                  return MoviesGridView(moviesList: movies.data!.movies);
                }

                if (movies.errorMessage != null &&
                    movies.errorMessage!.isNotEmpty) {
                  return const Text("Error");
                }

                return const LoadingWidget();
              }),
            ],
          ),
        ));
  }

  SavedPageController get savedPageMovieController => SavedPageController.it;

  Widget savedMoviesArea() {
    return SizedBox(
      child: Obx(() {
        final movies = savedPageMovieController.movies.value;

        if (movies.data != null) {
          if (movies.data!.isEmpty) {
            return const EmptyStateWidget(
              heading: 'No saved movies',
              body: 'Movies you saved will appear here',
            );
          }

          return Swiper(
            onTap: (index) => Get.to(MovieDetailsScreen(
                movie: savedPageMovieController.movieList[index])),
            itemBuilder: (BuildContext context, int index) {
              return MovieCarouselItem(
                movie: savedPageMovieController.movieList[index],
              );
            },
            itemCount: savedPageMovieController.movieList.length,
            // pagination: const SwiperPagination(),
            viewportFraction: 0.8,
            scale: 0.9,
            // control: const SwiperControl(),
          );
        }

        if (movies.errorMessage != null && movies.errorMessage!.isNotEmpty) {
          return const Text("Error");
        }

        return const LoadingWidget();
      }),
    );
  }
}
