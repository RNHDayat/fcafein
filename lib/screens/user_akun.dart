import 'dart:convert';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgDetailPosting.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/add_tahutentang.dart';
import 'package:powershare/screens/edit_profile.dart';
import 'package:powershare/screens/edit_question.dart';
import 'package:powershare/screens/screen_ruang.dart';
import 'package:powershare/screens/user_follower.dart';
import 'package:share_plus/share_plus.dart';

import '../components/follow_button.dart';
import '../components/photozoom.dart';
import '../model/database.dart';
import '../services/global.dart';

class UserAkun extends StatefulWidget {
  final int id_user;
  const UserAkun({super.key, required this.id_user});
  @override
  _UserAkun createState() => _UserAkun();
}

class _UserAkun extends State<UserAkun> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  // Followers followers = Followers();

  final List<String> _tabTitles = [
    'Profil',
    'Jawaban',
  ];
  final List<String> _tabTitle = [
    'Profil',
  ];

  int idUserLogin = 0;
  @override
  void initState() {
    // _tabController = TabController(length: _tabTitle.length, vsync: this);
    super.initState();
    userLogin();
    setId();
    fetchFollowers();
    fetchFollowings();
    getCredential();
    getPostingProfile();
    getPostingProfileAnswer();
  }

  List<ShowCredentials> credentials = [];
  ShowCredentials showCredentials = ShowCredentials();

  getCredential() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    credentials = await showCredentials.getCredential(
        data[0].token, widget.id_user.toString());
    setState(() {});
    print(credentials[0].description);
  }

  Widget getIcon(int type) {
    IconData iconData;
    if (type == 0) {
      iconData = Icons.construction;
    } else if (type == 1) {
      iconData = Icons.school;
    } else if (type == 2) {
      iconData = Icons.location_on_outlined;
    } else if (type == 3) {
      iconData = Icons.work;
    } else if (type == 4) {
      iconData = Icons.military_tech;
    } else {
      iconData = Icons.error;
    }
    return Icon(iconData);
  }

  setId() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      idUserLogin = data[0].id;
      _tabController = TabController(
          length: idUserLogin == widget.id_user
              ? _tabTitles.length
              : _tabTitle.length,
          vsync: this);
    });
  }

  // Followers getFollowers = Followers();
  // String userId = '';
  // String followingId = '';
  // String status = '';
  // String namefollow = '';
  // String nickfollow = '';
  // String companyfollowers = '';
  // String jobfollowers = '';

  // List<Followers> followerList = [];

  // fetchFollowers() async {
  //   final _db = DBhelper();
  //   var data = await _db.getToken();
  //   print(data[0].token);
  //   Followers.followers(data[0].token).then((value) {
  //     setState(() {
  //       followerList.add(value);
  //       getFollowers = value;
  //       userId = getFollowers.id_user!;
  //       followingId = getFollowers.following_id!;
  //       status = getFollowers.follow_status!;
  //       namefollow = getFollowers.fullname!;
  //       nickfollow = getFollowers.nickname!;
  //       companyfollowers = getFollowers.company!;
  //       jobfollowers = getFollowers.job_position!;
  //       print(userId);
  //       print(followingId);
  //       print(status);
  //       print(namefollow);
  //       print(nickfollow);
  //     });
  //   });
  // }

  ShowFollow getFollowings = ShowFollow();
  List<ShowFollow> followingList = [];

  fetchFollowings() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    followingList =
        await getFollowings.showfollowings(data[0].token, widget.id_user);
    setState(() {});
  }

  List<ShowFollow> followerList = [];

  fetchFollowers() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    followerList =
        await getFollowings.showfollowers(data[0].token, widget.id_user);
    setState(() {});
  }

  String token = '';

  // List<GetUser> user = [];
  GetUser user = GetUser(follow_status: 0);
  userLogin() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    // print(data[0].token);
    user = await GetUser.getUser(data[0].token, widget.id_user);
    token = data[0].token;
    setState(() {});
  }

  List<ShowPostingProfile> postingProfile = [];
  // ShowPostingProfile showPostingProfile = ShowPostingProfile();
  getPostingProfile() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    postingProfile = await ShowPostingProfile.getPostingProfile(
        data[0].token, widget.id_user);
    setState(() {});
    print(postingProfile.length);
  }

  List<ShowPostingProfileAnswer> postingAnswer = [];
  // ShowPostingProfile showPostingProfile = ShowPostingProfile();
  getPostingProfileAnswer() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    postingAnswer =
        await ShowPostingProfileAnswer.getPostingProfile(data[0].token);
    setState(() {});
    print(postingAnswer.length);
  }

  int selectedVote = 0;
  int selectedIndex = 0;
  updateVote(int id_posting, int voting, ShowPostingProfile post) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      selectedVote = voting;
    });

    try {
      // print('id: ' + post.id.toString());
      // print('up: ' + post.upvote.toString());
      // print('down: ' + post.downvote.toString());
      Vote.voting(data[0].token, id_posting, voting).then((val) {
        ShowVote.showVoting(int.parse(val.postingsId)).then((value) {
          setState(() {
            post.vote_status = value.vote_status;
            post.upvote = value.upvote;
            post.downvote = value.downvote;
            // print('up: ' + post.upvote.toString());
            // print('down: ' + post.downvote.toString());
            // print('up: ' + value.upvote.toString());
            // print('down: ' + value.downvote.toString());
          });
        });
      });
    } catch (error) {
      setState(() {
        selectedVote = 0; // Reset selectedVote jika ada kesalahan
      });
      print('Error: $error');
    }
  }

  int selectedVoted = 0;
  int selectedIndexAnswer = 0;
  updateVoteAnswer(
      int id_posting, int voting, ShowPostingProfileAnswer post) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      selectedVote = voting;
    });

    try {
      // print('id: ' + post.id.toString());
      // print('up: ' + post.upvote.toString());
      // print('down: ' + post.downvote.toString());
      Vote.voting(data[0].token, id_posting, voting).then((val) {
        ShowVote.showVoting(int.parse(val.postingsId)).then((value) {
          setState(() {
            post.vote_status = value.vote_status;
            post.upvote = value.upvote;
            post.downvote = value.downvote;
            // print('up: ' + post.upvote.toString());
            // print('down: ' + post.downvote.toString());
            // print('up: ' + value.upvote.toString());
            // print('down: ' + value.downvote.toString());
          });
        });
      });
    } catch (error) {
      setState(() {
        selectedVote = 0; // Reset selectedVote jika ada kesalahan
      });
      print('Error: $error');
    }
  }

  ShowVote showVote = ShowVote();
  vote(int id) async {
    showVote = await ShowVote.showVoting(id);
    setState(() {
      print(showVote.id_postings.toString());
      print('jml:' + showVote.upvote.toString());
    });
    // return showVote;
    // print('niggggg:' + showVote.id_postings.toString());
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

  // List<dynamic> followUsers = [];

  // Future<void> fetchFollowUsers() async {
  //   final response = await get(Uri.parse('http://10.0.2.2:8000/followers'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       followUsers = json.decode(response.body);
  //     });
  //   } else {
  //     throw Exception('Failed to load follow users');
  //   }
  // }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    Widget profil() {
      return Container(
        child: Column(
          children: [
            // Container(
            //   height: 50,
            //   decoration: const BoxDecoration(
            //     // color: Colors.red,
            //     border: Border(
            //       bottom: BorderSide(
            //         color: Color.fromRGBO(217, 217, 217, 100),
            //         width: 1.0,
            //       ),
            //     ),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       children: [
            //         Text(
            //           "Profil",
            //           style: GoogleFonts.poppins(
            //             textStyle: const TextStyle(
            //                 fontSize: 12, fontWeight: FontWeight.w500),
            //           ),
            //         ),
            //         const Spacer(),
            //         GestureDetector(
            //           onTap: () {
            //             showModalBottomSheet(
            //               context: context,
            //               builder: (BuildContext context) {
            //                 return Container(
            //                   decoration: const BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.only(
            //                       topLeft: Radius.circular(15.0),
            //                       topRight: Radius.circular(15.0),
            //                     ),
            //                   ),
            //                   height: 150.0,
            //                   child: Center(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                             decoration: const BoxDecoration(
            //                               border: Border(
            //                                 bottom: BorderSide(
            //                                   color: Color.fromRGBO(
            //                                       217, 217, 217, 100),
            //                                   width: 1.0,
            //                                 ),
            //                               ),
            //                             ),
            //                             height: 50,
            //                             child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.center,
            //                               children: [
            //                                 SizedBox(
            //                                   child: Text(
            //                                     'Diurutkan berdasarkan',
            //                                     textAlign: TextAlign.center,
            //                                     style: GoogleFonts.poppins(
            //                                       textStyle: const TextStyle(
            //                                           fontSize: 12,
            //                                           fontWeight:
            //                                               FontWeight.w500,
            //                                           color: Colors.grey),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             )),
            //                         ElevatedButton(
            //                           style: ElevatedButton.styleFrom(
            //                             alignment: Alignment.centerLeft,
            //                             backgroundColor: Colors.transparent,
            //                             elevation: 0,
            //                           ),
            //                           onPressed: () {},
            //                           child: Container(
            //                               decoration: const BoxDecoration(
            //                                 border: Border(
            //                                   bottom: BorderSide(
            //                                     color: Color.fromRGBO(
            //                                         217, 217, 217, 100),
            //                                     width: 1.0,
            //                                   ),
            //                                 ),
            //                               ),
            //                               height: 50,
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                 children: [
            //                                   SizedBox(
            //                                     child: Text(
            //                                       'Terbaru',
            //                                       textAlign: TextAlign.center,
            //                                       style: GoogleFonts.poppins(
            //                                         textStyle: const TextStyle(
            //                                           fontSize: 12,
            //                                           fontWeight:
            //                                               FontWeight.w500,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               )),
            //                         ),
            //                         ElevatedButton(
            //                           style: ElevatedButton.styleFrom(
            //                             alignment: Alignment.centerLeft,
            //                             backgroundColor: Colors.transparent,
            //                             elevation: 0,
            //                           ),
            //                           onPressed: () {},
            //                           child: Container(
            //                               decoration: const BoxDecoration(
            //                                 border: Border(
            //                                   bottom: BorderSide(
            //                                     color: Color.fromRGBO(
            //                                         217, 217, 217, 100),
            //                                     width: 1.0,
            //                                   ),
            //                                 ),
            //                               ),
            //                               height: 50,
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                 children: [
            //                                   SizedBox(
            //                                     child: Text(
            //                                       'Semua',
            //                                       textAlign: TextAlign.center,
            //                                       style: GoogleFonts.poppins(
            //                                         textStyle: const TextStyle(
            //                                           fontSize: 12,
            //                                           fontWeight:
            //                                               FontWeight.w500,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               )),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               },
            //             );
            //           },
            //           child: Row(
            //             children: [
            //               Text(
            //                 "Terbaru",
            //                 style: GoogleFonts.poppins(
            //                   textStyle: const TextStyle(
            //                       fontSize: 12,
            //                       fontWeight: FontWeight.w500,
            //                       color: Colors.grey),
            //                 ),
            //               ),
            //               const SizedBox(
            //                 width: 10,
            //               ),
            //               const Icon(
            //                 Icons.keyboard_arrow_down_rounded,
            //                 color: Colors.grey,
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            postingProfile.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Belum memiliki postingan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: postingProfile.length,
                    itemBuilder: (context, index) {
                      final item = postingProfile[index];
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
                                child: Container(
                                  // color: Colors.red,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                          title: item.title == null
                                              ? ""
                                              : item.title,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              item.doc == null
                                  ? SizedBox(
                                      height: 5,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        height: 75,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(item.doc == null
                                                ? ""
                                                : item.doc),
                                            Icon(
                                              Icons.download,
                                              size: 32,
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
                                              backgroundColor:
                                                  Colors.transparent,
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
                                                "Authorization":
                                                    'Bearer ${token}',
                                                "login-type": "0",
                                              },
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              // width: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                // child: Image.network("${item.image}",
                                //     fit: BoxFit.cover),
                              ),
                              // Text(item.vote_status.toString()),
                              Container(
                                width: double.infinity,
                                // color: Colors.red,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.thumb_up,
                                                      color:
                                                          item.vote_status == 1
                                                              ? Colors.blue
                                                              : Colors.grey,
                                                    ),
                                                    onTap: () {
                                                      // print(item.id);
                                                      setState(() {
                                                        if (item.vote_status ==
                                                            1) {
                                                          selectedVote = 0;

                                                          // print(selectedVote);
                                                          updateVote(
                                                              item.id,
                                                              selectedVote,
                                                              item);
                                                          vote(item.id);
                                                          // _pagingController
                                                          // .refresh();
                                                        } else {
                                                          selectedVote = 1;
                                                          // print(selectedVote);
                                                          updateVote(
                                                              item.id,
                                                              selectedVote,
                                                              item);
                                                          vote(item.id);
                                                          // _pagingController
                                                          //     .refresh();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(item.upvote == 0
                                                      ? ''
                                                      : item.upvote.toString()),
                                                  Container(
                                                    height: 20,
                                                    child:
                                                        const VerticalDivider(
                                                      color: Colors.black,
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.thumb_down,
                                                      color:
                                                          item.vote_status == 2
                                                              ? Colors.blue
                                                              : Colors.grey,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        if (item.vote_status ==
                                                            2) {
                                                          selectedVote = 0;
                                                          updateVote(
                                                              item.id,
                                                              selectedVote,
                                                              item);
                                                          // _pagingController
                                                          // .refresh();
                                                        } else {
                                                          selectedVote = 2;
                                                          updateVote(
                                                              item.id,
                                                              selectedVote,
                                                              item);
                                                          // _pagingController
                                                          // .refresh();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(item.downvote == 0
                                                      ? ''
                                                      : item.downvote
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     // print(item.id);
                                            //     // commentVisible[item.id] =
                                            //     //     !(commentVisible[
                                            //     //             item.id] ??
                                            //     //         true);
                                            //     // print('lohe:' +
                                            //     //     commentVisible
                                            //     //         .toString());
                                            //   },
                                            //   child: Container(
                                            //     padding:
                                            //         const EdgeInsets.all(10),
                                            //     child: const Row(
                                            //       children: [
                                            //         Icon(Icons.chat_bubble),
                                            //         // SizedBox(
                                            //         //   width: 5,
                                            //         // ),
                                            //         // Text("345"),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            //-share
                                            // GestureDetector(
                                            //   onTap: () async {
                                            //     const urlPreview =
                                            //         'https://docs.google.com/spreadsheets/d/1FsG3d2vkTGiFbNP3LkjdAmBh66CcL40B3s-pupd1GQU/edit#gid=2068281591';

                                            //     await Share.share(
                                            //         'Check out this great video\n\n$urlPreview');
                                            //   },
                                            //   child: Container(
                                            //     // padding: const EdgeInsets.all(5),
                                            //     child: const Row(
                                            //       children: [
                                            //         Icon(Icons.share),
                                            //         // SizedBox(
                                            //         //   width: 5,
                                            //         // ),
                                            //         // Text("120"),
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
                                      idUserLogin != widget.id_user
                                          ? Container()
                                          : GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          // width: double.infinity,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                            .red[
                                                                        900]),
                                                              ),
                                                              const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Pilih',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return EditPertanyaan(
                                                                    initialIndex:
                                                                        0,
                                                                    id: item.id,
                                                                    title: item
                                                                        .title,
                                                                    description:
                                                                        item.description,
                                                                    image: item
                                                                        .image,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                    width: 0.5,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                  "Edit",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .green[
                                                                        900],
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            DeletePosting.delete(
                                                                    token,
                                                                    item.id
                                                                        .toString())
                                                                .then((value) {
                                                              if (value
                                                                      .statusCode ==
                                                                  200) {
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg: jsonDecode(
                                                                          value
                                                                              .body)[
                                                                      "msg"],
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      1,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0,
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                                getPostingProfile();
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                    width: 0.5,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                  "Hapus",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        900],
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child:
                                                  const Icon(Icons.more_horiz),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
          ],
        ),
      );
    }

    Widget jawaban() {
      return Container(
        child: Column(
          children: [
            // Container(
            //   height: 50,
            //   decoration: const BoxDecoration(
            //     // color: Colors.red,
            //     border: Border(
            //       bottom: BorderSide(
            //         color: Color.fromRGBO(217, 217, 217, 100),
            //         width: 1.0,
            //       ),
            //     ),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, right: 15),
            //     child: Row(
            //       children: [
            //         Text(
            //           "Jawaban",
            //           style: GoogleFonts.poppins(
            //             textStyle: const TextStyle(
            //                 fontSize: 12, fontWeight: FontWeight.w500),
            //           ),
            //         ),
            //         const Spacer(),
            //         GestureDetector(
            //           onTap: () {
            //             showModalBottomSheet(
            //               context: context,
            //               builder: (BuildContext context) {
            //                 return Container(
            //                   decoration: const BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.only(
            //                       topLeft: Radius.circular(15.0),
            //                       topRight: Radius.circular(15.0),
            //                     ),
            //                   ),
            //                   height: 150.0,
            //                   child: Center(
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                             decoration: const BoxDecoration(
            //                               border: Border(
            //                                 bottom: BorderSide(
            //                                   color: Color.fromRGBO(
            //                                       217, 217, 217, 100),
            //                                   width: 1.0,
            //                                 ),
            //                               ),
            //                             ),
            //                             height: 50,
            //                             child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.center,
            //                               children: [
            //                                 SizedBox(
            //                                   child: Text(
            //                                     'Diurutkan berdasarkan',
            //                                     textAlign: TextAlign.center,
            //                                     style: GoogleFonts.poppins(
            //                                       textStyle: const TextStyle(
            //                                           fontSize: 12,
            //                                           fontWeight:
            //                                               FontWeight.w500,
            //                                           color: Colors.grey),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             )),
            //                         ElevatedButton(
            //                           style: ElevatedButton.styleFrom(
            //                             alignment: Alignment.centerLeft,
            //                             backgroundColor: Colors.transparent,
            //                             elevation: 0,
            //                           ),
            //                           onPressed: () {},
            //                           child: Container(
            //                               decoration: const BoxDecoration(
            //                                 border: Border(
            //                                   bottom: BorderSide(
            //                                     color: Color.fromRGBO(
            //                                         217, 217, 217, 100),
            //                                     width: 1.0,
            //                                   ),
            //                                 ),
            //                               ),
            //                               height: 50,
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                 children: [
            //                                   SizedBox(
            //                                     child: Text(
            //                                       'Terbaru',
            //                                       textAlign: TextAlign.center,
            //                                       style: GoogleFonts.poppins(
            //                                         textStyle: const TextStyle(
            //                                           fontSize: 12,
            //                                           fontWeight:
            //                                               FontWeight.w500,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               )),
            //                         ),
            //                         ElevatedButton(
            //                           style: ElevatedButton.styleFrom(
            //                             alignment: Alignment.centerLeft,
            //                             backgroundColor: Colors.transparent,
            //                             elevation: 0,
            //                           ),
            //                           onPressed: () {},
            //                           child: Container(
            //                               decoration: const BoxDecoration(
            //                                 border: Border(
            //                                   bottom: BorderSide(
            //                                     color: Color.fromRGBO(
            //                                         217, 217, 217, 100),
            //                                     width: 1.0,
            //                                   ),
            //                                 ),
            //                               ),
            //                               height: 50,
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                 children: [
            //                                   SizedBox(
            //                                     child: Text(
            //                                       'Semua',
            //                                       textAlign: TextAlign.center,
            //                                       style: GoogleFonts.poppins(
            //                                         textStyle: const TextStyle(
            //                                           fontSize: 12,
            //                                           fontWeight:
            //                                               FontWeight.w500,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ],
            //                               )),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               },
            //             );
            //           },
            //           child: Row(
            //             children: [
            //               Text(
            //                 "Terbaru",
            //                 style: GoogleFonts.poppins(
            //                   textStyle: const TextStyle(
            //                       fontSize: 12,
            //                       fontWeight: FontWeight.w500,
            //                       color: Colors.grey),
            //                 ),
            //               ),
            //               const SizedBox(
            //                 width: 10,
            //               ),
            //               const Icon(
            //                 Icons.keyboard_arrow_down_rounded,
            //                 color: Colors.grey,
            //               )
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            postingAnswer.isEmpty
                ? Text("Data Tidak Ditemukan")
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: postingAnswer.length,
                    itemBuilder: (context, index) {
                      final item = postingAnswer[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5, top: 5),
                        child: Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPosting(
                                          id: item.id,
                                          title: item.title == null
                                              ? ""
                                              : item.title,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              item.doc == null
                                  ? SizedBox(
                                      height: 5,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        height: 75,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(item.doc == null
                                                ? ""
                                                : item.doc),
                                            Icon(
                                              Icons.download,
                                              size: 32,
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
                                              backgroundColor:
                                                  Colors.transparent,
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
                                                "Authorization":
                                                    'Bearer ${token}',
                                                "login-type": "0",
                                              },
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              // width: 100,
                                            ),
                                          ),
                                        ),
                                      ),
                                // child: Image.network("${item.image}",
                                //     fit: BoxFit.cover),
                              ),
                              // Text(item.vote_status.toString()),
                              Container(
                                width: double.infinity,
                                // color: Colors.red,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            // Container(
                                            //   padding:
                                            //       const EdgeInsets
                                            //           .all(10),
                                            //   decoration:
                                            //       BoxDecoration(
                                            //     color: Colors
                                            //         .grey[300],
                                            //     borderRadius:
                                            //         const BorderRadius
                                            //             .all(
                                            //       Radius.circular(
                                            //           50),
                                            //     ),
                                            //   ),
                                            //   child: Row(
                                            //     children: [
                                            //       InkWell(
                                            //         child: Icon(
                                            //           Icons
                                            //               .thumb_up,
                                            //           color: item.vote_status ==
                                            //                   1
                                            //               ? Colors
                                            //                   .blue
                                            //               : Colors
                                            //                   .grey,
                                            //         ),
                                            //         onTap: () {
                                            //           // print(item.id);
                                            //           setState(
                                            //               () {
                                            //             if (item.vote_status ==
                                            //                 1) {
                                            //               selectedVote =
                                            //                   0;

                                            //               // print(selectedVote);
                                            //               updateVoteAnswer(
                                            //                   item.id,
                                            //                   selectedVote,
                                            //                   item);
                                            //               vote(item
                                            //                   .id);
                                            //               // _pagingController
                                            //               // .refresh();
                                            //             } else {
                                            //               selectedVote =
                                            //                   1;
                                            //               // print(selectedVote);
                                            //               updateVoteAnswer(
                                            //                   item.id,
                                            //                   selectedVote,
                                            //                   item);
                                            //               vote(item
                                            //                   .id);
                                            //               // _pagingController
                                            //               //     .refresh();
                                            //             }
                                            //           });
                                            //         },
                                            //       ),
                                            //       const SizedBox(
                                            //         width: 5,
                                            //       ),
                                            //       Text(item.upvote ==
                                            //               0
                                            //           ? ''
                                            //           : item
                                            //               .upvote
                                            //               .toString()),
                                            //       Container(
                                            //         height: 20,
                                            //         child:
                                            //             const VerticalDivider(
                                            //           color: Colors
                                            //               .black,
                                            //           thickness:
                                            //               1,
                                            //         ),
                                            //       ),
                                            //       InkWell(
                                            //         child: Icon(
                                            //           Icons
                                            //               .thumb_down,
                                            //           color: item.vote_status ==
                                            //                   2
                                            //               ? Colors
                                            //                   .blue
                                            //               : Colors
                                            //                   .grey,
                                            //         ),
                                            //         onTap: () {
                                            //           setState(
                                            //               () {
                                            //             if (item.vote_status ==
                                            //                 2) {
                                            //               selectedVote =
                                            //                   0;
                                            //               updateVoteAnswer(
                                            //                   item.id,
                                            //                   selectedVote,
                                            //                   item);
                                            //               // _pagingController
                                            //               // .refresh();
                                            //             } else {
                                            //               selectedVote =
                                            //                   2;
                                            //               updateVoteAnswer(
                                            //                   item.id,
                                            //                   selectedVote,
                                            //                   item);
                                            //               // _pagingController
                                            //               // .refresh();
                                            //             }
                                            //           });
                                            //         },
                                            //       ),
                                            //       const SizedBox(
                                            //         width: 5,
                                            //       ),
                                            //       Text(item.downvote ==
                                            //               0
                                            //           ? ''
                                            //           : item
                                            //               .downvote
                                            //               .toString()),
                                            //     ],
                                            //   ),
                                            // ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     // print(item.id);
                                            //     // commentVisible[item.id] =
                                            //     //     !(commentVisible[
                                            //     //             item.id] ??
                                            //     //         true);
                                            //     // print('lohe:' +
                                            //     //     commentVisible
                                            //     //         .toString());
                                            //   },
                                            //   child: Container(
                                            //     padding:
                                            //         const EdgeInsets
                                            //             .all(10),
                                            //     child: const Row(
                                            //       children: [
                                            //         Icon(Icons
                                            //             .chat_bubble),
                                            //         // SizedBox(
                                            //         //   width: 5,
                                            //         // ),
                                            //         // Text("345"),
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
                                            //     // padding: const EdgeInsets.all(5),
                                            //     child: const Row(
                                            //       children: [
                                            //         Icon(Icons
                                            //             .share),
                                            //         // SizedBox(
                                            //         //   width: 5,
                                            //         // ),
                                            //         // Text("120"),
                                            //       ],
                                            //     ),
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        DeletePosting.delete(
                                                                token, item.id)
                                                            .then((value) {
                                                          if (value
                                                                  .statusCode ==
                                                              200) {
                                                            Fluttertoast
                                                                .showToast(
                                                              msg: jsonDecode(
                                                                      value
                                                                          .body)[
                                                                  "msg"],
                                                              backgroundColor:
                                                                  Colors.green,
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        // width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Center(
                                                          child: Text(
                                                            "Hapus",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
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
                            ],
                          ),
                        ),
                      );
                    },
                  )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          'Akun',
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )),
        ),
        // toolbarHeight: 70,
        backgroundColor: const Color.fromRGBO(217, 217, 217, 100),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 100),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        // PhotoZoomIconButton(
                        //   imageUrl:
                        //       'https://i.pinimg.com/originals/cf/03/2f/cf032f1176f42bbeb000c53fdace7f40.jpg',
                        // ),
                        // const SizedBox(
                        //   width: 15,
                        // ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullname == null ? '' : user.fullname,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14.0, color: Colors.blue),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: followingList.isNotEmpty
                                          ? '${followerList.length} Pengikut'
                                          : 'Belum Ada Pengikut',
                                      style: GoogleFonts.poppins(
                                        textStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserFollower(
                                                      id_user: widget.id_user),
                                            ),
                                          );
                                        },
                                    ),
                                    TextSpan(
                                      text: '  ·  ',
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                    TextSpan(
                                      text: followingList.isNotEmpty
                                          ? 'Mengikuti ${followingList.length}'
                                          : 'Belum Ada Pengikut',
                                      style: GoogleFonts.poppins(
                                        textStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserFollower(
                                                      id_user: widget.id_user,
                                                    )),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, right: 15),
                  //   child: Visibility(
                  //     visible: user[0].description != null &&
                  //         user[0].description.isNotEmpty,
                  //     child: Column(
                  //       children: [Text(description)],
                  //     ),
                  //     replacement: SizedBox(
                  //         height:
                  //             0), // Widget ini akan digunakan jika description kosong
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Row(
                      children: [
                        idUserLogin == widget.id_user
                            ? ProfileButton(
                                follow: true,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                        name: user.fullname == null
                                            ? ''
                                            : user.fullname,
                                      ),
                                    ),
                                  );
                                },
                                buttonText: 'Edit Profil',
                              )
                            : user.follow_me == 0
                                ? user.follow_status == 1
                                    ? ProfileButton(
                                        follow: true,
                                        onPressed: () {
                                          Following.follow(
                                            token,
                                            user.id.toString(),
                                            // following_id.toString(),
                                            "3",
                                          );
                                          // .then((value) {
                                          //   if (value != null) {
                                          //     setState(() {
                                          //       user.follow_status = 3;
                                          //     });
                                          //   }
                                          // });
                                          user.follow_status = 3;
                                          setState(() {});
                                        },
                                        buttonText: 'Following',
                                      )
                                    : ProfileButton(
                                        follow: false,
                                        onPressed: () {
                                          Following.follow(
                                            token,
                                            user.id.toString(),
                                            // following_id.toString(),
                                            "1",
                                          );
                                          // .then((value) {
                                          //   if (value != null) {
                                          //     setState(() {
                                          //       user.follow_status = 1;
                                          //     });
                                          //   }
                                          // });
                                          user.follow_status = 1;
                                          setState(() {});
                                        },
                                        buttonText: 'Follow',
                                      )
                                : user.follow_status == 1
                                    ? ProfileButton(
                                        follow: true,
                                        onPressed: () {
                                          Following.follow(
                                            token,
                                            user.id.toString(),
                                            // following_id.toString(),
                                            "3",
                                          );
                                          // .then((value) {
                                          //   if (value != null) {
                                          //     setState(() {
                                          //       user.follow_status = 3;
                                          //     });
                                          //   }
                                          // });
                                          user.follow_status = 3;
                                          setState(() {});
                                        },
                                        buttonText: 'Following',
                                      )
                                    : ProfileButton(
                                        follow: false,
                                        onPressed: () {
                                          Following.follow(
                                            token,
                                            user.id.toString(),
                                            // following_id.toString(),
                                            "1",
                                          );
                                          // .then((value) {
                                          //   if (value != null) {
                                          //     setState(() {
                                          //       user.follow_status = 1;
                                          //     });
                                          //   }
                                          // });
                                          user.follow_status = 1;
                                          setState(() {});
                                        },
                                        buttonText: 'Follow back',
                                      ),
                        // Expanded(
                        //     flex: 1,
                        //     child: IconButton(
                        //         onPressed: () {
                        //           showDialog(
                        //             context: context,
                        //             barrierDismissible:
                        //                 true, // This makes the dialog dismissible with a tap on the barrier
                        //             builder: (BuildContext context) {
                        //               return GestureDetector(
                        //                 onTap: () {
                        //                   Navigator.of(context).pop();
                        //                 },
                        //                 child: Dialog(
                        //                   shape: RoundedRectangleBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(10),
                        //                   ),
                        //                   elevation: 0,
                        //                   backgroundColor: Colors.transparent,
                        //                   child: Center(
                        //                     child: Container(
                        //                       width: double.infinity,
                        //                       decoration: BoxDecoration(
                        //                         color: Colors.white,
                        //                         borderRadius:
                        //                             BorderRadius.circular(16),
                        //                       ),
                        //                       child: Column(
                        //                         mainAxisSize: MainAxisSize.min,
                        //                         crossAxisAlignment:
                        //                             CrossAxisAlignment.start,
                        //                         children: [
                        //                           const Padding(
                        //                             padding: EdgeInsets.only(
                        //                                 left: 15,
                        //                                 right: 15,
                        //                                 top: 15),
                        //                             child: Text(
                        //                                 'Bagikan dengan',
                        //                                 style: TextStyle(
                        //                                     fontSize: 20,
                        //                                     fontWeight:
                        //                                         FontWeight
                        //                                             .bold)),
                        //                           ),
                        //                           const SizedBox(
                        //                             height: 10,
                        //                           ),
                        //                           ElevatedButton(
                        //                             style: ElevatedButton
                        //                                 .styleFrom(
                        //                               alignment:
                        //                                   Alignment.centerLeft,
                        //                               backgroundColor:
                        //                                   Colors.transparent,
                        //                               elevation: 0,
                        //                             ),
                        //                             onPressed: () {
                        //                               Navigator.push(
                        //                                   context,
                        //                                   MaterialPageRoute(
                        //                                       builder: (context) =>
                        //                                           const ScreenRuang()));
                        //                             },
                        //                             child: Container(
                        //                                 decoration:
                        //                                     const BoxDecoration(
                        //                                   border: Border(
                        //                                     bottom: BorderSide(
                        //                                       color: Color
                        //                                           .fromRGBO(
                        //                                               217,
                        //                                               217,
                        //                                               217,
                        //                                               100),
                        //                                       width: 1.0,
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 height: 50,
                        //                                 child: Row(
                        //                                   mainAxisAlignment:
                        //                                       MainAxisAlignment
                        //                                           .start,
                        //                                   children: [
                        //                                     const Icon(Icons
                        //                                         .directions),
                        //                                     const SizedBox(
                        //                                       width: 10,
                        //                                     ),
                        //                                     SizedBox(
                        //                                       child: Text(
                        //                                         'Pesan Langsung',
                        //                                         textAlign:
                        //                                             TextAlign
                        //                                                 .center,
                        //                                         style:
                        //                                             GoogleFonts
                        //                                                 .poppins(
                        //                                           textStyle:
                        //                                               const TextStyle(
                        //                                             fontSize:
                        //                                                 12,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w500,
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 )),
                        //                           ),
                        //                           ElevatedButton(
                        //                             style: ElevatedButton
                        //                                 .styleFrom(
                        //                               alignment:
                        //                                   Alignment.centerLeft,
                        //                               backgroundColor:
                        //                                   Colors.transparent,
                        //                               elevation: 0,
                        //                             ),
                        //                             onPressed: () {},
                        //                             child: Container(
                        //                                 decoration:
                        //                                     const BoxDecoration(
                        //                                   border: Border(
                        //                                     bottom: BorderSide(
                        //                                       color: Color
                        //                                           .fromRGBO(
                        //                                               217,
                        //                                               217,
                        //                                               217,
                        //                                               100),
                        //                                       width: 1.0,
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 height: 50,
                        //                                 child: Row(
                        //                                   mainAxisAlignment:
                        //                                       MainAxisAlignment
                        //                                           .start,
                        //                                   children: [
                        //                                     const Icon(
                        //                                       Icons.link,
                        //                                       size: 24,
                        //                                     ),
                        //                                     const SizedBox(
                        //                                       width: 10,
                        //                                     ),
                        //                                     SizedBox(
                        //                                       child: Text(
                        //                                         'Salin Tautan',
                        //                                         textAlign:
                        //                                             TextAlign
                        //                                                 .center,
                        //                                         style:
                        //                                             GoogleFonts
                        //                                                 .poppins(
                        //                                           textStyle:
                        //                                               const TextStyle(
                        //                                             fontSize:
                        //                                                 12,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w500,
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 )),
                        //                           ),
                        //                           ElevatedButton(
                        //                             style: ElevatedButton
                        //                                 .styleFrom(
                        //                               alignment:
                        //                                   Alignment.centerLeft,
                        //                               backgroundColor:
                        //                                   Colors.transparent,
                        //                               elevation: 0,
                        //                             ),
                        //                             onPressed: () {},
                        //                             child: Container(
                        //                                 decoration:
                        //                                     const BoxDecoration(
                        //                                   border: Border(
                        //                                     bottom: BorderSide(
                        //                                       color: Color
                        //                                           .fromRGBO(
                        //                                               217,
                        //                                               217,
                        //                                               217,
                        //                                               100),
                        //                                       width: 1.0,
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 height: 50,
                        //                                 child: Row(
                        //                                   mainAxisAlignment:
                        //                                       MainAxisAlignment
                        //                                           .start,
                        //                                   children: [
                        //                                     const Icon(
                        //                                       Icons
                        //                                           .animation_outlined,
                        //                                       size: 24,
                        //                                     ),
                        //                                     const SizedBox(
                        //                                       width: 10,
                        //                                     ),
                        //                                     SizedBox(
                        //                                       child: Text(
                        //                                         'Twitter',
                        //                                         textAlign:
                        //                                             TextAlign
                        //                                                 .center,
                        //                                         style:
                        //                                             GoogleFonts
                        //                                                 .poppins(
                        //                                           textStyle:
                        //                                               const TextStyle(
                        //                                             fontSize:
                        //                                                 12,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w500,
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 )),
                        //                           ),
                        //                           ElevatedButton(
                        //                             style: ElevatedButton
                        //                                 .styleFrom(
                        //                               alignment:
                        //                                   Alignment.centerLeft,
                        //                               backgroundColor:
                        //                                   Colors.transparent,
                        //                               elevation: 0,
                        //                             ),
                        //                             onPressed: () {},
                        //                             child: Container(
                        //                                 decoration:
                        //                                     const BoxDecoration(
                        //                                   border: Border(
                        //                                     bottom: BorderSide(
                        //                                       color: Color
                        //                                           .fromRGBO(
                        //                                               217,
                        //                                               217,
                        //                                               217,
                        //                                               100),
                        //                                       width: 1.0,
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 height: 50,
                        //                                 child: Row(
                        //                                   mainAxisAlignment:
                        //                                       MainAxisAlignment
                        //                                           .start,
                        //                                   children: [
                        //                                     const Icon(
                        //                                       Icons
                        //                                           .wechat_sharp,
                        //                                       size: 24,
                        //                                     ),
                        //                                     const SizedBox(
                        //                                       width: 10,
                        //                                     ),
                        //                                     SizedBox(
                        //                                       child: Text(
                        //                                         'WhatsApp',
                        //                                         textAlign:
                        //                                             TextAlign
                        //                                                 .center,
                        //                                         style:
                        //                                             GoogleFonts
                        //                                                 .poppins(
                        //                                           textStyle:
                        //                                               const TextStyle(
                        //                                             fontSize:
                        //                                                 12,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w500,
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 )),
                        //                           ),
                        //                           ElevatedButton(
                        //                             style: ElevatedButton
                        //                                 .styleFrom(
                        //                               alignment:
                        //                                   Alignment.centerLeft,
                        //                               backgroundColor:
                        //                                   Colors.transparent,
                        //                               elevation: 0,
                        //                             ),
                        //                             onPressed: () {},
                        //                             child: Container(
                        //                                 decoration:
                        //                                     const BoxDecoration(
                        //                                   border: Border(
                        //                                     bottom: BorderSide(
                        //                                       color: Color
                        //                                           .fromRGBO(
                        //                                               217,
                        //                                               217,
                        //                                               217,
                        //                                               100),
                        //                                       width: 1.0,
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 height: 50,
                        //                                 child: Row(
                        //                                   mainAxisAlignment:
                        //                                       MainAxisAlignment
                        //                                           .start,
                        //                                   children: [
                        //                                     const Icon(
                        //                                       Icons
                        //                                           .mail_outline,
                        //                                       size: 24,
                        //                                     ),
                        //                                     const SizedBox(
                        //                                       width: 10,
                        //                                     ),
                        //                                     SizedBox(
                        //                                       child: Text(
                        //                                         'Gmail',
                        //                                         textAlign:
                        //                                             TextAlign
                        //                                                 .center,
                        //                                         style:
                        //                                             GoogleFonts
                        //                                                 .poppins(
                        //                                           textStyle:
                        //                                               const TextStyle(
                        //                                             fontSize:
                        //                                                 12,
                        //                                             fontWeight:
                        //                                                 FontWeight
                        //                                                     .w500,
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ],
                        //                                 )),
                        //                           ),
                        //                           Row(
                        //                             mainAxisAlignment:
                        //                                 MainAxisAlignment.end,
                        //                             children: [
                        //                               TextButton(
                        //                                 onPressed: () {
                        //                                   Navigator.of(context)
                        //                                       .pop();
                        //                                 },
                        //                                 child:
                        //                                     const Text('Batal'),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //             },
                        //           );
                        //         },
                        //         icon: const Icon(
                        //           Icons.share,
                        //           color: Colors.grey,
                        //         )))
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: const Color.fromRGBO(217, 217, 217, 100),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text(
                            'Kredensial & Sorotan',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                          ),
                        ],
                      )),
                  Container(
                    height: 2,
                    color: const Color.fromRGBO(217, 217, 217, 100),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        idUserLogin == widget.id_user
                            ? Row(
                                children: [
                                  const Icon(Icons.cases_outlined),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Edit kredensial pekerjaan',
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Kredensial()));
                                                },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : Container(),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 15),
                        //   child: Row(
                        //     children: [
                        //       const Icon(Icons.school_outlined),
                        //       const SizedBox(
                        //         width: 15,
                        //       ),
                        //       Expanded(
                        //           child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             user.company == null ? '' : user.company,
                        //             style: GoogleFonts.poppins(
                        //                 textStyle: const TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w400,
                        //             )),
                        //           ),
                        //         ],
                        //       ))
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 15),
                        //   child: Row(
                        //     children: [
                        //       const Icon(Icons.location_on_outlined),
                        //       const SizedBox(
                        //         width: 15,
                        //       ),
                        //       Expanded(
                        //           child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             user.address_house == null
                        //                 ? ''
                        //                 : user.address_house,
                        //             style: GoogleFonts.poppins(
                        //                 textStyle: const TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w400,
                        //             )),
                        //           ),
                        //         ],
                        //       ))
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 15),
                        //   child: Row(
                        //     children: [
                        //       const Icon(Icons.calendar_month_outlined),
                        //       const SizedBox(
                        //         width: 15,
                        //       ),
                        //       Expanded(
                        //           child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             'Bergabung November 2022',
                        //             style: GoogleFonts.poppins(
                        //                 textStyle: const TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w400,
                        //             )),
                        //           ),
                        //         ],
                        //       ))
                        //     ],
                        //   ),
                        // ),

                        credentials.isEmpty
                            ? Text('-')
                            : ListView.builder(
                                itemCount: credentials.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      getIcon(credentials[index].type),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                credentials[index].description,
                                                style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                            ),
                                            // Align(
                                            //   alignment: Alignment.centerLeft,
                                            //   child: Column(
                                            //     children: [
                                            //       Text(
                                            //         "Utama",
                                            //         style: GoogleFonts.poppins(
                                            //             textStyle: const TextStyle(
                                            //                 fontSize: 14,
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
                                            //                 color: Colors.grey)),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ]),
              ),
              Container(
                // width: MediaQuery.of(context).size.width,
                // padding: const EdgeInsets.symmetric(horizontal: 15),
                // decoration: const BoxDecoration(
                //   border: Border(
                //     bottom: BorderSide(
                //       color: Color.fromRGBO(217, 217, 217, 100),
                //       width: 1.0,
                //     ),
                //   ),
                // ),
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  controller: _tabController,
                  isScrollable: true,
                  onTap: (index) {
                    _tabController!.animateTo(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: idUserLogin == widget.id_user
                      ? _tabTitles.map((title) => Tab(text: title)).toList()
                      : _tabTitle.map((title) => Tab(text: title)).toList(),
                ),
              ),
              Expanded(
                child: idUserLogin == widget.id_user
                    ? TabBarView(
                        controller: _tabController,
                        children: [
                          //Profil
                          profil(),
                          //Jawaban
                          jawaban(),
                          // : Container(),
                          //Question
                          // Container(
                          //   child: Container(
                          //     height: 1000.0,
                          //     child: Column(
                          //       children: [
                          //         Container(
                          //           height: 50,
                          //           decoration: const BoxDecoration(
                          //             border: Border(
                          //               bottom: BorderSide(
                          //                 color: Color.fromRGBO(217, 217, 217, 100),
                          //                 width: 1.0,
                          //               ),
                          //             ),
                          //           ),
                          //           child: Padding(
                          //             padding:
                          //                 const EdgeInsets.only(left: 15, right: 15),
                          //             child: Row(
                          //               children: [
                          //                 Text(
                          //                   "Pertanyaan",
                          //                   style: GoogleFonts.poppins(
                          //                     textStyle: const TextStyle(
                          //                         fontSize: 12,
                          //                         fontWeight: FontWeight.w500),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          //Profil
                          profil(),
                          //Jawaban
                          // jawaban(),
                          // : Container(),
                          //Question
                          // Container(
                          //   child: Container(
                          //     height: 1000.0,
                          //     child: Column(
                          //       children: [
                          //         Container(
                          //           height: 50,
                          //           decoration: const BoxDecoration(
                          //             border: Border(
                          //               bottom: BorderSide(
                          //                 color: Color.fromRGBO(217, 217, 217, 100),
                          //                 width: 1.0,
                          //               ),
                          //             ),
                          //           ),
                          //           child: Padding(
                          //             padding:
                          //                 const EdgeInsets.only(left: 15, right: 15),
                          //             child: Row(
                          //               children: [
                          //                 Text(
                          //                   "Pertanyaan",
                          //                   style: GoogleFonts.poppins(
                          //                     textStyle: const TextStyle(
                          //                         fontSize: 12,
                          //                         fontWeight: FontWeight.w500),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//follow akun user in content
// class Follow extends StatelessWidget {
//   final bool isFollowing;
//   final VoidCallback onPressed;
//   final String idLogin;
//   final String idUser;

//   Follow(
//       {required this.isFollowing,
//       required this.onPressed,
//       required this.idLogin,
//       required this.idUser});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: onPressed,
//       child: Text(
//         idUser == idLogin
//             ? ''
//             : isFollowing
//                 ? 'mengikuti'
//                 : 'ikuti',
//         style: TextStyle(color: isFollowing ? Colors.grey : Colors.blue),
//       ),
//     );
//   }
// }

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

class ProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool follow;

  const ProfileButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    required this.follow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: follow ? Colors.transparent : Colors.blue,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 7),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Color.fromRGBO(217, 217, 217, 100),
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: follow ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
