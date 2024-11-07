// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultsDataResponse _$ResultsDataResponseFromJson(Map<String, dynamic> json) =>
    ResultsDataResponse(
      (json['id'] as num?)?.toInt(),
      json['title'] as String?,
      json['original_title'] as String?,
      json['original_language'] as String?,
      json['overview'] as String?,
      json['poster_path'] as String?,
      json['backdrop_path'] as String?,
      (json['popularity'] as num?)?.toDouble(),
      (json['vote_average'] as num?)?.toDouble(),
      (json['vote_count'] as num?)?.toInt(),
      json['release_date'] as String?,
      json['adult'] as bool?,
      json['video'] as bool?,
      (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$ResultsDataResponseToJson(
        ResultsDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'original_language': instance.originalLanguage,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'release_date': instance.releaseDate,
      'adult': instance.adult,
      'video': instance.video,
      'genre_ids': instance.genreIds,
    };

MoviesResponse _$MoviesResponseFromJson(Map<String, dynamic> json) =>
    MoviesResponse(
      (json['page'] as num).toInt(),
      (json['results'] as List<dynamic>?)
          ?.map((e) => ResultsDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoviesResponseToJson(MoviesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.data,
    };
