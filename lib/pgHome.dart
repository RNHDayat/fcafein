import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'model/dbhelper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class Post {
  final String title;
  final String description;
  Post(this.title, this.description);
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  bool isExpanded = false;
  String title =
      "Satu kata yang muncul di pikiranku ketika melihat foto ini, PEDIH! Bagaimana dengan kalian?Halo para Quorawan, ini tulisan pertamaku so m";

  final _numberOfPostsPerRequest = 5;

  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 200) {
      setState(() {
        _showBackToTopButton = true;
      });
    } else {
      setState(() {
        _showBackToTopButton = false;
      });
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final _db = DBhelper();
      var data = await _db.getToken();
      print(data[0].token);
      final response = await get(
        Uri.parse(
            "http://10.0.2.2:8000/api/home?_page=$pageKey&_limit=$_numberOfPostsPerRequest"),
        headers: {
          "Authorization": 'Bearer ${data[0].token}',
          "Accept": "application/json",
          "login-type": "0",
        },
      );
      var responseList = json.decode(response.body);
      List<MapEntry<String, dynamic>> mapEntries = [];
      mapEntries = responseList.entries.toList();
      // print(mapEntries[1][0]);
      List result = mapEntries.firstWhere((entry) => entry.key == 'data').value;
      print(result);
      // print(responseList);
      // Mendecode JSON menjadi List<Map<String, dynamic>>
      // List<Map<String, dynamic>> responses =
      //     List<Map<String, dynamic>>.from(responseList["data"]);

      // Mencetak hasil
      // responses.forEach((item) {
      //   print(
      //       'title: ${item['title']}, description: ${item['description']}');
      // });
      // print(responseList.length);
      List<Post> postList = result
          .map((data) =>
              Post(data['title'], data['description']))
          .toList();
      print(postList.length);
      final isLastPage = postList.length < _numberOfPostsPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(postList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(postList, nextPageKey);
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.fromLTRB(fem, fem, fem, 5 * fem),
              padding:
                  EdgeInsets.fromLTRB(15 * fem, 10 * fem, 15 * fem, 15 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              // padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.grey[200],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // width: MediaQuery.of(context).size.width * 2,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TambahPertanyaan(initialIndex: 0),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Apa yang ingin Anda tanyakan atau bagikan?',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TambahPertanyaan(initialIndex: 0),
                          ));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              // ignore: prefer_const_constructors
                              Icon(Icons.question_mark_rounded),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Tanya",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => BottomNavBar(currentIndex: 2),
                          ));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.question_answer),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Jawab",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TambahPertanyaan(initialIndex: 1),
                          ));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text("Kiriman"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RefreshIndicator(
              onRefresh: () => Future.sync(() => _pagingController.refresh()),
              child: PagedListView<int, Post>(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Post>(
                  itemBuilder: (context, item, index) => Column(
                    children: [
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                15 * fem,
                                0,
                                15 * fem,
                                0,
                              ),
                              child: Container(
                                // color: Colors.red,
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Colors.grey[200],
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          size: 28,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: ListTile(
                                          title: Text("Nur Rojabiyah"),
                                          subtitle: Text(
                                            "S1 di Teknik Fisika, Institut Teknologi Sepuluh Surabaya",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        // height: MediaQuery.of(context).size.height / 25,
                                        // height:43 * fem,
                                        // color: Colors.blue,
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("Diperbarui 2th"),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                15 * fem,
                                10 * fem,
                                15 * fem,
                                15 * fem,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ExpandableText(
                                    item.description,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 3,
                                    linkColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  //<-- SEE HERE
                                  width: 5,
                                ),
                              ),
                              child: Image.asset("assets/logo/logo.png"),
                            ),
                            Container(
                              width: double.infinity,
                              // color: Colors.red,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.thumb_up),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("12,5rb"),
                                                Container(
                                                  height: 20,
                                                  child: VerticalDivider(
                                                    color: Colors.black,
                                                    thickness: 1,
                                                  ),
                                                ),
                                                Icon(Icons.thumb_down),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.chat_bubble),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("345"),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.share),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("120"),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    // width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(
                                                              Icons.close,
                                                              color: Colors
                                                                  .red[900]),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              'Jawab',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            "Bagikan melalui.."),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                            "Tidak tertarik dengan ini"),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child:
                                                              Text("Simpan")),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                              "Dorong turun pertamyaan")),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Center(
                                                          child: Text("Log")),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(
                                                              width: 0.5,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text("Laporkan",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .red[900],
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                      child: Icon(Icons.more_horiz),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
