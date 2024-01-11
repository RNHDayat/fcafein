import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgLogin.dart';
import 'package:powershare/services/global.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
  static Future<LoginAuth?> login(BuildContext context, String firebase_token,
      String username, String password) async {
    // final baseUrl = 'http://direkrut.ptumdi.com/api/login';
    // const baseUrl = 'http://192.168.1.5:8000/api/login';
    Uri url = Uri.parse(URL + "login");
    // final baseUrl = 'http://192.168.1.1:8000/api/login';

    final response = await http.post(
      url,
      body: {
        "firebase_token": firebase_token,
        "username": username,
        "password": password,
        "login_type": "1",
      },
    );
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return LoginAuth.fromJson(body["data"]);
    } else {
      List<String> errorMessages = [];
      String errorMessageText = '';
      // Jika status code adalah 400 (Bad Request), maka Anda dapat menguraikan respons JSON untuk mendapatkan pesan kesalahan
      final data = json.decode(response.body);
      var msg = data['msg'];

      if (msg != null) {
        msg.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            errorMessages.add(value[0]);
            errorMessageText = errorMessages.join('\n');
            print(errorMessages);
          }
        });
      }
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: errorMessageText,
        textAlignment: TextAlign.start,
        confirmBtnText: 'Ok',
      );

      print(response.statusCode);
      // return null;
      throw {print("Login Eror")};
    }
  }
}

class Logout {
  static Future<int> logout(String token) async {
    const baseUrl = URL + 'logout';
    Uri url = Uri.parse(baseUrl);

    final response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "*/*",
        "login-type": "0",
      },
    );

    String toastMessage;
    Color toastColor;

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      toastMessage = body['msg'];
      toastColor = Colors.green;
      Fluttertoast.showToast(
        msg: toastMessage,
        backgroundColor: toastColor,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return response.statusCode;
    } else {
      return response.statusCode;
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

  static Future create(BuildContext context, String username, email, password,
      fullname, nickname, datebirth, phone, gender) async {
    // const baseUrl = 'http://10.0.2.2:8000/api/createAccount';
    Uri url = Uri.parse(URL + "createAccount");
    final response = await http.post(
      url,
      body: {
        "username": username,
        "email": email,
        "password": password,
        "fullname": fullname,
        "nickname": nickname,
        "datebirth": datebirth,
        "phone": phone,
        "gender": gender,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = json.decode(response.body);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: body['msg'],
        onConfirmBtnTap: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
            (route) => false),
      );
      return response.statusCode;
      // return CreateAccount.fromJson(body);
    } else if (response.statusCode == 400) {
      List<String> errorMessages = [];
      String errorMessageText = '';
      // Jika status code adalah 400 (Bad Request), maka Anda dapat menguraikan respons JSON untuk mendapatkan pesan kesalahan
      final data = json.decode(response.body);
      final msg = data['msg'];

      if (msg != null) {
        msg.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            errorMessages.add(value[0]);
            errorMessageText = errorMessages.join('\n');
            print(errorMessages);
          }
        });
      }
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: errorMessageText,
        textAlignment: TextAlign.start,
        confirmBtnText: 'Ok',
      );
    } else {
      // Handle kode status lain jika diperlukan
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Terjadi kesalahan',
        textAlignment: TextAlign.start,
        confirmBtnText: 'Ok',
      );
      print('tidak ada');
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
    Uri url = Uri.parse(URL + "credential/store");
    final response = await http.post(
      url,
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
  final id,
      username,
      email,
      fullname,
      nickname,
      follow_me,
      level,
      gender,
      description,
      address_house,
      company,
      job_position,
      start_year;
  int follow_status;
  GetUser({
    this.id,
    this.username,
    this.email,
    this.fullname,
    this.nickname,
    this.follow_me,
    required this.follow_status,
    this.level,
    this.description,
    this.gender,
    this.address_house,
    this.company,
    this.job_position,
    this.start_year,
  });

  factory GetUser.fromJson(Map<String, dynamic> data) {
    return GetUser(
      id: data["id"].toString(),
      username: data["username"],
      email: data["email"],
      fullname: data["employees"]["fullname"],
      nickname: data["employees"]["nickname"],
      follow_me: data["follow_me"],
      follow_status: data["follow_status"] ?? 0,
      level: data["level"].toString(),
      gender: data["employees"]["gender"],
      description: data["employees"]["description"],
      address_house: data["employees"]["address_house"],
      company: data["employees"]["company"],
      job_position: data["employees"]["job_position"],
      start_year: data["employees"]["start_year"],
    );
  }

  static Future<GetUser> getUser(String token, int id) async {
    // Uri url = Uri.parse("http://10.0.2.2:8000/api/profile");
    Uri url = Uri.parse(URL + "showprofile/$id");
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    });
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // List<dynamic> data = jsonData;
      // List<GetUser> listJenisRegulasi =
      //     data.map((json) => GetUser.fromJson(json)).toList();
      return GetUser.fromJson(jsonData);
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

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
      String id_knowField, File? image, File? doc) async {
    Uri url = Uri.parse(URL + "posting/store");

    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..headers['login-type'] = '0';
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['id_knowField'] = "[\"$id_knowField\"]";

    if (image != null) {
      var stream = new http.ByteStream(image.openRead());
      stream.cast();
      var length = await image.length();
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path, // Adjust the content type accordingly
        ),
      );
    }
    if (doc != null) {
      var stream = new http.ByteStream(doc.openRead());
      stream.cast();
      var length = await doc.length();
      request.files.add(
        await http.MultipartFile.fromPath(
          'doc',
          doc.path, // Adjust the content type accordingly
        ),
      );
    }

    final response = await request.send();
    try {
      if (response.statusCode == 200) {
        print("berhasil");
        Fluttertoast.showToast(
          msg: "Berhasil melakukan postingan",
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print(response.statusCode);
        Fluttertoast.showToast(
          msg: "Gagal melakukan postingan",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Gagal posting: $e");
      Fluttertoast.showToast(
        msg: "Gagal melakukan postingan",
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  static Future<Postings?> update(String id, String title, String description,
      String token, String id_knowField, File? image, File? doc) async {
    Uri url = Uri.parse(URL + "posting/update/$id");

    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Accept'] = 'application/json'
      ..headers['login-type'] = '0';
    // request.fields['id'] = id;
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['id_knowField'] = id_knowField;

    if (image != null) {
      var stream = new http.ByteStream(image.openRead());
      stream.cast();
      var length = await image.length();
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path, // Adjust the content type accordingly
        ),
      );
    }
    if (doc != null) {
      var stream = new http.ByteStream(doc.openRead());
      stream.cast();
      var length = await doc.length();
      request.files.add(
        await http.MultipartFile.fromPath(
          'doc',
          doc.path, // Adjust the content type accordingly
        ),
      );
    }

    final response = await request.send();
    try {
      if (response.statusCode == 200) {
        print("berhasil");
        Fluttertoast.showToast(
          msg: "Berhasil mengubah postingan",
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print(response.statusCode);
        Fluttertoast.showToast(
          msg: "Gagal melakukan postingan",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Gagal posting: $e");
      Fluttertoast.showToast(
        msg: "Gagal melakukan postingan",
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

class ShowFollow {
  final id,
      id_user,
      following_id,
      follow_status,
      fullname,
      nickname,
      company,
      job_position;

  ShowFollow(
      {this.id,
      this.id_user,
      this.following_id,
      this.follow_status,
      this.fullname,
      this.nickname,
      this.company,
      this.job_position});

  factory ShowFollow.fromJson(Map<String, dynamic> data) {
    return ShowFollow(
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

  Future<List<ShowFollow>> showfollowings(String token, id) async {
    Uri url = Uri.parse(URL + "followuser/showfollowings/$id");
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
      List<dynamic> data = jsonData;
      List<ShowFollow> ilmuList =
          data.map((json) => ShowFollow.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }

  Future<List<ShowFollow>> showfollowers(String token, id) async {
    Uri url = Uri.parse(URL + "followuser/showfollowers/$id");
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
      List<dynamic> data = jsonData;
      List<ShowFollow> ilmuList =
          data.map((json) => ShowFollow.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

// class Followers {
//   String? id,
//       id_user,
//       following_id,
//       follow_status,
//       fullname,
//       nickname,
//       company,
//       job_position;
//
//   Followers(
//       {this.id,
//       this.id_user,
//       this.following_id,
//       this.follow_status,
//       this.fullname,
//       this.nickname,
//       this.company,
//       this.job_position});

//   factory Followers.FollowersResult(Map<String, dynamic> data) {
//     return Followers(
//       id: data["id"].toString(),
//       id_user: data["id_user"].toString(),
//       following_id: data["following_id"].toString(),
//       follow_status: data["follow_status"].toString(),
//       fullname: data["fullname"],
//       nickname: data["nickname"],
//       company: data["company"],
//       job_position: data["job_position"],
//     );
//   }

//   get userid => null;

//   static Future<Followers> followers(String token) async {
//     // Uri url = Uri.parse("http://10.0.2.2:8000/api/followuser/followers");
//     Uri url = Uri.parse(URL + "followuser/followers");

//     var response = await http.get(
//       url,
//       headers: {
//         "Authorization": 'Bearer $token',
//         "Accept": "application/json",
//         "login-type": "0",
//       },
//     );
//     if (response.statusCode == 200) {
//       var jsonData = json.decode(response.body);
//       print(jsonData);
//       return Followers.FollowersResult(jsonData[0]);
//     } else {
//       print(response.statusCode);
//       throw {print("gagal post")};
//     }
//   }
// }

class UpdateDescrip {
  final String? description;

  UpdateDescrip({
    this.description,
  });

  factory UpdateDescrip.fromJson(Map<String, dynamic> json) {
    return UpdateDescrip(
      description: json['description'],
    );
  }
  static Future<http.Response> updateDescrip(
      String token, String description) async {
    Uri url = Uri.parse(
        URL + "employee/updateDeskripsi"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "description": description,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(jsonData);
      Fluttertoast.showToast(
          msg: "Berhasil memperbarui deskripsi",
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
}

class UpdatePassword {
  final String? password;

  UpdatePassword({
    this.password,
  });

  factory UpdatePassword.fromJson(Map<String, dynamic> json) {
    return UpdatePassword(
      password: json['password'],
    );
  }
  static Future<http.Response> changePassword(
      String token, String password) async {
    final Uri url =
        Uri.parse(URL + "updatePassword"); // Ganti dengan endpoint yang sesuai
    final Map<String, String> headers = {
      "Authorization": 'Bearer $token',
      "Accept": "*/*",
      "login-type": "1",
    };
    final Map<String, String> body = {
      "password": password,
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      return response;
    } catch (e) {
      // Tangani kesalahan jika ada
      print(e.toString());
      return http.Response('Failed to send request',
          500); // Ganti ini dengan respons kesalahan yang sesuai
    }
  }
}

class ValidateOldPassword {
  final String? password;

  ValidateOldPassword({
    this.password,
  });

  factory ValidateOldPassword.fromJson(Map<String, dynamic> json) {
    return ValidateOldPassword(
      password: json['password'],
    );
  }
  static Future<http.Response> validatePassword(
      String token, String password) async {
    final Uri url = Uri.parse(
        URL + "validatepassword"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "password": password,
    });

    print('BODYYYYY =>>${password} --- ${response.body}');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(jsonData);

      return response;
    } else {
      print(response.statusCode);

      return response;
    }
  }
}

class UpdateDescript {
  final String? description;

  UpdateDescript({
    this.description,
  });

  factory UpdateDescript.fromJson(Map<String, dynamic> json) {
    return UpdateDescript(
      description: json['description'],
    );
  }
  static Future<http.Response> updateDescrip(
      String token, String description) async {
    Uri url = Uri.parse(
        URL + "employee/updateDeskripsi"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "description": description,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(jsonData);
      Fluttertoast.showToast(
          msg: "Berhasil memperbarui deskripsi",
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
}

class UpdateNama {
  final String? fullname;

  UpdateNama({
    this.fullname,
  });

  factory UpdateNama.fromJson(Map<String, dynamic> json) {
    return UpdateNama(
      fullname: json['fullname'],
    );
  }
  static Future<http.Response> updateNama(String token, String fullname) async {
    Uri url = Uri.parse(
        URL + "employee/updateFullname"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "fullname": fullname,
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(jsonData);
      Fluttertoast.showToast(
          msg: jsonData["msg"],
          backgroundColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      return response;
    } else {
      var jsonData = json.decode(response.body);
      Fluttertoast.showToast(
          msg: jsonData['msg'],
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      return response;
    }
  }
}

class UpdatePass {
  final String? password;

  UpdatePass({
    this.password,
  });

  factory UpdatePass.fromJson(Map<String, dynamic> json) {
    return UpdatePass(
      password: json['password'],
    );
  }
  static Future<http.Response> changePassword(
      String token, String password) async {
    final Uri url =
        Uri.parse(URL + "updatepw"); // Ganti dengan endpoint yang sesuai
    final Map<String, String> headers = {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
    };
    final Map<String, String> body = {
      "password": password,
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      return response;
    } catch (e) {
      // Tangani kesalahan jika ada
      print(e.toString());
      return http.Response('Failed to send request',
          500); // Ganti ini dengan respons kesalahan yang sesuai
    }
  }
}

class ValidateOldPass {
  final String? password;

  ValidateOldPass({
    this.password,
  });

  factory ValidateOldPass.fromJson(Map<String, dynamic> json) {
    return ValidateOldPass(
      password: json['password'],
    );
  }
  static Future<http.Response> validatePassword(
      String token, String password) async {
    final Uri url = Uri.parse(
        URL + "validatepassword"); // Ganti dengan endpoint yang sesuai
    var response = await http.post(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "application/json",
      "login-type": "0",
    }, body: {
      "password": password,
    });

    print('BODYYYYY =>>${password} --- ${response.body}');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // Iterable it = jsonData["data"][0];
      print(jsonData);

      return response;
    } else {
      print(response.statusCode);

      return response;
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
    // Uri url = Uri.parse("http://10.0.2.2:8000/api/followuser/follow");
    Uri url = Uri.parse(URL + "followuser/follow");

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
      print(response.statusCode);
      return Following.FollowingResult(jsonData["data"]);
      // return body;
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }
}

class PostComment {
  final id;
  final id_postings;
  final toAnswer_posting;
  final updated_at;
  final created_at;

  PostComment({
    this.id,
    this.id_postings,
    this.toAnswer_posting,
    this.updated_at,
    this.created_at,
  });

  factory PostComment.PostCommentResult(Map<String, dynamic> data) {
    return PostComment(
      id: data['id'],
      id_postings: data['id_postings'],
      toAnswer_posting: data['toAnswer_posting'],
      updated_at: data['updated_at'],
      created_at: data['created_at'],
    );
  }

  static Future<PostComment> commentNested(String token) async {
    // Uri url = Uri.parse("http://10.0.2.2:8000/api/store");
    Uri url = Uri.parse(URL + "store");

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
      return jsonData;
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }

  static Future<PostComment> postComment(String token, String id_postings,
      String title, String description) async {
    // Uri url = Uri.parse("http://10.0.2.2:8000/api/reply/store");
    Uri url = Uri.parse(URL + "reply/store");

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
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      print('YESS');
      return PostComment.PostCommentResult(jsonData);
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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/vote/store"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "vote/store");

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
    // Uri url = Uri.parse(
    // "http://10.0.2.2:8000/api/knowField/store");
    Uri url = Uri.parse(URL + "knowField/store");
    // Ganti dengan endpoint yang sesuai
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
      return Ilmu.fromJson(jsonData);
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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/knowField"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "knowField");

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
      // Uri url = Uri.parse(
      //     "http://10.0.2.2:8000/api/knowField/showDetail/$codeIlmu"); // Ganti dengan endpoint yang sesuai
      Uri url = Uri.parse(URL + "knowField/showDetail/$codeIlmu");

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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/knowField/follow"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "knowField/follow");

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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/knowField/show/$codeIlmu"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "knowField/show/$codeIlmu");

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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/knowField/showFollowIlmu"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "knowField/showFollowIlmu");

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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/credential/store"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "credential/store");

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
  Future<List<ShowCredentials>> getCredential(String token, String id) async {
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/credential/indexUser"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "credential/indexUser/$id");

    var response = await http.get(url, headers: {
      "Authorization": 'Bearer $token',
      "Accept": "*/*",
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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/credential/update/$id"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "credential/update/$id");

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
        msg: "Berhasil mengubah kredensial",
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/credential/destroy/$id"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "credential/destroy/$id");
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
  final id_knowfield;
  final title;
  final description;
  final image;
  final doc;
  final status;
  final nickname;
  final fullname;
  final company;
  final follow_status;
  int upvote;
  int downvote;
  int vote_status;
  final created_at;
  final updated_at;

  ShowPostingProfile({
    this.id,
    this.id_user,
    this.id_knowfield,
    this.title,
    this.description,
    this.image,
    this.doc,
    this.status,
    this.nickname,
    this.fullname,
    this.company,
    this.follow_status,
    required this.upvote,
    required this.downvote,
    required this.vote_status,
    this.created_at,
    this.updated_at,
  });

  factory ShowPostingProfile.fromJson(Map<String, dynamic> json) {
    return ShowPostingProfile(
      id: json['id'],
      id_user: json['id_user'],
      id_knowfield: json['id_knowfield'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      doc: json['doc'],
      status: json['status'],
      nickname: json['nickname'],
      fullname: json['fullname'],
      company: json['company'],
      follow_status: json['follow_status'],
      upvote: json['upvote'] ?? 0,
      downvote: json['downvote'] ?? 0,
      vote_status: json['vote_status'] ?? 0,
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  static Future<List<ShowPostingProfile>> getPostingProfile(
      String token, int id) async {
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/posting/indexProfile"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "posting/indexProfile/$id");

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

class ShowPostingProfileAnswer {
  final id;
  final id_user;
  final id_knowfield;
  final title;
  final description;
  final image;
  final doc;
  final status;
  final nickname;
  final fullname;
  final company;
  final follow_status;
  int upvote;
  int downvote;
  int vote_status;
  final created_at;
  final updated_at;

  ShowPostingProfileAnswer({
    this.id,
    this.id_user,
    this.id_knowfield,
    this.title,
    this.description,
    this.image,
    this.doc,
    this.status,
    this.nickname,
    this.fullname,
    this.company,
    this.follow_status,
    required this.upvote,
    required this.downvote,
    required this.vote_status,
    this.created_at,
    this.updated_at,
  });

  factory ShowPostingProfileAnswer.fromJson(Map<String, dynamic> json) {
    return ShowPostingProfileAnswer(
      id: json['id'],
      id_user: json['id_user'],
      id_knowfield: json['id_knowfield'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      doc: json['doc'],
      status: json['status'],
      nickname: json['nickname'],
      fullname: json['fullname'],
      company: json['company'],
      follow_status: json['follow_status'],
      upvote: json['upvote'] ?? 0,
      downvote: json['downvote'] ?? 0,
      vote_status: json['vote_status'] ?? 0,
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  static Future<List<ShowPostingProfileAnswer>> getPostingProfile(
      String token) async {
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/posting/indexProfile"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "posting/indexProfileAnswer");

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
      List<ShowPostingProfileAnswer> ilmuList =
          data.map((json) => ShowPostingProfileAnswer.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

//komentar like postingan
class ShowComment {
  final id;
  final id_user;
  final id_credential;
  final id_category;
  final id_knowfield;
  final title;
  final description;
  final status;
  final id_post;
  final nickname;
  final company;
  final id_user_post;
  final id_credential_post;
  final id_knowfield_post;
  final title_post;
  final description_post;
  final image_post;
  final created_at;
  final updated_at;
  final created_at_post;
  final updated_at_post;

  ShowComment({
    this.id,
    this.id_user,
    this.id_credential,
    this.id_category,
    this.id_knowfield,
    this.title,
    this.description,
    this.status,
    this.id_post,
    this.nickname,
    this.company,
    this.id_user_post,
    this.id_credential_post,
    this.id_knowfield_post,
    this.title_post,
    this.description_post,
    this.image_post,
    this.created_at,
    this.updated_at,
    this.created_at_post,
    this.updated_at_post,
  });

  factory ShowComment.fromJson(Map<String, dynamic> json) {
    return ShowComment(
      id: json['id'],
      id_user: json['id_user'],
      id_credential: json['id_credential'],
      id_category: json['id_category'],
      id_knowfield: json['id_knowfield'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      id_post: json['toAnswer_posting'][0]['id'],
      id_user_post: json['toAnswer_posting'][0]['id_user'],
      nickname: json['toAnswer_posting'][0]['nickname'],
      company: json['toAnswer_posting'][0]['company'],
      id_credential_post: json['toAnswer_posting'][0]['id_credential'],
      id_knowfield_post: json['toAnswer_posting'][0]['id_knowfield'],
      title_post: json['toAnswer_posting'][0]['title'],
      description_post: json['toAnswer_posting'][0]['description'],
      image_post: json['toAnswer_posting'][0]['image'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      created_at_post: json['toAnswer_posting'][0]['created_at'],
      updated_at_post: json['toAnswer_posting'][0]['updated_at'],
    );
  }
  Future<List<ShowComment>> getComments(String token) async {
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/reply/showComment"); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "reply/showComment");

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
      List<ShowComment> ilmuList =
          data.map((json) => ShowComment.fromJson(json)).toList();
      return ilmuList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class ShowRegulasi {
  final id;
  late final id_jenis;
  final id_kategori;
  final nomor;
  final tahun;
  final tgl_terbit;
  final shortDesc;
  final keterangan;
  final doc;
  final oleh;
  final createdAt;
  final updatedAt;
  final name;

  ShowRegulasi({
    this.id,
    this.id_jenis,
    this.id_kategori,
    this.nomor,
    this.tahun,
    this.tgl_terbit,
    this.shortDesc,
    this.keterangan,
    this.doc,
    this.oleh,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  factory ShowRegulasi.fromJson(Map<String, dynamic> json) {
    List<dynamic> kategoriList = json['id_kategori'] ?? [] as List<dynamic>;
    List<Kategori> kategori =
        kategoriList.map((e) => Kategori.fromJson(e)).toList();
    return ShowRegulasi(
      id: json['id'],
      id_jenis: json['id_jenis'],
      id_kategori: kategori,
      nomor: json['nomor'] ?? '',
      tahun: json['tahun'],
      tgl_terbit: json['tgl_terbit'] ?? '',
      shortDesc: json['short_desc'] ?? '',
      keterangan: json['keterangan'] ?? '',
      doc: json['doc'] ?? '',
      oleh: json['oleh'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
    );
  }
  Future<List<ShowRegulasi>> showReg() async {
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/credential/indexUser");
    final _db = DBhelper();
    var data = await _db.getToken(); // Ganti dengan endpoint yang sesuai
    print("token: " + data[0].token);
    Uri url = Uri.parse(URL + "cafein/regulasi");
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
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
      // return data.map((json) => ShowRegulasi.fromJson(json)).toList();
      List<ShowRegulasi> listRegulasi =
          data.map((json) => ShowRegulasi.fromJson(json)).toList();
      return listRegulasi;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class Kategori {
  final id;
  final text;

  Kategori({
    this.id,
    this.text,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'].toString(),
      text: json['text'],
    );
  }
}

class ShowMedia {
  final id;
  final nama_media;
  final no_volume;
  final tahun;
  final tgl_terbit;
  final headline;
  final cover;
  final attachment;
  final keterangan;
  final oleh;
  final createdAt;
  final updatedAt;

  ShowMedia({
    this.id,
    this.nama_media,
    this.no_volume,
    this.tahun,
    this.tgl_terbit,
    this.headline,
    this.cover,
    this.attachment,
    this.keterangan,
    this.oleh,
    this.createdAt,
    this.updatedAt,
  });

  factory ShowMedia.fromJson(Map<String, dynamic> json) {
    return ShowMedia(
      id: json['id'],
      nama_media: json['nama_media'],
      no_volume: json['no_volume'].toString() ?? '',
      tahun: json['tahun'],
      tgl_terbit: json['tgl_terbit'] ?? '',
      headline: json['headline'] ?? '',
      cover: json['cover'] ?? '',
      attachment: json['attachment'] ?? '',
      keterangan: json['keterangan'] ?? '',
      oleh: json['oleh'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Future<List<ShowMedia>> showMedia() async {
    // Uri url = Uri.parse(
    //     "http://10.0.2.2:8000/api/credential/indexUser");
    final _db = DBhelper();
    var data = await _db.getToken(); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "cafein/media");

    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
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
      // List<ShowMedia> ilmuList =
      //     data.map((json) => ShowMedia.fromJson(json)).toList();
      return data.map((json) => ShowMedia.fromJson(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class JenisRegulasi {
  final id;
  final name;
  final keterangan;
  final oleh;
  final createdAt;
  final updatedAt;

  JenisRegulasi({
    this.id,
    this.name,
    this.keterangan,
    this.oleh,
    this.createdAt,
    this.updatedAt,
  });

  factory JenisRegulasi.fromJson(Map<String, dynamic> json) {
    return JenisRegulasi(
      id: json['id'],
      name: json['name'],
      keterangan: json['keterangan'] ?? '',
      oleh: json['oleh'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Future<List<JenisRegulasi>> showJenis() async {
    final _db = DBhelper();
    var data = await _db.getToken(); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "cafein/jenis");

    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData;
      List<JenisRegulasi> listJenisRegulasi =
          data.map((json) => JenisRegulasi.fromJson(json)).toList();
      return listJenisRegulasi;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class KategoriRegulasi {
  final id;
  final id_jenis;
  final name;
  final oleh;
  final createdAt;
  final updatedAt;

  KategoriRegulasi({
    this.id,
    this.id_jenis,
    this.name,
    this.oleh,
    this.createdAt,
    this.updatedAt,
  });

  factory KategoriRegulasi.fromJson(Map<String, dynamic> json) {
    return KategoriRegulasi(
      id: json['id'],
      id_jenis: json['id_jenis'] ?? '',
      name: json['name'],
      oleh: json['oleh'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Future<List<KategoriRegulasi>> showKategori() async {
    final _db = DBhelper();
    var data = await _db.getToken(); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "cafein/kategori");

    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData;
      List<KategoriRegulasi> listKategoriRegulasi =
          data.map((json) => KategoriRegulasi.fromJson(json)).toList();
      return listKategoriRegulasi;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class ShowVote {
  final id;
  final id_user;
  final id_postings;
  final vote_status;
  final upvote;
  final downvote;
  final createdAt;
  final updatedAt;

  ShowVote({
    this.id,
    this.id_user,
    this.id_postings,
    this.vote_status,
    this.upvote,
    this.downvote,
    this.createdAt,
    this.updatedAt,
  });

  factory ShowVote.fromJson(Map<String, dynamic> json) {
    return ShowVote(
      id: json['id'] ?? '',
      id_user: json['id_user'] ?? '',
      id_postings: json['id_postings'] ?? '',
      vote_status: json['vote_status'] ?? '',
      upvote: json['upvote'] ?? 0,
      downvote: json['downvote'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
  static Future<ShowVote> showVoting(int id) async {
    final _db = DBhelper();
    var data = await _db.getToken(); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "posting/likeDetailPost/$id");

    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body)['data'];
      // List<dynamic> data = jsonData;
      // List<ShowVote> listShowVote =
      //     data.map((json) => ShowVote.fromJson(json)).toList();
      // if(jsonData==null){

      // return ShowVote.fromJson(jsonData);
      // }else{

      // }
      return ShowVote.fromJson(jsonData);
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class TopFun {
  final id_user;
  final fullname;
  final point;
  final rank;
  final createdAt;
  final updatedAt;

  TopFun({
    this.id_user,
    this.fullname,
    this.point,
    this.rank,
    this.createdAt,
    this.updatedAt,
  });

  factory TopFun.fromJson(Map<String, dynamic> json) {
    return TopFun(
      id_user: json['id_user'],
      fullname: json['fullname'] ?? '',
      point: json['point'],
      rank: json['rank'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Future<List<TopFun>> board() async {
    final _db = DBhelper();
    var data = await _db.getToken(); // Ganti dengan endpoint yang sesuai
    Uri url = Uri.parse(URL + "vote/rank");

    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
      "Accept": "application/json",
      "login-type": "0",
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData["data"];
      List<TopFun> listTopFun =
          data.map((json) => TopFun.fromJson(json)).toList();
      return listTopFun;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }
}

class GetNotif {
  final id;
  final id_user;
  final id_user_follow;
  final title;
  final body;
  int status_read;
  final updated_at;
  final created_at;

  GetNotif({
    this.id,
    this.id_user,
    this.id_user_follow,
    this.title,
    this.body,
    required this.status_read,
    this.updated_at,
    this.created_at,
  });

  factory GetNotif.fromJson(Map<String, dynamic> json) {
    return GetNotif(
      id: json['id'],
      id_user: json['id_user'],
      id_user_follow: json['id_user_follow'],
      title: json['title'],
      body: json['body'],
      status_read: json['status_read'],
      updated_at: json['updated_at'],
      created_at: json['created_at'],
    );
  }

  static Future<List<GetNotif>> getNotif(String token) async {
    Uri url = Uri.parse(URL + "notif");
    var response = await http.get(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "*/*",
        "login-type": "0",
      },
    );
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData[0]);
      List<dynamic> data = jsonData;
      List<GetNotif> listGetNotif =
          data.map((json) => GetNotif.fromJson(json)).toList();
      print(response.statusCode);
      return listGetNotif;
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }

  static Future<http.Response> read(String token, String id) async {
    Uri url = Uri.parse(URL + "notif/update/$id");
    var response = await http.post(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "*/*",
        "login-type": "0",
      },
    );
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      // var jsonData = json.decode(response.body);
      // print(jsonData[0]);

      return response;
    } else {
      print(response.statusCode);
      // throw {print("gagal post")};
      return response;
    }
  }
}

class DeletePosting {
  final msg;
  DeletePosting({
    this.msg,
  });
  factory DeletePosting.fromJson(Map<String, dynamic> json) {
    return DeletePosting(
      msg: json['msg'],
    );
  }
  static Future<http.Response> delete(String token, String id) async {
    Uri url = Uri.parse(URL + "posting/deleteCommentDetailPost/$id");
    var response = await http.post(
      url,
      headers: {
        "Authorization": 'Bearer $token',
        "Accept": "*/*",
        "login-type": "0",
      },
    );
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      // var jsonData = json.decode(response.body);
      // print(jsonData[0]);

      return response;
    } else {
      print(response.statusCode);
      // throw {print("gagal post")};
      return response;
    }
  }
}
