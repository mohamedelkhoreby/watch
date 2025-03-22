import '../response/response.dart';
import '../network/error_handler.dart';

String getCacheKey(int page) => "CACHE_HOME_KEY_$page";
const cacheExpirationTime = 60 * 1000;

abstract class LocalDataSource {
  Future<MoviesResponse> getHome(int page);
  Future<void> saveHomeToCache(int page,MoviesResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  final Map<String, CachedItem> _cacheMap = {};

@override
Future<MoviesResponse> getHome(int page) async {
  String cacheKey = getCacheKey(page);
  CachedItem? cachedItem = _cacheMap[cacheKey];

  if (cachedItem != null && cachedItem.isValid(cacheExpirationTime)) {
    return cachedItem.data;
  } else {
    throw ErrorHandler.handle(DataSource.cacheError);
  }
}
@override
 Future<void> saveHomeToCache(int page, MoviesResponse homeResponse) async {
  String cacheKey = getCacheKey(page);
  _cacheMap[cacheKey] = CachedItem(homeResponse);
}


  @override
  void clearCache() {
    _cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    _cacheMap.remove(key);
  }
}

class CachedItem {
  final dynamic data;
  final int cacheTime;

  CachedItem(this.data) : cacheTime = DateTime.now().millisecondsSinceEpoch;
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    return (currentTime - cacheTime) < expirationTime;
  }
}
