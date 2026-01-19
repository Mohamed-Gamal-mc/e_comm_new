import 'package:e_comm_new/features/auth/data/models/user_model.dart';

class RegisterResponseModel {
  String message;
  UserModel user;
  String token;

  RegisterResponseModel(
      {required this.message, required this.user, required this.token});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        message: json['message'] as String,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String,
      );
}
