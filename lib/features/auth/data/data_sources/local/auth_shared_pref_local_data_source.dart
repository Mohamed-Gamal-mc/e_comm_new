import 'package:e_comm_new/core/api_constans.dart';
import 'package:e_comm_new/core/error/exceptions.dart';
import 'package:e_comm_new/features/auth/data/data_sources/local/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: AuthLocalDataSource)
class AuthSharedPrefLocalDataSource extends AuthLocalDataSource {
  @override
  Future<void> saveToken(String token) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(CacheConstans.tokenKey, token);
    } catch (_) {
      throw (LocalException('Failed to save token '));
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      return await sharedPreferences.getString(CacheConstans.tokenKey);
    } catch (_) {
      throw (LocalException('Failed to get token '));
    }
  }
}
