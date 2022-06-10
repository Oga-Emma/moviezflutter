import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moviezflutter/core/config/application.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/ui/components/loading_widget.dart';
import 'package:moviezflutter/ui/components/star_counter.dart';
import 'package:moviezflutter/ui/details/movie_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({required this.movie, Key? key}) : super(key: key);
  final Movie movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsController get controller => Get.find();

  @override
  void initState() {
    controller
        .getMovie(widget.movie.movieId)
        .then((value) => controller.getSavedMovies(force: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
        if (!controller.savedMovies.value.isSuccess ||
            controller.movie.value.data == null) {
          return const SizedBox.shrink();
        }

        if (controller.savedMovies.value.data!
            .any((element) => element.movieId == widget.movie.movieId)) {
          return FloatingActionButton.extended(
            backgroundColor: Colors.red,
            onPressed: () => controller.removeBookmark(widget.movie.id),
            icon: const Icon(Icons.delete_outline),
            label: const Text("Remove"),
          );
        }

        return FloatingActionButton.extended(
          onPressed: () {
            controller.bookmarkMovie(widget.movie);
            Get.showSnackbar(const GetSnackBar(
              message: "Saved",
              duration: Duration(seconds: 1),
            ));
          },
          icon: const Icon(Icons.bookmark_border),
          label: const Text("Bookmark"),
        );
      }),
      body: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: _buildSilvers,
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(context) {
    return Obx(() {
      final res = controller.movie.value;

      if (res.data != null) {
        final data = res.data!;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // Gap(50),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.movie.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const Gap(10),
                  OutlinedButton(
                      onPressed: () => _launchUrl(data.homepage),
                      child: const Text("Website"))
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  StarCounter(count: widget.movie.rating),
                  const Gap(10),
                  Text("[${widget.movie.rating + 1}]"),
                ],
              ),
              const Gap(10),
              Text("Release date: " + (data.releaseDate)),
              const Gap(5),
              Text(
                  "Duration: ${(data.runtime ?? 0) ~/ 60}h ${(data.runtime ?? 0) % 60}m"),
              const Gap(10),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: (data.genres ?? [])
                    .map((e) => Chip(
                            label: Text(
                          e.name ?? "",
                          style: Theme.of(context).textTheme.caption,
                        )))
                    .toList(),
              ),
              const Gap(10),
              const Divider(),
              Text(
                "Summary",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(10),
              Text(data.overview),
              const Gap(10),
              const Divider(),
              Text(
                "Production Countries",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(10),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: (data.productionCountries ?? [])
                    .map((e) => Chip(
                            label: Text(
                          e.name ?? "",
                          style: Theme.of(context).textTheme.caption,
                        )))
                    .toList(),
              ),
              const Divider(),
              Text(
                "Production Companies",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(10),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: (data.productionCompanies ?? [])
                    .map((e) => Chip(
                            label: Text(
                          e.name ?? "",
                          style: Theme.of(context).textTheme.caption,
                        )))
                    .toList(),
              ),
              const Divider(),
              Text(
                "Languages",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(10),
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: (data.spokenLanguages ?? [])
                    .map((e) => Chip(
                            label: Text(
                          e.name ?? "",
                          style: Theme.of(context).textTheme.caption,
                        )))
                    .toList(),
              ),
            ],
          ),
        );
      }

      if (res.errorMessage != null && res.errorMessage!.isNotEmpty) {
        return const Text("Error");
      }

      return const LoadingWidget();
    });
  }

  List<Widget> _buildSilvers(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).backgroundColor,
        expandedHeight: Get.height / 2.5,
        pinned: true,
        flexibleSpace: Obx(
          () => AnimatedOpacity(
            opacity: controller.animValue.value,
            duration: const Duration(milliseconds: 300),
            child: Material(
              // borderRadius:
              //     BorderRadius.vertical(bottom: Radius.circular(16.0)),
              child: SizedBox(
                height: double.maxFinite,
                child: CachedNetworkImage(
                  imageUrl:
                      "${Application.fullImagePrefix}${widget.movie.backdropPath}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  void _launchUrl(_url) async {
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
  }
}
