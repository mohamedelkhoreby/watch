import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/app/app_prefs.dart';

import '../data/datasource/local_datasource.dart';
import '../data/datasource/remote_datasource.dart';
import '../data/network/api.dart';
import '../data/network/network_info.dart';
import '../data/repo/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/home_usecase.dart';
import '../presentation/main/view_model/main_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  //app service client
  instance
      .registerLazySingleton<AppServiceClient>(() => AppServiceClientImpl());

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<MainViewModel>(() => MainViewModel(instance()));
  }
}
