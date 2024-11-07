import 'package:flutter/material.dart';
import 'package:watch/domain/model/models.dart';
import 'package:watch/presentation/resources/value_manager.dart';

import '../../../app/constant.dart';
import '../../resources/string_manager.dart';

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
                child: Image.network(
                  '${Constants.imageUrl}${movie.posterPath}',
                  height: AppValue.s300,
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
                '${AppStrings.releaseDataText} ${movie.releaseDate}',
                style: const TextStyle(
                  fontSize: AppValue.v16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: AppValue.v16),
              // Overview
              const Text(
                AppStrings.overviewText,
                style: TextStyle(
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
                    '${movie.voteCount} ${AppStrings.votesText}',
                    style: const TextStyle(fontSize: AppValue.v16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: AppValue.v16),
              // Popularity
              Text(
                '${AppStrings.popularityText} ${movie.popularity}',
                style: const TextStyle(fontSize: AppValue.v16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
