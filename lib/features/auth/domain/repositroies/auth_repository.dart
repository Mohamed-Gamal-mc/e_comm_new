import 'package:dartz/dartz.dart';
import 'package:e_comm_new/core/error/failure.dart';
import 'package:e_comm_new/features/auth/data/models/login_request.dart';
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/data/models/user_model.dart';
import 'package:e_comm_new/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register(RegisterRequest registerRequest);
  Future<Either<Failure, User>> login(LoginRequest loginRequest);
}
