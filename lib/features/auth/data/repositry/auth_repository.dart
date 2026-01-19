import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_comm_new/core/error/exceptions.dart';
import 'package:e_comm_new/core/error/failure.dart';
import 'package:e_comm_new/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_comm_new/features/auth/data/models/login_request.dart';
import 'package:e_comm_new/features/auth/data/models/login_response_model.dart'
    hide User;
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/data/models/register_response_model.dart';
import 'package:e_comm_new/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  const AuthRepository(
      {required this.authRemoteDataSource, required this.authLocalDataSource});

  Future<Either<Failure, UserModel>> register(
      RegisterRequest registerRequest) async {
    try {
      final response = await authRemoteDataSource.register(registerRequest);
      await authLocalDataSource.saveToken(response.token);
      return Right(response.user);
    } on AddExceptions catch (exception) {
      return Left(Failure(message: exception.errorMessage));
    }
  }

  Future<Either<Failure, UserModel>> login(LoginRequest loginRequest) async {
    try {
      final response = await authRemoteDataSource.login(loginRequest);
      await authLocalDataSource.saveToken(response.token!);
      return Right(response.user);
    } on AddExceptions catch (exception) {
      return Left(Failure(message: exception.errorMessage));
    }
  }
}
