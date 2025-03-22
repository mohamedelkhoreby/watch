import 'package:dartz/dartz.dart';
import 'package:watch/data/mapper/mapper.dart';
import '../../domain/model/models.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/resources/value_manager.dart';
import '../datasource/local_datasource.dart';
import '../datasource/remote_datasource.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/request.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(
      this._networkInfo, this._localDataSource, this._remoteDataSource);

  @override
  Future<Either<Failure, MoviesData>> getHomeData(
      PageRequest pageRequest) async {
    try {
      final cachedResponse = await _localDataSource.getHome(pageRequest.pages);
      return Right(cachedResponse.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final apiResponse = await _remoteDataSource.getHomeData(pageRequest);
          if (apiResponse.data!.isNotEmpty) {
            await _localDataSource.saveHomeToCache(pageRequest.pages,apiResponse);
            return Right(apiResponse.toDomain());
          } else {
            return Left(
                Failure(ApiInternalStatus.failure, "No data available"));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
