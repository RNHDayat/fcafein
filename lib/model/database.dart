import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginAuth {
  String? id, token, level;
  LoginAuth({this.id, this.token, this.level});
  factory LoginAuth.fromJson(Map<String, dynamic> json) {
    return LoginAuth(
      id: json['user']['id'].toString(),
      token: json['token'],
      level: json['level'].toString(),
    );
  }
  static Future<LoginAuth?> login(String username, String password) async {
    // final baseUrl = 'http://direkrut.ptumdi.com/api/login';
    final baseUrl = 'http://10.0.2.2:8000/api/login';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {"username": username, "password": password, "login_type": "0"},
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return LoginAuth.fromJson(body["data"]);
    } else {
      // return null;
      throw {print("Login Eror")};
    }
  }
}

class CreateAccount {
  String username, email, fullname, nickname, datebirth, phone, gender;
  CreateAccount({
    required this.username,
    required this.email,
    required this.fullname,
    required this.nickname,
    required this.datebirth,
    required this.phone,
    required this.gender,
  });
  factory CreateAccount.fromJson(Map<String, dynamic> json) {
    return CreateAccount(
      username: json['username'].toString(),
      email: json['email'].toString(),
      fullname: json['fullname'].toString(),
      nickname: json['nickname'].toString(),
      datebirth: json['datebirth'].toString(),
      phone: json['phone'].toString(),
      gender: json['gender'].toString(),
    );
  }
  static Future<CreateAccount?> create(String username, email, fullname, nickname, datebirth, phone, gender) async {
    final baseUrl = 'http://10.0.2.2/api/createAccount';
    final response = await http.post(Uri.parse(baseUrl),
        body: jsonEncode(
          {
            "username": username,
            "email": email,
            "fullname": fullname,
            "nickname": nickname,
            "datebirth": datebirth,
            "phone": phone,
            "gender": gender,
          },
        ));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      print(body);
      return CreateAccount.fromJson(body);
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

class AddCredential {
  String token, description;
  int type;
  AddCredential(
      {required this.token, required this.type, required this.description});
  factory AddCredential.fromJson(Map<String, dynamic> json) {
    return AddCredential(
      token: json['token'].toString(),
      type: json['type'],
      description: json['description'].toString(),
    );
  }
  static Future<AddCredential?> insert(String token, String description) async {
    final baseUrl = 'http://direkrut.ptumdi.com/api/credential/store';
    final response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Authorization": 'Bearer $token',
          "Accept": "application/json",
        },
        body: jsonEncode(
          {
            "type": 3,
            "description": description,
          },
        ));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      // return AddCredential.fromJson(body);
      print(body);
      // return body;
    } else {
      print(response.statusCode);
      // throw {print("gagal post")};
    }
  }
}

class GetUser {
  String? id,
      username,
      email,
      fullname,
      nickname,
      level,
      gender,
      address_house,
      company,
      job_position,
      start_year;
  GetUser({
    this.id,
    this.username,
    this.email,
    this.fullname,
    this.nickname,
    this.level,
    this.gender,
    this.address_house,
    this.company,
    this.job_position,
    this.start_year,
  });

  factory GetUser.GetUserResult(Map<String, dynamic> data) {
    return GetUser(
      id: data["id"].toString(),
      username: data["username"],
      email: data["email"],
      fullname: data["employees"]["fullname"],
      nickname: data["employees"]["nickname"],
      level: data["level"].toString(),
      gender: data["employees"]["gender"],
      address_house: data["employees"]["address_house"],
      company: data["employees"]["company"],
      job_position: data["employees"]["job_position"],
      start_year: data["employees"]["start_year"],
    );
  }

  static Future<GetUser> getUser(String token) async {
    Uri url = Uri.parse("http://direkrut.ptumdi.com/api/profile");
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // return AddCredential.fromJson(body);
      // print(body);
      return GetUser.GetUserResult(jsonData["data"]);
      // return body;
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

//POSTING
class Postings {
  String? token, title, description;
  Postings({this.token, this.title, this.description});
  // factory Postings.fromJson(Map<String, dynamic> json) {
  //   return Postings(
  //     title: json['title'].toString(),
  //     description: json['description'].toString(),
  //   );
  // }
  static Future<Postings?> share(
      String title, String description, String token) async {
    final baseUrl = 'http://direkrut.ptumdi.com/api/posting/store';
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      },
      body: {
        "title": title,
        "description": description,
      },
    );
    if (response.statusCode == 200) {
      // var body = json.decode(response.body);
      // var status = response.statusCode;
      print("berhasil");
    } else {
      // return null;
      print(response.statusCode);

      throw {print("Gagal posting")};
    }
  }
}
