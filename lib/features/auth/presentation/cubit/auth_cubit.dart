import 'package:e_comm_new/features/auth/data/models/login_request.dart';
import 'package:e_comm_new/features/auth/data/models/register_request.dart';
import 'package:e_comm_new/features/auth/domain/use_cases/login.dart';
import 'package:e_comm_new/features/auth/domain/use_cases/register.dart';
import 'package:e_comm_new/features/auth/presentation/cubit/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this._register, this._login) : super(AuthInitial());
  final Register _register;
  final Login _login;

  Future<void> register(RegisterRequest registerRequest) async {
    emit(RegisterLoading());
    final result = await _register(registerRequest);
    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (_) => emit(RegisterSuccess()),
    );
  }

  Future<void> login(LoginRequest loginRequest) async {
    emit(LoginLoading());
    final result = await _login(loginRequest);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (_) => emit(LoginSuccess()),
    );
  }
}
