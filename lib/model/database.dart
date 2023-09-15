import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    const baseUrl = 'http://10.0.2.2:8000/api/login';
    // final baseUrl = 'http://192.168.1.1:8000/api/login';

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
    const baseUrl = 'http://10.0.2.2:8000/api/createAccount';
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
  String description;
  int type;
  AddCredential({required this.type, required this.description});
  factory AddCredential.fromJson(Map<String, dynamic> json) {
    return AddCredential(
      type: json['type'],
      description: json['description'].toString(),
    );
  }
  static Future<AddCredential?> insert(String token, String description) async {
    const baseUrl = 'http://10.0.2.2:8000/api/credential/store';
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      },
      body: {
        "type": 3,
        "description": description,
      },
    );
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
  String? token, title, description, id_knowField;
  Postings({this.token, this.title, this.description, this.id_knowField});
  // factory Postings.fromJson(Map<String, dynamic> json) {
  //   return Postings(
  //     title: json['title'].toString(),
  //     description: json['description'].toString(),
  //   );
  // }
  static Future<Postings?> share(String title, String description, String token,
      String id_knowField) async {
    const baseUrl = 'http://10.0.2.2:8000/api/posting/store';
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
        "id_knowField": id_knowField,
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

class ShowFollowings {
  String? id,
      id_user,
      following_id,
      follow_status,
      fullname,
      nickname,
      company,
      job_position;

  ShowFollowings(
      {this.id,
      this.id_user,
      this.following_id,
      this.follow_status,
      this.fullname,
      this.nickname,
      this.company,
      this.job_position});

  factory ShowFollowings.GetFollowingsResult(Map<String, dynamic> data) {
    return ShowFollowings(
      id: data["id"].toString(),
      id_user: data["id_user"].toString(),
      following_id: data["following_id"].toString(),
      follow_status: data["follow_status"].toString(),
      fullname: data["fullname"],
      nickname: data["nickname"],
      company: data["company"],
      job_position: data["job_position"],
    );
  }

  get userid => null;

  static Future<ShowFollowings> showfollowings(String token) async {
    Uri url = Uri.parse("http://10.0.2.2:8000/api/followuser/showfollowings");
    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      return ShowFollowings.GetFollowingsResult(jsonData[0]);
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

class Followers {
  String? id,
      id_user,
      following_id,
      follow_status,
      fullname,
      nickname,
      company,
      job_position;

  Followers(
      {this.id,
      this.id_user,
      this.following_id,
      this.follow_status,
      this.fullname,
      this.nickname,
      this.company,
      this.job_position});

  factory Followers.FollowersResult(Map<String, dynamic> data) {
    return Followers(
      id: data["id"].toString(),
      id_user: data["id_user"].toString(),
      following_id: data["following_id"].toString(),
      follow_status: data["follow_status"].toString(),
      fullname: data["fullname"],
      nickname: data["nickname"],
      company: data["company"],
      job_position: data["job_position"],
    );
  }

  get userid => null;

  static Future<Followers> followers(String token) async {
    Uri url = Uri.parse("http://10.0.2.2:8000/api/followuser/followers");
    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      return Followers.FollowersResult(jsonData[0]);
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
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
    Uri url = Uri.parse("http://10.0.2.2:8000/api/store");
    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      },
    );
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('YESS');
      return jsonData['data'];
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }

  static Future<Comment> postComment(String token, String id_postings,
      String title, String description) async {
    Uri url = Uri.parse("http://10.0.2.2:8000/api/reply/store");
    var response = await http.post(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      },
      body: {
        "id_postings": id_postings,
        "title": title,
        "description": description,
      },
    );
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('YESS');
      return jsonData['data'];
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

class Vote {
  final id;
  final userId;
  final postingsId;
  final voteStatus;

  Vote({
    required this.id,
    required this.userId,
    required this.postingsId,
    required this.voteStatus,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      id: json['id'],
      userId: json['id_user'],
      postingsId: json['id_postings'],
      voteStatus: json['vote_status'],
    );
  }
  static Future<Vote> voting(
      String token, int postingsId, int voteStatus) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/vote/store"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "id_postings": postingsId.toString(),
      "vote_status": voteStatus.toString(),
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return Vote.fromJson(jsonData['data']);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class Ilmu {
  final id;
  final codeIlmu;
  final name;
  final id_user_propose;

  Ilmu({
    required this.id,
    required this.codeIlmu,
    required this.name,
    required this.id_user_propose,
  });

  factory Ilmu.fromJson(Map<String, dynamic> json) {
    return Ilmu(
      id: json['id'],
      codeIlmu: json['codeIlmu'],
      name: json['name'],
      id_user_propose: json['id_user_propose'],
    );
  }
  static Future<Ilmu> add(String token, String codeIlmu, String name) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/knowField/store"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "codeIlmu": codeIlmu,
      "name": name,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      print(response.statusCode);
      print('L:');
      print(jsonData);
      return Ilmu.fromJson(jsonData['data']);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class PageIlmu {
  final id;
  final codeIlmu;
  final name;
  final id_user_propose;
  final id_user_validator;
  final created_at;
  final updated_at;

  PageIlmu({
    this.id,
    this.codeIlmu,
    this.name,
    this.id_user_propose,
    this.id_user_validator,
    this.created_at,
    this.updated_at,
  });

  factory PageIlmu.fromJson(Map<String, dynamic> json) {
    return PageIlmu(
      id: json['id'],
      codeIlmu: json['codeIlmu'],
      name: json['name'],
      id_user_propose: json['id_user_propose'],
      id_user_validator: json['id_user_validator'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  Future<List<PageIlmu>> get(String token) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/knowField"); // Ganti dengan endpoint yang sesuai
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      // print(response.statusCode);
      // print('niced');
      // print(jsonData['data'][0]);
      List<dynamic> data = jsonData['data'];
      List<PageIlmu> ilmuList =
          data.map((json) => PageIlmu.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class DetailPageIlmu {
  final id;
  final id_user;
  final id_knowField;
  final title;
  final description;
  final status;
  final nickname;
  final company;
  final image;
  final created_at;
  final updated_at;

  DetailPageIlmu({
    this.id,
    this.id_user,
    this.id_knowField,
    this.title,
    this.description,
    this.status,
    this.nickname,
    this.company,
    this.image,
    this.created_at,
    this.updated_at,
  });

  factory DetailPageIlmu.fromJson(Map<String, dynamic> json) {
    return DetailPageIlmu(
      id: json['id'],
      id_user: json['id_user'],
      id_knowField: json['id_knowField'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      nickname: json['user']['nickname'],
      company: json['user']['company'],
      image: json['image'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  Future<List<DetailPageIlmu>> get(
      BuildContext context, String token, String codeIlmu) async {
    try {
      Uri url = Uri.parse(
          "http://10.0.2.2:8000/api/knowField/showDetail/$codeIlmu"); // Ganti dengan endpoint yang sesuai
      var response = await http.get(url, headers: {
        "Authorization": 'Bearer $token',
        "Accept": "application/json",
        "login-type": "0",
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        var jsonData = json.decode(response.body);
        // Iterable it = jsonData["data"][0];
        // print(response.statusCode);
        // print('niced');
        // print(jsonData['data'][0]);
        List<dynamic> data = jsonData['data'];
        // print(data);
        List<DetailPageIlmu> detailIlmu =
            data.map((json) => DetailPageIlmu.fromJson(json)).toList();
        return detailIlmu;
      } else {
        print(response.statusCode);
        _showErrorDialog(context, 'Belum ada postingan dari ilmu ini');
        return [];
      }
    } catch (error) {
      _showErrorDialog(context, 'Terjadi kesalahan: $error');
      return [];
    }
  }

  static void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pemberitahuan'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class FollowIlmu {
  final id;
  final codeIlmu;
  final name;
  final id_user_propose;
  final id_user_validator;
  final id_user_follow;
  final user_status_follow;
  final created_at;
  final updated_at;

  FollowIlmu({
    this.id,
    this.codeIlmu,
    this.name,
    this.id_user_propose,
    this.id_user_validator,
    this.id_user_follow,
    this.user_status_follow,
    this.created_at,
    this.updated_at,
  });

  factory FollowIlmu.fromJson(Map<String, dynamic> json) {
    return FollowIlmu(
      id: json['id'].toString(),
      codeIlmu: json['codeIlmu'],
      name: json['name'],
      id_user_propose: json['id_user_propose'],
      id_user_validator: json['id_user_validator'],
      id_user_follow: json['id_user_follow'],
      user_status_follow: json['user_status_follow'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  static Future<FollowIlmu> pushFollow(String token, String codeIlmu) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/knowField/follow"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "codeIlmu": codeIlmu,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(response.statusCode);
      // print('niced');
      // print(jsonData['data']);
      // var data = jsonData['data'];
      // print(data);
      // List<FollowIlmu> ilmuList =
      //     data.map((json) => FollowIlmu.fromJson(jsonData['data'])).toList();
      return FollowIlmu.fromJson(jsonData['data']);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class FollowingIlmu {
  final id;
  final status_follow;

  FollowingIlmu({
    this.id,
    this.status_follow,
  });

  factory FollowingIlmu.fromJson(Map<String, dynamic> json) {
    return FollowingIlmu(
      id: json['id'],
      status_follow: json['status_follow'],
    );
  }
  static Future<FollowingIlmu> getFollow(String token, String codeIlmu) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/knowField/show/$codeIlmu"); // Ganti dengan endpoint yang sesuai
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(response.statusCode);
      // print('niced');
      // print(jsonData['data'][0]);
      // List<dynamic> data = jsonData;
      // List<FollowingIlmu> ilmuList =
      //     data.map((json) => FollowingIlmu.fromJson(jsonData)).toList();
      return FollowingIlmu.fromJson(jsonData);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class ShowFollowIlmu {
  final id;
  final codeIlmu;
  final name;
  final validation;
  final id_user_propose;
  final id_user_validator;
  final id_user_follow;
  final user_status_follow;
  final created_at;
  final updated_at;

  ShowFollowIlmu({
    this.id,
    this.codeIlmu,
    this.name,
    this.validation,
    this.id_user_propose,
    this.id_user_validator,
    this.id_user_follow,
    this.user_status_follow,
    this.created_at,
    this.updated_at,
  });

  factory ShowFollowIlmu.fromJson(Map<String, dynamic> json) {
    return ShowFollowIlmu(
      id: json['id'],
      codeIlmu: json['codeIlmu'],
      name: json['name'],
      validation: json['validation'],
      id_user_propose: json['id_user_propose'],
      id_user_validator: json['id_user_validator'],
      id_user_follow: json['id_user_follow'],
      user_status_follow: json['user_status_follow'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  Future<List<ShowFollowIlmu>> getFollow(String token) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/knowField/showFollowIlmu"); // Ganti dengan endpoint yang sesuai
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(response.statusCode);
      // print('niced');
      // print(jsonData['data'][0]);
      List<dynamic> data = jsonData;
      List<ShowFollowIlmu> ilmuList =
          data.map((json) => ShowFollowIlmu.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class StoreCredential {
  static Future<http.Response> store(
      String token, String type, String description) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/credential/store"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "type": type,
      "description": description
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      return response;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class ShowCredentials {
  final id;
  final id_employee;
  final type;
  final description;
  final hide;
  final created_at;
  final updated_at;

  ShowCredentials({
    this.id,
    this.id_employee,
    this.type,
    this.description,
    this.hide,
    this.created_at,
    this.updated_at,
  });

  factory ShowCredentials.fromJson(Map<String, dynamic> json) {
    return ShowCredentials(
      id: json['id'],
      id_employee: json['id_employee'],
      type: json['type'],
      description: json['description'],
      hide: json['hide'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  Future<List<ShowCredentials>> getCredential(String token) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/credential/indexUser"); // Ganti dengan endpoint yang sesuai
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(response.statusCode);
      // print('niced');
      // print(jsonData['data'][0]);
      List<dynamic> data = jsonData['data'];
      List<ShowCredentials> ilmuList =
          data.map((json) => ShowCredentials.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class UpdateCredentials {
  final message;

  UpdateCredentials({
    this.message,
  });

  factory UpdateCredentials.fromJson(Map<String, dynamic> json) {
    return UpdateCredentials(
      message: json['message'],
    );
  }
  static Future<http.Response> updateCredential(String token, String id,
      String type, String description, String hide) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/credential/update/$id"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "type": type,
      "description": description,
      "hide": hide,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(response.statusCode);
      Fluttertoast.showToast(
          msg: "Berhasil memperbarui kredensial",
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      return response;
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(
          msg: "Gagal memperbarui data",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      return response;
    }
  }

  static Future<http.Response> destroyCredential(
    String token,
    String id,
  ) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/credential/destroy/$id"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(response.statusCode);
      Fluttertoast.showToast(
          msg: "Berhasil menghapus kredensial",
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      return response;
    } else {
      print(response.statusCode);
      Fluttertoast.showToast(
          msg: "Gagal menghapus data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      throw response;
    }
  }
}

class ShowPostingProfile {
  final id;
  final id_user;
  final id_credential;
  final id_category;
  final id_knowfield;
  final title;
  final description;
  final nickname;
  final company;
  final image;
  final status;
  final created_at;
  final updated_at;

  ShowPostingProfile({
    this.id,
  this.id_user,
  this.id_credential,
  this.id_category,
  this.id_knowfield,
  this.title,
  this.description,
  this.nickname,
  this.company,
  this.image,
  this.status,
  this.created_at,
  this.updated_at,
  });

  factory ShowPostingProfile.fromJson(Map<String, dynamic> json) {
    return ShowPostingProfile(
      id: json['id'],
      id_user: json['id_user'],
      id_credential: json['id_credential'],
      id_category: json['id_category'],
      id_knowfield: json['id_knowfield'],
      title: json['title'],
      description: json['description'],
      nickname: json['user']['nickname'],
      company: json['user']['company'],
      image: json['image'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  Future<List<ShowPostingProfile>> getPostingProfile(String token) async {
    Uri url = Uri.parse(
        "http://10.0.2.2:8000/api/posting/indexProfile"); // Ganti dengan endpoint yang sesuai
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(response.statusCode);
      // print('niced');
      // print(jsonData['data'][0]);
      List<dynamic> data = jsonData['data'];
      List<ShowPostingProfile> ilmuList =
          data.map((json) => ShowPostingProfile.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}
