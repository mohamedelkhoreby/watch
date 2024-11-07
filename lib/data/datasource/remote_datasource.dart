import 'package:watch/data/network/api.dart';
import 'package:watch/data/response/response.dart';

abstract class RemoteDataSource {
  Future<MoviesResponse> getHomeData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<MoviesResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }
}
