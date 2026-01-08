import 'package:dio/dio.dart';
import 'package:e_comm_new/core/api_constans.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio dio() => Dio(
        BaseOptions(
          baseUrl: ApiConstans.baseUrl,
          receiveDataWhenStatusError: true,
        ),
      );

  @preResolve
  Future<SharedPreferences> get getSharedPref =>
      SharedPreferences.getInstance();
}
