import '../../domain/model/models.dart';
import '../response/response.dart';

// Assuming the classes are defined above.

extension ResultsDataResponseMapper on ResultsDataResponse {
  Results toDomain() {
    return Results(
      id ?? 0, // Default to 0 if id is null
      title ?? '',
      originalTitle ?? '',
      originalLanguage ?? '',
      overview ?? '',
      posterPath ?? '',
      backdropPath ?? '',
      popularity ?? 0.0,
      voteAverage ?? 0.0,
      voteCount ?? 0,
      releaseDate ?? '',
      adult ?? false,
      video ?? false,
      genreIds ?? [],
    );
  }
}

extension MoviesResponseMapper on MoviesResponse {
  MoviesData toDomain() {
    final resultsList =
        data?.map((result) => result.toDomain()).toList() ?? [];
    return MoviesData(
      page,
      resultsList,
    );
  }
}

