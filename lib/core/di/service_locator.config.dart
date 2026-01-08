// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_comm_new/features/auth/data/data_sources/local/auth_local_data_source.dart'
    as _i232;
import 'package:e_comm_new/features/auth/data/data_sources/local/auth_shared_pref_local_data_source.dart'
    as _i612;
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_api_remote_data_source.dart'
    as _i395;
import 'package:e_comm_new/features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i962;
import 'package:e_comm_new/features/auth/data/repositry/auth_repository.dart'
    as _i3;
import 'package:e_comm_new/features/auth/presentation/cubit/auth_cubit.dart'
    as _i247;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i962.AuthRemoteDataSource>(
        () => _i395.AuthApiRemoteDataSource());
    gh.singleton<_i232.AuthLocalDataSource>(
        () => _i612.AuthSharedPrefLocalDataSource());
    gh.singleton<_i3.AuthRepository>(() => _i3.AuthRepository(
          authRemoteDataSource: gh<_i962.AuthRemoteDataSource>(),
          authLocalDataSource: gh<_i232.AuthLocalDataSource>(),
        ));
    gh.singleton<_i247.AuthCubit>(
        () => _i247.AuthCubit(gh<_i3.AuthRepository>()));
    return this;
  }
}
