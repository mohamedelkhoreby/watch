import 'package:dio/dio.dart';
import '../../presentation/resources/string_manager.dart';
import '../../presentation/resources/value_manager.dart';
import 'failure.dart';

// Enum representing various types of data sources for errors
enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  badCertificate,
  notFound,
  internalServerError,
  connectionError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unknown
}

// Custom error handler implementing Exception
class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // Handle errors originating from Dio or API response
      failure = _handleError(error);
    } else {
      // Default error handling
      failure = DataSource.noContent.getFailure();
    }
  }
}

// Function to handle Dio-specific errors and map to appropriate failures
Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioExceptionType.badResponse:
      switch (error.response?.statusCode) {
        case ResponseCode.badRequest:
          return DataSource.badRequest.getFailure();
        case ResponseCode.forbidden:
          return DataSource.forbidden.getFailure();
        case ResponseCode.unAuthorised:
          return DataSource.unAuthorised.getFailure();
        case ResponseCode.notFound:
          return DataSource.notFound.getFailure();
        case ResponseCode.internalServerError:
          return DataSource.internalServerError.getFailure();
        default:
          return DataSource.unknown.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.unknown:
      return DataSource.unknown.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.badCertificate.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.connectionError.getFailure();
  }
}

// Extension to map DataSource to Failure with appropriate code and message
extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeOut:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut);
      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.connectionError:
        return Failure(
            ResponseCode.connectionError, ResponseMessage.connectionError);
      case DataSource.badCertificate:
        return Failure(
            ResponseCode.badCertificate, ResponseMessage.badCertificate);
      default:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}


