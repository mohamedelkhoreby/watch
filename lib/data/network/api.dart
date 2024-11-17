import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:watch/data/response/response.dart';
import '../../app/constant.dart';

abstract class AppServiceClient {
  /// Fetch the list of movies from the home endpoint
  Future<MoviesResponse> getHomeData(int page);
}

class AppServiceClientImpl implements AppServiceClient {
  Dio dio = Dio();
  final String _baseUrl = Constants.baseUrl;
  final String _token = Constants.token;
  @override
  Future<MoviesResponse> getHomeData(int page) async {
    // Parameters for the request
    final parameters = {
      'api_key': 'YOUR_API_KEY', // Replace with your actual API key
      'page': page
    };
    // Define headers if needed (e.g., for authentication)
    final headers = <String, dynamic>{
      'Authorization': 'Bearer $_token', // Replace with your token
      'accept': 'application/json',
    };
    // Add PrettyDioLogger interceptor to log requests and responses
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
      ));
    }
    // Fetch data using Dio
    final result = await dio
        .fetch<Map<String, dynamic>>(_setStreamType<MoviesResponse>(Options(
       receiveTimeout: const Duration(seconds: 15),
       sendTimeout: const Duration( seconds: 15),
      method: 'GET',
      headers: headers,
    )
            .compose(
              dio.options,
              '/discover/movie', // Updated endpoint
              queryParameters: parameters,
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
