import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/ui/components/list/movies_list_view.dart';
import 'package:moviezflutter/ui/components/loading_widget.dart';
import 'package:moviezflutter/ui/home/saved/saved_page_controller.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  SavedPageController get controller => Get.find();

  @override
  void initState() {
    controller.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Saved Movies"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search Movies",
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) => controller.filter.value = value,
              ),
              const Gap(20),
              Expanded(
                child: Obx(() {
                  final movies = controller.movies.value;

                  if (movies.data != null) {
                    return MoviesListView(moviesList: controller.movieList);
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
