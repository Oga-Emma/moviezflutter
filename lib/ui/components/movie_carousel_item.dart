import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moviezflutter/core/config/application.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/ui/components/star_counter.dart';

class MovieCarouselItem extends StatelessWidget {
  const MovieCarouselItem({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.grey),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4.0)),
              child: CachedNetworkImage(
                imageUrl:
                    "${Application.imageThumbnailPrefix}${movie.backdropPath}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(5),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                    0.0,
                    0.9,
                  ],
                      colors: [
                    Colors.black26,
                    Colors.transparent,
                  ])),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  Text(
                    movie.releaseDate,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(5),
                  StarCounter(count: movie.rating),
                ],
              ),
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
