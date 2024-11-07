import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class ResultsDataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'video')
  bool? video;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  ResultsDataResponse(
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
  // toJson
  Map<String, dynamic> toJson() => _$ResultsDataResponseToJson(this);
  // fromJson
  factory ResultsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ResultsDataResponseFromJson(json);
}

@JsonSerializable()
class MoviesResponse{
  @JsonKey(name: 'page')
  int page;
  @JsonKey(name: 'results')
  List<ResultsDataResponse>? data;

  MoviesResponse(this.page, this.data);

// toJson
  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);

//fromJson
  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);
}
