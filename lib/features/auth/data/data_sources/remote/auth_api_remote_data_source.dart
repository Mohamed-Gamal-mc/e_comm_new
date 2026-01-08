import 'package:dio/dio.dart';
import 'package:e_comm_new/core/api_constans.dart';
import 'package:e_comm_new/core/error/exceptions.dart';
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_comm_new/features/auth/data/models/login_request.dart';
import 'package:e_comm_new/features/auth/data/models/login_response_model.dart';
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/data/models/register_response_model.dart';

class AuthApiRemoteDataSource extends AuthRemoteDataSource {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstans.baseUrl,
      receiveDataWhenStatusError: true,
    ),
  );

  @override
  Future<RegisterResponseModel> register(
      RegisterRequest registerRequest) async {
    try {
      final response = await dio.post(
        ApiConstans.registerEndPoint,
        data: registerRequest.toJson(),
      );

      return RegisterResponseModel.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteException(message ?? 'Failed to register');
    }
  }

  @override
  Future<LoginResponseModel> login(LoginRequest logInRequest) async {
    try {
      final response = await dio.post(ApiConstans.logInEndPoint,
          data: logInRequest.toJson());
      return LoginResponseModel.fromJson(response.data);
    } catch (exception) {
      String? message;
      if (exception is DioException) {
        message = exception.response?.data['message'];
      }
      throw RemoteException(message ?? 'Failed to login');
    }
    ;
  }
}
