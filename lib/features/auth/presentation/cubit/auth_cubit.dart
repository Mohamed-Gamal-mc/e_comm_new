import 'package:e_comm_new/core/error/failure.dart';
import 'package:e_comm_new/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:e_comm_new/features/auth/data/data_sources/local/auth_shared_pref_local_data_source.dart';
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart';
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:e_comm_new/features/auth/data/models/login_request.dart';
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/data/repositry/auth_repository.dart';
import 'package:e_comm_new/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  late final AuthRepository authRepository;
  AuthCubit() : super(AuthInitial()) {
    authRepository = AuthRepository(
        authRemoteDataSource: AuthApiRemoteDataSource(),
        authLocalDataSource: AuthSharedPrefLocalDataSource());
  }
  Future<void> register(RegisterRequest registerRequest) async {
    emit(RegisterLoading());

    final result = await authRepository.register(registerRequest);
    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (_) => emit(RegisterSuccess()),
    );
  }

  Future<void> login(LoginRequest loginRequest) async {
    emit(LoginLoading());

    final result = await authRepository.login(loginRequest);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (_) => emit(LoginSuccess()),
    );
  }
}
