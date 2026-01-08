import 'package:e_comm_new/core/di/service_locator.config.dart';
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' show InjectableInit;

final serviceLocator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => serviceLocator.init();
