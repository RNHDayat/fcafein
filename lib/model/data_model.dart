import 'package:powershare/pgLogin.dart';

class TokenAuth {
  String? token;
  TokenAuth({required this.token});
  TokenAuth.fromJson(Map<String, dynamic> data) {
    token = data['token'];
  }
}

class LoginAuth {
  String? data,level;
  LoginAuth({required this.data, required this.level});
  factory LoginAuth.fromJson(Map<String, dynamic> json) {
    return LoginAuth(
      data: json['token'],
      level: json['level'].toString(),
    );
  }
}
