class Movie {
  final String imageUrl;
  final String title;
  final String description;
  final double avgRate;

  Movie(
    this.imageUrl,
    this.title,
    this.description,
    this.avgRate,
  );
}

class Results {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  Results(
   this.id,
    this.title,
    this.originalTitle,
    this.originalLanguage,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.popularity,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.adult,
    this.video,
    this.genreIds,
  );
}

class MoviesData {
  int page;
  List<Results> results;
  MoviesData(this.page, this.results);
}
class HomeObject {
  MoviesData data;
  HomeObject(this.data);
}