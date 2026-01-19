import 'package:e_comm_new/features/auth/data/models/user_model.dart';
import 'package:e_comm_new/features/auth/domain/entities/user.dart';

extension UserMapper on UserModel {
  User get toEntity => User(name: name, email: email, role: role);
}
