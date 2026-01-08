class LoginResponseModel {
  String? message;
  UserLogin? user;
  String? token;

  LoginResponseModel({this.message, this.user, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new UserLogin.fromJson(json['user']) : null;
    token = json['token'];
  }
}

class UserLogin {
  String? name;
  String? email;
  String? role;

  UserLogin({this.name, this.email, this.role});

  UserLogin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }
}
