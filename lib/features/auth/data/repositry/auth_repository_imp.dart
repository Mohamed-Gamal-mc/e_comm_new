import 'package:dartz/dartz.dart';
import 'package:e_comm_new/core/error/exceptions.dart';
import 'package:e_comm_new/core/error/failure.dart';
import 'package:e_comm_new/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_comm_new/features/auth/data/mappers/user_mappers.dart';
import 'package:e_comm_new/features/auth/data/models/login_request.dart';
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/domain/entities/user.dart';
import 'package:e_comm_new/features/auth/domain/repositroies/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  AuthRepositoryImp(
      {required AuthRemoteDataSource authRemoteDataSource,
      required AuthLocalDataSource authLocalDataSource})
      : _remoteDataSource = authRemoteDataSource,
        _localDataSource = authLocalDataSource;

  @override
  Future<Either<Failure, User>> register(
      RegisterRequest registerRequest) async {
    try {
      final response = await _remoteDataSource.register(registerRequest);
      await _localDataSource.saveToken(response.token);
      return Right(response.user.toEntity);
    } on AddExceptions catch (exception) {
      return Left(Failure(message: exception.errorMessage));
    }
  }

  @override
  Future<Either<Failure, User>> login(LoginRequest loginRequest) async {
    try {
      final response = await _remoteDataSource.login(loginRequest);
      await _localDataSource.saveToken(response.token!);
      return Right(response.user.toEntity);
    } on AddExceptions catch (exception) {
      return Left(Failure(message: exception.errorMessage));
    }
  }
}
