import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/pgHome.dart';
import 'package:powershare/screens/user_akun.dart';
import 'package:powershare/services/global.dart';

import 'model/dbhelper.dart';

class DetailPosting extends StatefulWidget {
  final id;
  final title;
  final nickname;
  final company;
  final description;
  final image;
  const DetailPosting(
      {super.key,
      this.id,
      this.title,
      this.nickname,
      this.company,
      this.description,
      this.image});

  @override
  State<DetailPosting> createState() => _DetailPostingState();
}

class Comment {
  final int id;
  final int id_postings;
  final int id_user;
  final String nickname;
  final String toAnswer_posting;
  final String description;
  final List<Comment> repliedData;

  Comment({
    required this.id,
    required this.id_postings,
    required this.id_user,
    required this.nickname,
    required this.toAnswer_posting,
    required this.description,
    required this.repliedData,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    List<Comment> repliedData = [];
    if (json['repliedData'] != null) {
      repliedData = List<Comment>.from(
          json['repliedData'].map((reply) => Comment.fromJson(reply)));
    }
    return Comment(
      id: json['id'],
      id_postings: json['id_postings'],
      id_user: json['id_user'],
      nickname: json['nickname'],
      toAnswer_posting: json['toAnswer_posting'] ??
          "", // Atur ke 0 jika toAnswer_posting adalah null
      description: json['description'],
      repliedData: repliedData,
    );
  }
}

class Post {
  final int id;
  final String title;
  final String description;
  final List<Comment> repliedData;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.repliedData,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<Comment> repliedData = [];
    if (json['toAnswer_posting'] == null && json['repliedData'] != null) {
      repliedData = List<Comment>.from(
          json['repliedData'].map((comment) => Comment.fromJson(comment)));
    }
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      repliedData: repliedData,
    );
  }
}

class _DetailPostingState extends State<DetailPosting> {
  TextEditingController commentController = TextEditingController();
  List<dynamic> dataList = []; // List untuk menyimpan data dari API
  @override
  void initState() {
    // fetchData();
    super.initState();
    print("APANIHH:" + widget.id.toString());
    user();
    vote(widget.id);
  }

  // Method untuk mengambil data dari API
  Future<List<Post>> fetchData() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    final response = await http.get(
      Uri.parse(URL + 'posting/commentDetailPost/${widget.id}'),
      headers: {
        "Authorization": 'Bearer ${data[0].token}',
        "Accept": "application/json",
        "login-type": "0",
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  GetUser getUser = GetUser(follow_status: 0);
  String token = '';
  int idLogin = 0;
  user() async {
    final _db = DBhelper();
    var data = await _db.getToken();

    print(data[0].token);
    setState(() {
      token = data[0].token;
      idLogin = data[0].id;
    });
  }

  ShowVote showVote = ShowVote();
  vote(int id) async {
    showVote = await ShowVote.showVoting(id);
    print("LAPO" + showVote.upvote.toString());
    setState(() {});
  }

  int selectedVote = 0;
  updateVote(int id_posting, int vote) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      selectedVote = vote;
    });

    try {
      Vote.voting(
          data[0].token, id_posting, vote); // Ganti dengan data yang sesuai
    } catch (error) {
      setState(() {
        selectedVote = 0; // Reset selectedVote jika ada kesalahan
      });
      print('Error: $error');
    }
  }

  bool showComments = false; // State untuk mengontrol tampilan widget
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      appBar: AppBar(
          // leading: GestureDetector(
          //   onTap: () => Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => BottomNavBar(currentIndex: 0),
          //     ),
          //   ),
          //   child: Icon(Icons.arrow_back),
          // ),
          ),
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
                child: GestureDetector(
                  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserAkun(id_user: widget.),)),
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
                          // const Expanded(
                          //   flex: 1,
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       Text("Diperbarui 2th"),
                          //       SizedBox(
                          //         height: 20,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
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
                child: widget.image == null
                    ? SizedBox(
                        height: 5,
                      )
                    : Image.network(
                        URL + "posting/showImagePost/" + widget.image,
                        headers: {
                          "Authorization": 'Bearer ${token}',
                          "login-type": "0",
                        },
                        fit: BoxFit.cover,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        // width: 100,
                      ),
                // child: Image.network("${item.image}",
                //     fit: BoxFit.cover),
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
                                  InkWell(
                                    child: Icon(
                                      Icons.thumb_up,
                                      color: showVote.vote_status == 1
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (showVote.vote_status == 1) {
                                          selectedVote = 0;

                                          print(selectedVote);
                                          updateVote(widget.id, selectedVote);
                                          vote(widget.id);
                                        } else {
                                          selectedVote = 1;
                                          print("CENTANG" +
                                              selectedVote.toString());
                                          updateVote(widget.id, selectedVote);
                                          vote(widget.id);
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(showVote.upvote == 0 ||
                                          showVote.upvote == null
                                      ? ''
                                      : showVote.upvote.toString()),
                                  Container(
                                    height: 20,
                                    child: const VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.thumb_down,
                                      color: showVote.vote_status == 2
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if (showVote.vote_status == 2) {
                                          selectedVote = 0;
                                          updateVote(showVote.id_postings,
                                              selectedVote);
                                          vote(widget.id);
                                        } else {
                                          selectedVote = 2;
                                          updateVote(showVote.id_postings,
                                              selectedVote);
                                          vote(widget.id);
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(showVote.downvote == 0 ||
                                          showVote.upvote == null
                                      ? ''
                                      : showVote.downvote.toString()),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  showComments = !showComments;
                                  print(showComments);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: const Row(
                                  children: [
                                    Icon(Icons.chat_bubble),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    // Text("345"),
                                  ],
                                ),
                              ),
                            ),
                            //--share
                            // Container(
                            //   padding: const EdgeInsets.all(10),
                            //   child: const Row(
                            //     children: [
                            //       Icon(Icons.share),
                            //       // SizedBox(
                            //       //   width: 5,
                            //       // ),
                            //       // Text("120"),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      //--horiz
                      // GestureDetector(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //         isScrollControlled: true,
                      //         context: context,
                      //         builder: (context) {
                      //           return Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Container(
                      //                 padding: const EdgeInsets.all(15),
                      //                 width: MediaQuery.of(context).size.width,
                      //                 child: Stack(
                      //                   alignment: Alignment.centerLeft,
                      //                   children: <Widget>[
                      //                     GestureDetector(
                      //                       onTap: () {
                      //                         Navigator.pop(context);
                      //                       },
                      //                       child: Icon(Icons.close,
                      //                           color: Colors.red[900]),
                      //                     ),
                      //                     const Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: <Widget>[
                      //                         Text(
                      //                           'Jawab',
                      //                           style: TextStyle(
                      //                             color: Colors.grey,
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(15),
                      //                   width:
                      //                       MediaQuery.of(context).size.width,
                      //                   decoration: const BoxDecoration(
                      //                     border: Border(
                      //                       top: BorderSide(
                      //                           width: 0.5, color: Colors.grey),
                      //                     ),
                      //                   ),
                      //                   child: const Center(
                      //                     child: Text("Bagikan melalui.."),
                      //                   ),
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(15),
                      //                   width:
                      //                       MediaQuery.of(context).size.width,
                      //                   decoration: const BoxDecoration(
                      //                     border: Border(
                      //                       top: BorderSide(
                      //                           width: 0.5, color: Colors.grey),
                      //                     ),
                      //                   ),
                      //                   child: const Center(
                      //                     child:
                      //                         Text("Tidak tertarik dengan ini"),
                      //                   ),
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(15),
                      //                   width:
                      //                       MediaQuery.of(context).size.width,
                      //                   decoration: const BoxDecoration(
                      //                     border: Border(
                      //                       top: BorderSide(
                      //                           width: 0.5, color: Colors.grey),
                      //                     ),
                      //                   ),
                      //                   child:
                      //                       const Center(child: Text("Simpan")),
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(15),
                      //                   width:
                      //                       MediaQuery.of(context).size.width,
                      //                   decoration: const BoxDecoration(
                      //                     border: Border(
                      //                       top: BorderSide(
                      //                           width: 0.5, color: Colors.grey),
                      //                     ),
                      //                   ),
                      //                   child: const Center(
                      //                       child: Text(
                      //                           "Dorong turun pertamyaan")),
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(15),
                      //                   width:
                      //                       MediaQuery.of(context).size.width,
                      //                   decoration: const BoxDecoration(
                      //                     border: Border(
                      //                       top: BorderSide(
                      //                           width: 0.5, color: Colors.grey),
                      //                     ),
                      //                   ),
                      //                   child: const Center(child: Text("Log")),
                      //                 ),
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   padding: const EdgeInsets.all(15),
                      //                   width:
                      //                       MediaQuery.of(context).size.width,
                      //                   decoration: const BoxDecoration(
                      //                     border: Border(
                      //                       top: BorderSide(
                      //                           width: 0.5, color: Colors.grey),
                      //                     ),
                      //                   ),
                      //                   child: Center(
                      //                     child: Text("Laporkan",
                      //                         style: TextStyle(
                      //                           color: Colors.red[900],
                      //                         )),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //           );
                      //         });
                      //   },
                      //   child: const Icon(Icons.more_horiz),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (showComments)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                        height: 2,
                        color: Colors.grey[300],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 15, 10),
                      // color: Colors.grey[300],
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
                                    contentPadding: EdgeInsets.all(5),
                                    errorStyle: const TextStyle(fontSize: 16.0),
                                    hintText: 'Tambahkan komentar...',
                                    hintStyle: TextStyle(fontSize: 16),
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(25.0),
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
                              print(widget.id);
                              print(widget.title);
                              print(commentController.text);
                              PostComment.postComment(
                                  data[0].token,
                                  widget.id.toString(),
                                  widget.title,
                                  commentController.text);
                              commentController.clear();
                              // showComments = !showComments;
                            },
                            // padding: EdgeInsets.all(5),
                            child: const Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<List<Post>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final posts = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              print(posts[index].title);
                              return _buildCommentItemLvl1(
                                  context, posts[index], idLogin);
                            },
                          );
                        }
                      },
                    ),
                  ],
                )
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCommentItemLvl1(BuildContext context, Post post, int idLogin) {
  return Container(
    padding: EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final comment in post.repliedData
            .where((comment) => comment.toAnswer_posting != 0))
          _buildCommentItemLvl2(context, comment, idLogin),
      ],
    ),
  );
}

Widget _buildCommentItemLvl2(
    BuildContext context, Comment comment, int idLogin) {
  bool showReply = false; // State untuk mengontrol tampilan widget

  return Container(
    padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[100],
              ),
              child: Icon(
                Icons.person,
                size: 20,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${comment.nickname} ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          // fontSize: 12,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: comment.description,
                          style: TextStyle(
                              // fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  // Text("Comment #${comment.nickname}: ${comment.description}"),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showReply = !showReply;
                          print(comment.id);
                          print(showReply);
                          _modalBottomSheetComment(context, comment.id,
                              comment.description, comment.nickname);
                        },
                        child: Text("Balas"),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  SizedBox(height: 10),
                  // ListTile(

                  //   title:
                  //       Text("Comment #${comment.id}: ${comment.description}"),
                  //   subtitle: InkWell(
                  // onTap: () {
                  //   showReply = !showReply;
                  //   print(comment.id);
                  //   print(showReply);
                  //   _modalBottomSheetComment(context);
                  // },
                  //     child: Text("Balas"),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       hintText: "Balas..",
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Visibility(
            //   visible: idLogin == comment.id_user,
            //   child: PopupMenuButton(
            //     icon: Icon(Icons.more_vert),
            //     onSelected: (value) {
            //       deleteComment(comment.id_postings);
            //     },
            //     itemBuilder: (context) => [
            //       PopupMenuItem(
            //         value: 'item1',
            //         child: Text(
            //           'Hapus',
            //           style: TextStyle(
            //             color: Colors.red,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        if (comment.repliedData.isNotEmpty) ...[
          for (final reply in comment.repliedData) ...[
            _buildReplyHeader(reply.toAnswer_posting),
            _buildCommentItemLvl2(context, reply, idLogin),
          ],
        ],
      ],
    ),
  );
}

Future deleteComment(id) async {
  final _db = DBhelper();
  var data = await _db.getToken();
  DeletePosting.delete(data[0].token, id.toString()).then((value) {
    if (value.statusCode == 200) {
      Fluttertoast.showToast(
        msg: jsonDecode(value.body)["msg"],
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Navigator.pop(context);
    }
  });
  // final response = await http.get(
  //   Uri.parse(URL + 'reply/destroy/${id}'),
  //   headers: {
  //     "Authorization": 'Bearer ${data[0].token}',
  //     "Accept": "application/json",
  //     "login-type": "0",
  //   },
  // );
}

Widget _buildReplyHeader(String nickname) {
  return Padding(
    padding: EdgeInsets.only(left: 55),
    child: Text(
      'Membalas $nickname',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.grey),
    ),
  );
}

void _modalBottomSheetComment(
    BuildContext context, int comment_id, String description, String nickname) {
  TextEditingController balasan = TextEditingController();
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
            padding: EdgeInsets.only(
                top: 10,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: balasan,
                  decoration: InputDecoration(
                    hintText: 'Balas @${nickname}',
                    border: InputBorder.none,
                  ),
                  autofocus: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () async {
                          final _db = DBhelper();
                          var data = await _db.getToken();
                          PostComment.postComment(data[0].token,
                              comment_id.toString(), description, balasan.text);
                          balasan.clear();
                          Navigator.pop(context);
                        },
                        child: Text("Kirim")),
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ));
}
