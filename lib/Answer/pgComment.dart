import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgDetailPosting.dart';
import 'package:share_plus/share_plus.dart';

class PgComment extends StatefulWidget {
  const PgComment({super.key});

  @override
  State<PgComment> createState() => _PgCommentState();
}

class _PgCommentState extends State<PgComment> {
  @override
  void initState() {
    super.initState();
    fetchComment();
  }

  List<ShowComment> comments = [];
  ShowComment showComment = ShowComment();
  fetchComment() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    comments = await showComment.getComments(data[0].token);
    setState(() {});
    print(comments.length);
  }

  int selectedVote = 0;
  int selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final content = comments[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                        ],
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.fromLTRB(
                          //     15 * fem,
                          //     0,
                          //     15 * fem,
                          //     0,
                          //   ),
                          //   child: Container(
                          //     // color: Colors.red,
                          //     child: IntrinsicHeight(
                          //       child: Row(
                          //         children: [
                          //           Container(
                          //             padding: const EdgeInsets.all(5),
                          //             decoration: BoxDecoration(
                          //               borderRadius: const BorderRadius.all(
                          //                   Radius.circular(8)),
                          //               color: Colors.grey[200],
                          //             ),
                          //             child: const Icon(
                          //               Icons.person,
                          //               size: 28,
                          //             ),
                          //           ),
                          //           // Expanded(
                          //           //   flex: 3,
                          //           //   child: ListTile(
                          //           //     title: Row(
                          //           //       children: [
                          //           //         Text(content.nickname),
                          //           //         // Follow(
                          //           //         //     idLogin: id_user
                          //           //         //         .toString(),
                          //           //         //     idUser: content.id_user
                          //           //         //         .toString(),
                          //           //         //     isFollowing:
                          //           //         //         followStatus[content
                          //           //         //                 .id_user] ??
                          //           //         //             false,
                          //           //         //     onPressed: () {
                          //           //         //       toggleFollow(
                          //           //         //           content.id_user);
                          //           //         //       Following.follow(
                          //           //         //           token,
                          //           //         //           content.id_user
                          //           //         //               .toString(),
                          //           //         //           following_id
                          //           //         //               .toString());
                          //           //         //     }),
                          //           //       ],
                          //           //     ),
                          //           //     subtitle: Text(
                          //           //       content.company,
                          //           //       overflow: TextOverflow.ellipsis,
                          //           //     ),
                          //           //   ),
                          //           // ),
                          //           // const Expanded(
                          //           //   // height: MediaQuery.of(context).size.height / 25,
                          //           //   // height:43 * fem,
                          //           //   // color: Colors.blue,
                          //           //   flex: 1,
                          //           //   child: Column(
                          //           //     mainAxisAlignment:
                          //           //         MainAxisAlignment.end,
                          //           //     children: [
                          //           //       Text("Diperbarui 2th"),
                          //           //       SizedBox(
                          //           //         height: 20,
                          //           //       ),
                          //           //     ],
                          //           //   ),
                          //           // ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   color: Colors.white,
                          //   child: const Row(
                          //     children: <Widget>[
                          //       Expanded(
                          //         child: Divider(
                          //           color: Colors.grey,
                          //           thickness: 2,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              print(content.company);
                              print(content.description_post);
                              print(content.id_post);
                              print(content.image_post);
                              print(content.nickname);
                              print(content.title_post);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPosting(
                                      company: content.company,
                                      description: content.description_post,
                                      id: content.id_post,
                                      // image: content.image_post,
                                      image: '',
                                      nickname: content.nickname,
                                      title: content.title_post,
                                    ),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                15 * fem,
                                10 * fem,
                                15 * fem,
                                15 * fem,
                              ),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[400],
                              child: Text(
                                content.description_post,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => DetailPosting(
                              //         id: content.id,
                              //         title: content.title == null
                              //             ? ""
                              //             : content.title,
                              //         nickname: content.nickname,
                              //         company: content.company,
                              //         description: content.description == null
                              //             ? ''
                              //             : content.description,
                              //         image: content.image == null
                              //             ? ""
                              //             : content.image,
                              //       ),
                              //     ));
                              // print(content.id);
                              // print(content.id_user);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                15 * fem,
                                10 * fem,
                                15 * fem,
                                0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   content.title == null ? "" : content.title,
                                  //   style: const TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.w500,
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
                                  ExpandableText(
                                    content.description == null
                                        ? ""
                                        : content.description,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 3,
                                    linkColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   // decoration: BoxDecoration(
                          //   //   border: Border.all(
                          //   //     //<-- SEE HERE
                          //   //     width: 5,
                          //   //   ),
                          //   // ),
                          //   child: Image.network("${content.image}",
                          //       fit: BoxFit.cover),
                          // ),
                          Container(
                            width: double.infinity,
                            // color: Colors.red,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        // Container(
                                        //   padding: const EdgeInsets.all(10),
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.grey[300],
                                        //     borderRadius:
                                        //         const BorderRadius.all(
                                        //       Radius.circular(50),
                                        //     ),
                                        //   ),
                                        //   child: Row(
                                        //     children: [
                                        //       InkWell(
                                        //         child: Icon(
                                        //           Icons.thumb_up,
                                        //           color:
                                        //               selectedIndex == index &&
                                        //                       selectedVote == 1
                                        //                   ? Colors.blue
                                        //                   : Colors.grey,
                                        //         ),
                                        //         onTap: () {
                                        //           setState(() {
                                        //             if (selectedVote == 1) {
                                        //               selectedVote = 0;
                                        //               updateVote(content.id,
                                        //                   selectedVote);
                                        //             } else {
                                        //               selectedVote = 1;
                                        //               print(content
                                        //                   .id.runtimeType);
                                        //               updateVote(content.id,
                                        //                   selectedVote);
                                        //             }
                                        //           });
                                        //         },
                                        //       ),
                                        //       const SizedBox(
                                        //         width: 5,
                                        //       ),
                                        //       const Text("12,5rb"),
                                        //       Container(
                                        //         height: 20,
                                        //         child: const VerticalDivider(
                                        //           color: Colors.black,
                                        //           thickness: 1,
                                        //         ),
                                        //       ),
                                        //       InkWell(
                                        //         child: Icon(
                                        //           Icons.thumb_down,
                                        //           color:
                                        //               selectedIndex == index &&
                                        //                       selectedVote == 2
                                        //                   ? Colors.blue
                                        //                   : Colors.grey,
                                        //         ),
                                        //         onTap: () {
                                        //           setState(() {
                                        //             if (selectedVote == 2) {
                                        //               selectedVote = 0;
                                        //               updateVote(content.id,
                                        //                   selectedVote);
                                        //             } else {
                                        //               selectedVote = 2;
                                        //               updateVote(content.id,
                                        //                   selectedVote);
                                        //             }
                                        //           });
                                        //         },
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     // print(content.id);
                                        //     // commentVisible[content.id] =
                                        //     //     !(commentVisible[content.id] ??
                                        //     //         true);
                                        //     // print('lohe:' +
                                        //     //     commentVisible.toString());
                                        //   },
                                        //   child: Container(
                                        //     padding: const EdgeInsets.all(10),
                                        //     child: const Row(
                                        //       children: [
                                        //         Icon(Icons.chat_bubble),
                                        //         SizedBox(
                                        //           width: 5,
                                        //         ),
                                        //         Text("345"),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // GestureDetector(
                                        //   onTap: () async {
                                        //     const urlPreview =
                                        //         'https://docs.google.com/spreadsheets/d/1FsG3d2vkTGiFbNP3LkjdAmBh66CcL40B3s-pupd1GQU/edit#gid=2068281591';

                                        //     await Share.share(
                                        //         'Check out this great video\n\n$urlPreview');
                                        //   },
                                        //   child: Container(
                                        //     padding: const EdgeInsets.all(10),
                                        //     child: const Row(
                                        //       children: [
                                        //         Icon(Icons.share),
                                        //         SizedBox(
                                        //           width: 5,
                                        //         ),
                                        //         Text("120"),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   padding: EdgeInsets.all(10),
                                        //   child: Row(
                                        //     children: [
                                        //       Icon(Icons.share),
                                        //       SizedBox(
                                        //         width: 5,
                                        //       ),
                                        //       Text("120"),
                                        //     ],
                                        //   ),
                                        // ),
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
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
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
                                                        child: Icon(Icons.close,
                                                            color: Colors
                                                                .red[900]),
                                                      ),
                                                      const Row(
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: const Center(
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: const Center(
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: const Center(
                                                        child: Text("Simpan")),
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: const Center(
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text("Laporkan",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.red[900],
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
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
