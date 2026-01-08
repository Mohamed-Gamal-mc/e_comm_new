import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setup() {
  serviceLocator.registerFactory<AuthApiRemoteDataSource>(
      () => AuthApiRemoteDataSource());
  serviceLocator
      .registerSingleton<AuthApiRemoteDataSource>(AuthApiRemoteDataSource());
  serviceLocator.registerLazySingleton<AuthApiRemoteDataSource>(() => AuthApiRemoteDataSource())
}
