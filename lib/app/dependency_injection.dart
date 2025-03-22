import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch/app/app_prefs.dart';
import 'package:watch/app/constant.dart';
import 'package:watch/data/datasource/local_datasource.dart';
import 'package:watch/data/datasource/remote_datasource.dart';
import 'package:watch/data/network/api.dart';
import 'package:watch/data/network/network_info.dart';
import 'package:watch/data/repo/repository_impl.dart';
import 'package:watch/domain/repository/repository.dart';
import 'package:watch/domain/usecase/home_usecase.dart';
import 'package:watch/presentation/main/view_model/main_view_bloc.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // 1️⃣ SharedPreferences instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // 2️⃣ App Preferences
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // 3️⃣ Dio instance (Singleton)
  instance.registerLazySingleton<Dio>(() {
    Dio dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl,
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Authorization': 'Bearer ${Constants.token}', 
        'accept': 'application/json',
      },
    ));
    
    // Logging interceptor (only in debug mode)
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  });

  //App Service Client
  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClientImpl(instance<Dio>()),
  );

  //Network Info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );

  //Remote Data Source
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<AppServiceClient>()),
  );

  //Local Data Source (Caching)
  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  //Repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      instance<NetworkInfo>(),
      instance<LocalDataSource>(),
      instance<RemoteDataSource>(),
    ),
  );
}

//(Home)
void initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
  }

  if (!GetIt.I.isRegistered<MainViewBloc>()) {
    instance.registerFactory<MainViewBloc>(() => MainViewBloc(instance<HomeUseCase>()));
  }
}
