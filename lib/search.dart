import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgDetailPosting.dart';
import 'package:powershare/pgHome.dart';
import 'package:powershare/screens/user_akun.dart';
import 'package:powershare/services/global.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
    fetchAcc();
  }

  TextEditingController _searchController = TextEditingController();
  List<PostHome> items = [];
  List<PostHome> listPostHome = [];
  Future<List<PostHome>> fetch() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    const limit = 2;
    final response = await http.get(
      // Uri.parse("http://10.0.2.2:8000/api/home?page=$pageKey&limit=$_numberOfPostHomesPerRequest"),
      Uri.parse(URL + "home"),
      headers: {
        "Authorization": 'Bearer ${data[0].token}',
        "Accept": "*/*",
        "login-type": "0",
        // 'Charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData["data"];
      listPostHome = data.map((json) => PostHome.fromJson(json)).toList();
      return listPostHome;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }

  List<UsersAcc> itemsAcc = [];
  List<UsersAcc> listAcc = [];
  Future<List<UsersAcc>> fetchAcc() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    final response = await http.get(
      // Uri.parse("http://10.0.2.2:8000/api/home?page=$pageKey&limit=$_numberOfUsersAccsPerRequest"),
      Uri.parse(URL + "employee"),
      headers: {
        "Authorization": 'Bearer ${data[0].token}',
        "Accept": "*/*",
        "login-type": "0",
        // 'Charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> data = jsonData;
      listAcc = data.map((json) => UsersAcc.fromJson(json)).toList();
      return listAcc;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        setState(() {
          items.clear();
          itemsAcc.clear();
        });
      } else {
        items = listPostHome
            .where((item) =>
                (item.description).toLowerCase().contains(query.toLowerCase()))
            .toList();
        itemsAcc = listAcc
            .where((item) =>
                (item.nickname).toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencarian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                    searchText = value;
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              searchText.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: TextSpan(
                            text: 'Hasil untuk ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: searchText,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                            ]),
                      ),
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemsAcc.length,
                  itemBuilder: (context, index) {
                    final item = itemsAcc[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserAkun(
                                    id_user: item.id,
                                  ),
                                ));
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  // borderRadius:
                                  // const BorderRadius.all(Radius.circular(8)),
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 28,
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        TextHighlight(
                                          text: item.nickname,
                                          highlight: searchText,
                                          highlightColor: Colors.yellow,
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          item.company == null
                                              ? ""
                                              : ", " + item.company,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  //   RichText(
                                  //     text: TextSpan(
                                  //         text: item.nickname == null
                                  //             ? ""
                                  //             : item.nickname + ', ',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.black,
                                  //         ),
                                  //         children: <TextSpan>[
                                  //           TextSpan(
                                  //             text: item.company == null
                                  //                 ? ""
                                  //                 : item.company,
                                  //             style: TextStyle(
                                  //               fontWeight: FontWeight.normal,
                                  //               color: Colors.black,
                                  //             ),
                                  //           )
                                  //         ]),
                                  //   ),
                                  // ),
                                  ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPosting(
                                  company: item.company,
                                  description: item.description,
                                  id: item.id,
                                  image: item.image,
                                  nickname: item.nickname,
                                  title: item.title,
                                ),
                              )),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextHighlight(
                                  text: item.description,
                                  highlight: searchText,
                                  highlightColor: Colors.yellow,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                        color: Colors.grey[200],
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        size: 28,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: ListTile(
                                        title: Row(
                                          children: [
                                            Text(item.nickname == null
                                                ? ""
                                                : item.nickname),
                                          ],
                                        ),
                                        subtitle: Text(
                                          item.company == null
                                              ? ""
                                              : item.company,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextHighlight extends StatelessWidget {
  final String text;
  final String? highlight;
  final TextStyle textStyle;
  final Color highlightColor;

  const TextHighlight({
    required this.text,
    this.highlight,
    required this.textStyle,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (highlight == null || highlight!.isEmpty) {
      return Text(text, style: textStyle);
    }

    final matches = RegExp(
      RegExp.escape(highlight!),
      caseSensitive: false,
    ).allMatches(text);

    if (matches.isEmpty) {
      return Text(text, style: textStyle);
    }

    int start = 0;
    late Widget textWidget;

    final List<InlineSpan> children = [];

    for (var match in matches) {
      if (match.start > start) {
        children.add(TextSpan(
          text: text.substring(start, match.start),
          style: textStyle,
        ));
      }
      final highlightedText = TextSpan(
        text: text.substring(match.start, match.end),
        style: textStyle.copyWith(
          backgroundColor: highlightColor,
        ),
      );
      children.add(highlightedText);
      start = match.end;
    }

    if (start < text.length) {
      children.add(TextSpan(
        text: text.substring(start, text.length),
        style: textStyle,
      ));
    }

    textWidget = RichText(
      text: TextSpan(children: children),
    );

    return textWidget;
  }
}

class UsersAcc {
  final id;
  final idUser;
  final fullname;
  final nickname;
  final familyname;
  final gender;
  final datebirth;
  final birthplace;
  final employeeStatus;
  final phone;
  final countryPhone;
  final country;
  final description;
  final company;
  final jobPosition;
  final startYear;
  final endYear;
  final npwp;
  final latHouse;
  final longHouse;
  final addressHouse;
  final qrcode;
  final qrcodePath;
  final qrcodeLink;
  final createdAt;
  final updatedAt;

  UsersAcc({
    this.id,
    this.idUser,
    this.fullname,
    this.nickname,
    this.familyname,
    this.gender,
    this.datebirth,
    this.birthplace,
    this.employeeStatus,
    this.phone,
    this.countryPhone,
    this.country,
    this.description,
    this.company,
    this.jobPosition,
    this.startYear,
    this.endYear,
    this.npwp,
    this.latHouse,
    this.longHouse,
    this.addressHouse,
    this.qrcode,
    this.qrcodePath,
    this.qrcodeLink,
    this.createdAt,
    this.updatedAt,
  });

  factory UsersAcc.fromJson(Map<String, dynamic> json) => UsersAcc(
        id: json["id"],
        idUser: json["id_user"],
        fullname: json["fullname"],
        nickname: json["nickname"],
        familyname: json["familyname"],
        gender: json["gender"],
        datebirth: DateTime.parse(json["datebirth"]),
        birthplace: json["birthplace"],
        employeeStatus: json["employee_status"],
        phone: json["phone"],
        countryPhone: json["country_phone"],
        country: json["country"],
        description: json["description"],
        company: json["company"],
        jobPosition: json["job_position"],
        startYear: json["start_year"],
        endYear: json["end_year"],
        npwp: json["npwp"],
        latHouse: json["lat_house"],
        longHouse: json["long_house"],
        addressHouse: json["address_house"],
        qrcode: json["qrcode"],
        qrcodePath: json["qrcode_path"],
        qrcodeLink: json["qrcode_link"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
