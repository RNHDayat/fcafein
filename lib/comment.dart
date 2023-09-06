import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'commentWidget.dart';
import 'model/database.dart';
import 'model/dbhelper.dart';

class CNested extends StatefulWidget {
  const CNested({super.key});

  @override
  State<CNested> createState() => _CNestedState();
}

class _CNestedState extends State<CNested> {
  Map<String, dynamic> nih = {};
  Future<void> commentNested() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    Uri url = Uri.parse("http://10.0.2.2:8000/api/home?_page=${2}&limit=${2}");
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
      "Accept": "application/json",
      "login-type": "0",
    });
    // print(jsonData["data"]["token"]);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData['data'][0]);
      // return jsonData['data'];
      nih = jsonData['data'][0];
      print(nih);
    } else {
      print(response.statusCode);
      throw {print("gagal post")};
    }
  }

  @override
  void initState() {
    // Nested();
    commentNested();
    // TODO: implement initState
    super.initState();
  }

  String token = '';
  Nested() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    setState(() {
      token = data[0].token;
      // Comment.commentNested(token).then((value) {
      //   nih = value as Map<String, dynamic>;
      //   print('object');
      //   print(nih);
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nested Comments')),
      body: CommentWidget(comment: nih), // Replace with your JSON data
    );
  }
}
