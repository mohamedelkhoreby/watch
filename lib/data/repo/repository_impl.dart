import 'package:dartz/dartz.dart';
import 'package:watch/data/datasource/local_datasource.dart';
import 'package:watch/data/datasource/remote_datasource.dart';
import 'package:watch/data/mapper/mapper.dart';
import 'package:watch/data/network/request.dart';
import 'package:watch/domain/model/models.dart';

import '../../domain/repository/repository.dart';
import '../../presentation/resources/string_manager.dart';
import '../../presentation/resources/value_manager.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;
  RepositoryImpl(
      this._networkInfo, this._localDataSource, this._remoteDataSource);
  @override
  Future<Either<Failure, MoviesData>> getHomeData(PageRequest pageRequest) async {
    try {
      // get from cache
      final response = await _localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      // we have cache error so we should call API

      if (await _networkInfo.isConnected) {
        try {
          // its safe to call the API
          final response = await _remoteDataSource.getHomeData(pageRequest);
          if (response.data!.isNotEmpty) // success
          {
            // return data (success)
            // return right
            // save response to local data source
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            // return biz logic error
            // return left

            return Left(
                Failure(ApiInternalStatus.failure, ResponseMessage.unknown));
          }
        } catch (error) {
          return (Left(ErrorHandler.handle(error).failure));
        }
      } else {
        // return connection error
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
