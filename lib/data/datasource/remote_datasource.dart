import 'package:watch/data/network/api.dart';
import 'package:watch/data/network/request.dart';
import 'package:watch/data/response/response.dart';

abstract class RemoteDataSource {
  Future<MoviesResponse> getHomeData(PageRequest pageRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<MoviesResponse> getHomeData(PageRequest pageRequest) async {
    return await _appServiceClient.getHomeData(pageRequest.pages);
  }
}
