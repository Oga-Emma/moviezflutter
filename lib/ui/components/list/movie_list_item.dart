import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moviezflutter/core/config/application.dart';
import 'package:moviezflutter/domain/model/movie.dart';
import 'package:moviezflutter/ui/components/star_counter.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key? key, required this.movie, required this.onTap})
      : super(key: key);
  final Movie movie;
  final ValueChanged<Movie> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.grey),
      ),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onTap(movie),
        child: Row(
          children: [
            Container(
              height: 140,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
              child: CachedNetworkImage(
                imageUrl:
                    "${Application.imageThumbnailPrefix}${movie.backdropPath}",
                fit: BoxFit.cover,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  const Gap(5),
                  Text(movie.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption!),
                  const Gap(10),
                  Text(
                    "Released: ${movie.releaseDate}",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.caption!,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      StarCounter(count: movie.rating),
                      const Gap(10),
                      Text("[${movie.rating + 1}]"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
