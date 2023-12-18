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
                                      image: null,
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
