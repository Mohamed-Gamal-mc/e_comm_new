import 'package:e_comm_new/features/auth/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

class LoginResponseModel {
  String message;
  UserModel user;
  String? token;

  LoginResponseModel({required this.message, required this.user, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json['message'] as String,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        token: json['token'] as String?,
      );
}
