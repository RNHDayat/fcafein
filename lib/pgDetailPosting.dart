import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:powershare/model/database.dart';

import 'model/dbhelper.dart';

class DetailPosting extends StatefulWidget {
  final id;
  final String title;
  final String nickname;
  final String company;
  final String description;
  final String image;
  const DetailPosting(
      {super.key,
      required this.id,
      required this.title,
      required this.nickname,
      required this.company,
      required this.description,
      required this.image});

  @override
  State<DetailPosting> createState() => _DetailPostingState();
}

class _DetailPostingState extends State<DetailPosting> {
  TextEditingController commentController = TextEditingController();
  List<dynamic> dataList = []; // List untuk menyimpan data dari API
  @override
  void initState() {
    // fetchData();
    super.initState();
  }

  // Method untuk mengambil data dari API
  Future<void> fetchData() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/posting/detail/${widget.id}'),
      headers: {
        "Authorization": 'Bearer ${data[0].token}',
        "Accept": "application/json",
        "login-type": "0",
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        // var data = json.decode(response.body);

        dataList = json.decode(response.body);
        print(dataList[0]['repliedData']);
        // dataList =response.body;
        // Ubah state dataList dengan data baru dari API
        // dataList = YOUR_DATA_PROCESSING_LOGIC(response.body);
      });
    } else {
      print('ada yang salah brow');
      print(response.statusCode);
    }
  }

  func(dataList) {
    for (var i in dataList) {
      Container();
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
            ),
            child: const Icon(
              Icons.person,
              size: 28,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text('komen'),
            ),
          ),
        ],
      );
      if (i['repliedData'] != 0) {
        func(i['repliedData']);
      }
      // print(i['repliedData']);
    }
  }

  bool showWidgets = false; // State untuk mengontrol tampilan widget

  Widget buildWidgetList(List<dynamic> data) {
    List<Widget> widgets = [];

    for (var i in data) {
      widgets.add(Container());
      widgets.add(
        Container(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[100],
                ),
                child: const Icon(
                  Icons.person,
                  size: 28,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(i['title']),
                ),
              ),
            ],
          ),
        ),
      );
      if (i['repliedData'] != 0) {
        widgets.add(buildWidgetList(i['repliedData']));
      }
    }

    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  15 * fem,
                  15 * fem,
                  15 * fem,
                  0,
                ),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  15 * fem,
                  0,
                  15 * fem,
                  0,
                ),
                child: Container(
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
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
                                Text(widget.nickname),
                              ],
                            ),
                            subtitle: Text(
                              widget.company,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                child: const Row(
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
                    ExpandableText(
                      widget.description,
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
                child: Image.network(widget.image, fit: BoxFit.cover),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.thumb_up),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("12,5rb"),
                                  Container(
                                    height: 20,
                                    child: const VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  const Icon(Icons.thumb_down),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showWidgets = !showWidgets;
                                print(showWidgets);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: const Row(
                                  children: [
                                    Icon(Icons.chat_bubble),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("345"),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Row(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Icon(Icons.close,
                                                color: Colors.red[900]),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Jawab',
                                                style: TextStyle(
                                                  color: Colors.grey,
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
                                        padding: const EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text("Bagikan melalui.."),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                        ),
                                        child: const Center(
                                          child:
                                              Text("Tidak tertarik dengan ini"),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                        ),
                                        child:
                                            const Center(child: Text("Simpan")),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                        ),
                                        child: const Center(
                                            child: Text(
                                                "Dorong turun pertamyaan")),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                        ),
                                        child: const Center(child: Text("Log")),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("Laporkan",
                                              style: TextStyle(
                                                color: Colors.red[900],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.all(5),
                        child: TextFormField(
                          controller: commentController,
                          decoration: new InputDecoration(
                              errorStyle: const TextStyle(fontSize: 18.0),
                              hintText: 'Tambahkan komentar...',
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0))),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        final _db = DBhelper();
                        var data = await _db.getToken();
                        Comment.postComment(data[0].token, widget.id.toString(),
                            widget.title, commentController.text);
                      },
                      // padding: EdgeInsets.all(5),
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
              // if (showWidgets) buildWidgetList(dataList),
              // func(dataList) == null ? Text('nothing') : func(dataList),
              // Container(
              //   padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              //   color: Colors.grey[300],
              //   child: Row(
              //     children: [
              //       Container(
              //         padding: EdgeInsets.all(5),
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Colors.grey[100],
              //         ),
              //         child: Icon(
              //           Icons.person,
              //           size: 28,
              //         ),
              //       ),
              //       SizedBox(width: 10),
              //       Expanded(
              //         child: Container(
              //           padding: EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(25),
              //           ),
              //           child: Text('komen'),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
