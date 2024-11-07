import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:watch/data/response/response.dart';
import '../../app/constant.dart';

abstract class AppServiceClient {
  /// Fetch the list of movies from the home endpoint
  Future<MoviesResponse> getHomeData();
}

class AppServiceClientImpl implements AppServiceClient {
  Dio dio = Dio();
  final String _baseUrl = Constants.baseUrl;
  final String _token = Constants.token;
  @override
  Future<MoviesResponse> getHomeData() async {
    // Set query parameters according to the TMDB API
    final queryParameters = <String, dynamic>{};

    // Define headers if needed (e.g., for authentication)
    final headers = <String, dynamic>{
      'Authorization': 'Bearer $_token', // Replace with your token
      'accept': 'application/json',
    };
    // Add PrettyDioLogger interceptor to log requests and responses
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    // Fetch data using Dio
    final result = await dio
        .fetch<Map<String, dynamic>>(_setStreamType<MoviesResponse>(Options(
      //   receiveTimeout: const Duration(minutes: 1),
      // sendTimeout: const Duration(minutes: 1),
      method: 'GET',
      headers: headers,
    )
            .compose(
              dio.options,
              '/discover/movie', // Updated endpoint
              queryParameters: queryParameters,
            )
            .copyWith(baseUrl: _baseUrl)));

    // Convert the result to a MoviesResponse object
    final value = MoviesResponse.fromJson(result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
