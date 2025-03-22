import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:watch/presentation/main/view/widgets/movie_detail.dart';
import 'package:watch/presentation/resources/string_manager.dart';

import '../../../../app/constant.dart';
import '../../../../domain/model/models.dart';
import '../../../resources/value_manager.dart';

class MovieListItem extends StatelessWidget {
  final Results movie;

  const MovieListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToDetail(context, movie),
      child: Card(
        margin: const EdgeInsets.all(AppValue.v8),
        child: Padding(
          padding: const EdgeInsets.all(AppValue.v8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: getImageUrl(movie.posterPath),
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => _retryImage(url),
              ),
              const SizedBox(width: AppValue.v10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: AppValue.v18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppValue.v8),
                    Text(
                      movie.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: AppValue.v14),
                    ),
                    const SizedBox(height: AppValue.v8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: AppValue.v20,
                        ),
                        const SizedBox(width: AppValue.v5),
                        Text(
                          movie.voteAverage.toString(),
                          style: const TextStyle(fontSize: AppValue.v14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _retryImage(String url) {
    return GestureDetector(
      onTap: () {},
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.refresh, color: Colors.red),
          Text(AppStrings.retry, style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }

  getImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return "https://image.tmdb.org/t/p/w350";
    }
    return "${Constants.imageUrl}$path";
  }

  _navigateToDetail(BuildContext context, Results movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetail(movie),
      ),
    );
  }
}
