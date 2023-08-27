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
    // final baseUrl = 'http://10.0.2.2:8000/api/login';
    final baseUrl = 'http://192.168.1.1:8000/api/login';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {"username": username, "password": password, "login_type": "0"},
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return LoginAuth.fromJson(body["data"]);
    } else {
      var body = json.decode(response.body);
      print(body);
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

  static Future<CreateAccount?> create(String username, email, fullname,
      nickname, datebirth, phone, gender) async {
    final baseUrl = 'http://10.0.2.2:8000/api/createAccount';
    final response = await http.post(
      Uri.parse(baseUrl),
      body: {
        "username": username,
        "email": email,
        "fullname": fullname,
        "nickname": nickname,
        "datebirth": datebirth,
        "phone": phone,
        "gender": gender,
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      print(body);
      return CreateAccount.fromJson(body);
    } else {
      var body = json.decode(response.body);
      print(body);
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
    Uri url = Uri.parse("http://10.0.2.2:8000/api/profile");
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
    final baseUrl = 'http://10.0.2.2:8000/api/posting/store';
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

class Following {
  String? following_id, follow_status;

  Following({
    this.following_id,
    this.follow_status,
  });

  factory Following.FollowingResult(Map<String, dynamic> data) {
    return Following(
      following_id: data["following_id"].toString(),
      follow_status: data["follow_status"].toString(),
    );
  }

  static Future<Following> follow(
      String token, String following_id, String follow_status) async {
    Uri url = Uri.parse("http://10.0.2.2:8000/api/followuser/follow");
    var response = await http.post(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      },
      body: {
        "following_id": following_id,
        "follow_status": follow_status,
      },
    );
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // return AddCredential.fromJson(body);
      print(jsonData);
      return Following.FollowingResult(jsonData["data"]);
      // return body;
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

class Comment {
  final id;
  final id_user;
  final nickname;
  final title;
  final description;
  final company;
  final image;

  Comment({
    this.id,
    this.id_user,
    this.nickname,
    this.title,
    this.description,
    this.company,
    this.image,
  });

  factory Comment.CommentResult(Map<String, dynamic> data) {
    return Comment(
      id: data['id'],
      id_user: data['id_user'],
      nickname: data['nickname'],
      title: data['title'],
      description: data['description'],
      company: data['company'],
      image: data['image'],
    );
  }

  static Future<Comment> commentNested(String token) async {
    Uri url = Uri.parse("http://10.0.2.2:8000/api/home");
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData['data'];
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}
