import 'package:dartz/dartz.dart';
import 'package:e_comm_new/core/error/failure.dart';
import 'package:e_comm_new/features/auth/data/models/login_request.dart';
import 'package:e_comm_new/features/auth/domain/entities/user.dart';
import 'package:e_comm_new/features/auth/domain/repositroies/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class Login {
  final AuthRepository _authRepository;
  const Login(this._authRepository);
  Future<Either<Failure, User>> call(LoginRequest loginRequest) {
    return _authRepository.login(loginRequest);
  }
}
