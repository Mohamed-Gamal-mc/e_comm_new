import 'package:dartz/dartz.dart';
import 'package:e_comm_new/core/error/failure.dart';
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/domain/entities/user.dart';
import 'package:e_comm_new/features/auth/domain/repositroies/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class Register {
  final AuthRepository _authRepository;
  const Register(this._authRepository);

  Future<Either<Failure, User>> call(RegisterRequest registerRequest) {
    return _authRepository.register(registerRequest);
  }
}
