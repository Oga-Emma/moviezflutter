import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moviezflutter/core/config/application.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/ui/components/star_counter.dart';

class MovieGridItem extends StatelessWidget {
  const MovieGridItem({Key? key, required this.movie, required this.onTap})
      : super(key: key);
  final Movie movie;
  final ValueChanged<Movie> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey),
      ),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: InkWell(
        onTap: () => onTap(movie),
        child: Column(
          children: [
            Expanded(
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
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  Text(
                    "${movie.releaseDate}",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.caption!,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(5),
                  StarCounter(count: movie.rating),
                ],
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
