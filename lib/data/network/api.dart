import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:watch/data/response/response.dart';
import '../../app/constant.dart';

abstract class AppServiceClient {
  Future<MoviesResponse> getHomeData(int page);
}

class AppServiceClientImpl implements AppServiceClient {
  final Dio _dio;
  final String _baseUrl = Constants.baseUrl;
  final String _token = Constants.token;

  AppServiceClientImpl(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Authorization': 'Bearer $_token', 
        'accept': 'application/json',
      },
    );

    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
  }

  @override
  Future<MoviesResponse> getHomeData(int page) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/discover/movie',
        queryParameters: {
          'api_key': 'YOUR_API_KEY', 
          'page': page,
        },
      );

      return MoviesResponse.fromJson(response.data!);
    } catch (error) {
      throw _handleDioError(error);
    }
  }

  Exception _handleDioError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Exception("Timeout error, please try again.");
        case DioExceptionType.badResponse:
          return Exception("Bad response from server: ${error.response?.statusCode}");
        case DioExceptionType.cancel:
          return Exception("Request cancelled.");
        case DioExceptionType.connectionError:
          return Exception("No internet connection.");
        default:
          return Exception("Unexpected error occurred.");
      }
    } else {
      return Exception("Unknown error: $error");
    }
  }
}
