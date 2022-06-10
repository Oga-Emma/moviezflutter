import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/ui/components/list/movies_list_view.dart';
import 'package:moviezflutter/ui/components/loading_widget.dart';
import 'package:moviezflutter/ui/home/discover/discover_page_controller.dart';
import 'package:moviezflutter/ui/search/movie_search_delegate.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  DiscoverPageController get controller => DiscoverPageController.it;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Discover"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                child: const IgnorePointer(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search Movies",
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Text(
                "Latest",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  final movies = controller.movies.value;

                  if (movies.data != null) {
                    return MoviesListView(moviesList: movies.data!.movies);
                  }

                  if (movies.errorMessage != null &&
                      movies.errorMessage!.isNotEmpty) {
                    return const Text("Error");
                  }

                  return const LoadingWidget();
                }),
              ),
            ],
          ),
        ));
  }
}
