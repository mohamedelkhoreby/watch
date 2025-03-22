import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch/domain/model/models.dart';
import 'package:watch/presentation/resources/value_manager.dart';

import '../../../../app/constant.dart';
import '../../../resources/string_manager.dart';

class MovieDetail extends StatelessWidget {
  final Results movie;

  const MovieDetail(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppValue.v16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster
              Center(
                child: CachedNetworkImage(
                  imageUrl: getImageUrl(movie.posterPath),
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => _retryImage(url),
                ),
              ),
              const SizedBox(height: AppValue.v16),
              // Movie Title and Release Date
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: AppValue.v24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppValue.v8),
              Text(
                '${AppStrings.releaseDataText.tr()} ${movie.releaseDate}',
                style: const TextStyle(
                  fontSize: AppValue.v16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: AppValue.v16),
              // Overview
              Text(
                AppStrings.overviewText.tr(),
                style: const TextStyle(
                  fontSize: AppValue.v20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppValue.v8),
              Text(
                movie.overview,
                style: const TextStyle(fontSize: AppValue.v16),
              ),
              const SizedBox(height: AppValue.v16),
              // Ratings
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: AppValue.v4),
                  Text(
                    '${movie.voteAverage} / 10',
                    style: const TextStyle(fontSize: AppValue.v16),
                  ),
                  const SizedBox(width: AppValue.v16),
                  Text(
                    '${movie.voteCount} ${AppStrings.votesText.tr()}',
                    style: const TextStyle(
                        fontSize: AppValue.v16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: AppValue.v16),
              // Popularity
              Text(
                '${AppStrings.popularityText.tr()} ${movie.popularity}',
                style: const TextStyle(fontSize: AppValue.v16),
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
      return "https://via.placeholder.com/500";
    }
    return "${Constants.imageUrl}$path";
  }
}
