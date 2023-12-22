import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgDetailPosting.dart';
import 'package:powershare/screens/user_akun.dart';
import 'package:powershare/services/global.dart';
import 'package:share_plus/share_plus.dart';

class DetailIlmu extends StatefulWidget {
  final id;
  final String codeIlmu;
  final String name;

  const DetailIlmu(
      {super.key,
      required this.codeIlmu,
      required this.id,
      required this.name});

  @override
  State<DetailIlmu> createState() => _DetailIlmuState();
}

class _DetailIlmuState extends State<DetailIlmu> {
  @override
  void initState() {
    // TODO: implement initState
    user();
    super.initState();
    print(widget.codeIlmu);
    getIlmu();
    // getFollower();
  }

  FollowingIlmu followingIlmu = FollowingIlmu();
  bool followIlmu = false;
  getFollower() async {
    FollowingIlmu.getFollow(token, widget.codeIlmu).then((value) {
      setState(() {
        followingIlmu = value;
        if (followingIlmu.status_follow == 1) {
          followIlmu = true;
        } else {
          followIlmu = false;
        }
        print(followingIlmu.id);
        print(followingIlmu.status_follow);
      });
    });
  }

  GetUser getUser = GetUser(follow_status: 0);
  // late int id;
  String token = '';
  int id_user = 0;
  user() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    setState(() {
      token = data[0].token;
      id_user = data[0].id;
      getFollower();
    });
  }

  List<DetailPageIlmu> postinganIlmu = [];
  DetailPageIlmu pageIlmu = DetailPageIlmu();

  getIlmu() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    postinganIlmu = await pageIlmu.get(context, data[0].token, widget.codeIlmu);
    setState(() {});
  }

  final Map<int, bool> followStatus = {};
  late int following_id;

  void toggleFollow(int userId) {
    setState(() {
      followStatus[userId] = !(followStatus[userId] ?? false);
      if (followStatus[userId] == true) {
        following_id = 1;
      } else {
        following_id = 3;
      }
      print(followStatus);
    });
  }

  final Map<int, bool> followIlmuStatus = {};
  late int followingIlmu_id;

  void toggleFollowIlmu(int id_ilmu) {
    setState(() {
      followIlmuStatus[id_ilmu] = !(followIlmuStatus[id_ilmu] ?? false);
      if (followIlmuStatus[id_ilmu] == true) {
        followingIlmu_id = 1;
      } else {
        followingIlmu_id = 2;
      }
      print(followIlmuStatus);
    });
  }

  final Map<int, bool> comment = {};
  final commentVisible = <int, bool>{};
  // late int following_id;

  void toggleComment(int userId) {
    setState(() {
      comment[userId] = !(comment[userId] ?? false);
      // if (followStatus[userId] == true) {
      //   following_id = 1;
      // } else {
      //   following_id = 3;
      // }
      print(comment);
    });
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
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Center(
                child: RichText(
                  text: const TextSpan(
                      text: '80K',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Postingan',
                          style: TextStyle(color: Colors.grey),
                        )
                      ]),
                ),
              ),
              SizedBox(height: 10),
              FollowIlmuButton(
                isFollowing: followIlmu,
                onPressed: () {
                  // toggleFollowIlmu(widget.id);
                  setState(() {
                    followIlmu = !followIlmu;
                    FollowIlmu.pushFollow(token, widget.codeIlmu);
                  });
                },
              ),
              SizedBox(height: 10),
              Divider(thickness: 2),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: postinganIlmu.length,
                itemBuilder: (context, index) {
                  final item = postinganIlmu[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                              0,
                              15 * fem,
                              0,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserAkun(id_user: item.id_user),
                                  )),
                              child: Container(
                                // color: Colors.red,
                                child: IntrinsicHeight(
                                  child: Row(
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
                                              // FollowButton(
                                              //     isFollowing: followStatus[
                                              //             item.id_user] ??
                                              //         false,
                                              //     onPressed: () {
                                              //       toggleFollow(item.id_user);
                                              //       Following.follow(
                                              //           token,
                                              //           item.id_user.toString(),
                                              //           following_id
                                              //               .toString());
                                              //     }),
                                              // TextButton(
                                              //   onPressed: () {
                                              //     setState(() {
                                              //       item.isFollow =
                                              //           !item.isFollow;
                                              //       print(index);
                                              //       toggleFollow(item.id);
                                              //     });
                                              //   },
                                              //   child: Text(
                                              //     item.isFollow
                                              //         ? 'mengikuti'
                                              //         : 'ikuti',
                                              //     style: TextStyle(
                                              //         color: followStatus
                                              //             ? Colors.grey
                                              //             : Colors.blue),
                                              //   ),
                                              // ),
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
                                      const Expanded(
                                        // height: MediaQuery.of(context).size.height / 25,
                                        // height:43 * fem,
                                        // color: Colors.blue,
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // Text("Diperbarui 2th"),
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPosting(
                                      id: item.id,
                                      title:
                                          item.title == null ? "" : item.title,
                                      nickname: item.nickname,
                                      company: item.company,
                                      description: item.description == null
                                          ? ''
                                          : item.description,
                                      image: item.image == null
                                          ? null
                                          : item.image,
                                      // image: item.image == null
                                      //     ? ""
                                      //     : item.image,
                                    ),
                                  ));
                              print(item.id);
                              print(item.id_user);
                              print(item.image);
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
                                  Text(
                                    item.title == null ? "" : item.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ExpandableText(
                                    item.description == null
                                        ? ""
                                        : item.description,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 3,
                                    linkColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            child: item.image == null
                                ? SizedBox(
                                    height: 5,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          icon: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Hero(
                                            tag: item.id,
                                            child: Image.network(
                                              URL +
                                                  "posting/showImagePost/" +
                                                  item.image,
                                              headers: {
                                                "Authorization":
                                                    'Bearer ${token}',
                                                "login-type": "0",
                                              },
                                              fit: BoxFit.cover,

                                              // height: 100,
                                              // width: 100,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Hero(
                                        tag: item.id,
                                        child: Image.network(
                                          URL +
                                              "posting/showImagePost/" +
                                              item.image,
                                          headers: {
                                            "Authorization": 'Bearer ${token}',
                                            "login-type": "0",
                                          },
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // width: 100,
                                        ),
                                      ),
                                    ),
                                  ),
                            // child: Image.network("${item.image}",
                            //     fit: BoxFit.cover),
                          ),
                          // Text(item.vote_status.toString()),
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

class FollowIlmuButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onPressed;

  FollowIlmuButton({required this.isFollowing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        isFollowing ? 'mengikuti' : 'ikuti',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isFollowing ? Colors.grey : Colors.blue,
        elevation: 0,
        padding: EdgeInsets.only(left: 50, right: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

//follow akun user in ilmu
class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onPressed;
  final String idLogin;
  final String idUser;

  FollowButton(
      {required this.isFollowing,
      required this.onPressed,
      required this.idLogin,
      required this.idUser});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        idUser == idLogin
            ? ''
            : isFollowing
                ? 'mengikuti'
                : 'ikuti',
        style: TextStyle(color: isFollowing ? Colors.grey : Colors.blue),
      ),
    );
  }
}

class CommentButton extends StatelessWidget {
  final bool isComment;
  final VoidCallback onPressed;

  CommentButton({required this.isComment, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
    );
  }
}
