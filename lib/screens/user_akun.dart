import 'dart:convert';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgDetailPosting.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/add_tahutentang.dart';
import 'package:powershare/screens/edit_profile.dart';
import 'package:powershare/screens/screen_ruang.dart';
import 'package:powershare/screens/user_follower.dart';
import 'package:share_plus/share_plus.dart';

import '../components/follow_button.dart';
import '../components/photozoom.dart';
import '../model/database.dart';

class UserAkun extends StatefulWidget {
  @override
  _UserAkun createState() => _UserAkun();
}

class _UserAkun extends State<UserAkun> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Followers followers = Followers();

  final List<String> _tabTitles = [
    'Profil',
    'Jawaban',
    'Pertanyaan',
    'Kiriman',
    'Pengikut',
    'Mengikuti',
    'Tahu Tentang',
    'Histori',
    'Aktivitas',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    fetchFollowers();
    fetchFollowings();
    user();
    getPostingProfile();
  }

  Followers getFollowers = Followers();
  String userId = '';
  String followingId = '';
  String status = '';
  String namefollow = '';
  String nickfollow = '';
  String companyfollowers = '';
  String jobfollowers = '';

  List<Followers> followerList = [];

  fetchFollowers() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    Followers.followers(data[0].token).then((value) {
      setState(() {
        followerList.add(value);
        getFollowers = value;
        userId = getFollowers.id_user!;
        followingId = getFollowers.following_id!;
        status = getFollowers.follow_status!;
        namefollow = getFollowers.fullname!;
        nickfollow = getFollowers.nickname!;
        companyfollowers = getFollowers.company!;
        jobfollowers = getFollowers.job_position!;
        print(userId);
        print(followingId);
        print(status);
        print(namefollow);
        print(nickfollow);
      });
    });
  }

  ShowFollowings getFollowings = ShowFollowings();
  String useridfollowing = '';
  String followingIduser = '';
  String statusfollowing = '';
  String namefollowing = '';
  String nickfollowing = '';
  String companyfollowing = '';
  String jobfollowing = '';

  List<ShowFollowings> followingList = [];

  fetchFollowings() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    ShowFollowings.showfollowings(data[0].token).then((value) {
      setState(() {
        followingList.add(value);
        getFollowings = value;
        useridfollowing = getFollowings.id_user!;
        followingIduser = getFollowings.following_id!;
        statusfollowing = getFollowings.follow_status!;
        namefollowing = getFollowings.fullname!;
        nickfollowing = getFollowings.nickname!;
        companyfollowing = getFollowings.company!;
        jobfollowing = getFollowings.job_position!;
        print(useridfollowing);
        print(followingIduser);
      });
    });
  }

  // void fetchFollowers() async {
  //   final _db = DBhelper();
  //   var data = await _db.getToken();
  //   String token = data[0].token;
  //   String id = ""; // Isi dengan ID yang sesuai
  //   String idUser = ""; // Isi dengan ID user yang sesuai
  //   String followingId = ""; // Isi dengan ID pengikut yang sesuai
  //   String followStatus = ""; // Isi dengan status follow yang sesuai

  //   try {
  //     Followers result = await Followers.getFollower(
  //       token,
  //       id,
  //       idUser,
  //       followingId,
  //       followStatus,
  //     );

  //     setState(() {
  //       followers = result;
  //     });
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  GetUser getUser = GetUser();
  String fullname = '';
  String address = '';
  String job = '';
  String company = '';
  String start_year = '';
  int id_user = 0;
  String token = '';

  user() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    GetUser.getUser(data[0].token).then((value) {
      setState(() {
        getUser = value;
        fullname = getUser.fullname!;
        address = getUser.address_house!;
        job = getUser.job_position!;
        company = getUser.company!;
        start_year = getUser.start_year!;
        id_user = data[0].id;
        token = data[0].token;
        print("nihhhhhhhh : ${getUser.description}");
        // print(company);
      });
    });
    // _db.getToken().then((value) {
    //   print('nih : $value');
    // });
  }

  List<ShowPostingProfile> posting = [];
  ShowPostingProfile showPostingProfile = ShowPostingProfile();
  getPostingProfile() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    posting = await showPostingProfile.getPostingProfile(data[0].token);
    setState(() {});
    print(posting.length);
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
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
                        PhotoZoomIconButton(
                          imageUrl:
                              'https://i.pinimg.com/originals/cf/03/2f/cf032f1176f42bbeb000c53fdace7f40.jpg',
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullname,
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
                                                  const UserFollower(),
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
                                                    const UserFollower()),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfile(name: fullname),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
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
                                  const Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Edit Profil',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        true, // This makes the dialog dismissible with a tap on the barrier
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          child: Center(
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        right: 15,
                                                        top: 15),
                                                    child: Text(
                                                        'Bagikan dengan',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ScreenRuang()));
                                                    },
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(Icons
                                                                .directions),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                'Pesan Langsung',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                              Icons.link,
                                                              size: 24,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                'Salin Tautan',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .animation_outlined,
                                                              size: 24,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                'Twitter',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .wechat_sharp,
                                                              size: 24,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                'WhatsApp',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .mail_outline,
                                                              size: 24,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              child: Text(
                                                                'Gmail',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('Batal'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                )))
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
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
                                          text:
                                              'Tambahkan kredensial pekerjaan',
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w400),
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.school_outlined),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    company,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on_outlined),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    address,
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bergabung November 2022',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 100),
                      width: 1.0,
                    ),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  onTap: (index) {
                    _tabController.animateTo(
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
                  tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    //Profil
                    Container(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              // color: Colors.red,
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Profil",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                topRight: Radius.circular(15.0),
                                              ),
                                            ),
                                            height: 150.0,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    217,
                                                                    217,
                                                                    217,
                                                                    100),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      height: 50,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                              'Diurutkan berdasarkan',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                'Terbaru',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                'Semua',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Terbaru",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: posting.length,
                            itemBuilder: (context, index) {
                              final content = posting[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), //color of shadow
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 7, // blur radius
                                        offset: Offset(
                                            0, 2), // changes position of shadow
                                        //first paramerter of offset is left-right
                                        //second parameter is top to down
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  padding:
                                                      const EdgeInsets.all(5),
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
                                                        Text(content.nickname),
                                                        // Follow(
                                                        //     idLogin: id_user
                                                        //         .toString(),
                                                        //     idUser: content.id_user
                                                        //         .toString(),
                                                        //     isFollowing:
                                                        //         followStatus[content
                                                        //                 .id_user] ??
                                                        //             false,
                                                        //     onPressed: () {
                                                        //       toggleFollow(
                                                        //           content.id_user);
                                                        //       Following.follow(
                                                        //           token,
                                                        //           content.id_user
                                                        //               .toString(),
                                                        //           following_id
                                                        //               .toString());
                                                        //     }),
                                                      ],
                                                    ),
                                                    subtitle: Text(
                                                      content.company,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                // const Expanded(
                                                //   // height: MediaQuery.of(context).size.height / 25,
                                                //   // height:43 * fem,
                                                //   // color: Colors.blue,
                                                //   flex: 1,
                                                //   child: Column(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.end,
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
                                                builder: (context) =>
                                                    DetailPosting(
                                                  id: content.id,
                                                  title: content.title == null
                                                      ? ""
                                                      : content.title,
                                                  nickname: content.nickname,
                                                  company: content.company,
                                                  description:
                                                      content.description ==
                                                              null
                                                          ? ''
                                                          : content.description,
                                                  image: content.image == null
                                                      ? ""
                                                      : content.image,
                                                ),
                                              ));
                                          print(content.id);
                                          print(content.id_user);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(
                                            15 * fem,
                                            10 * fem,
                                            15 * fem,
                                            15 * fem,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                content.title == null
                                                    ? ""
                                                    : content.title,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(50),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            child: Icon(
                                                              Icons.thumb_up,
                                                              color: selectedIndex ==
                                                                          index &&
                                                                      selectedVote ==
                                                                          1
                                                                  ? Colors.blue
                                                                  : Colors.grey,
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                if (selectedVote ==
                                                                    1) {
                                                                  selectedVote =
                                                                      0;
                                                                  updateVote(
                                                                      content
                                                                          .id,
                                                                      selectedVote);
                                                                } else {
                                                                  selectedVote =
                                                                      1;
                                                                  print(content
                                                                      .id
                                                                      .runtimeType);
                                                                  updateVote(
                                                                      content
                                                                          .id,
                                                                      selectedVote);
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          const Text("12,5rb"),
                                                          Container(
                                                            height: 20,
                                                            child:
                                                                const VerticalDivider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 1,
                                                            ),
                                                          ),
                                                          InkWell(
                                                            child: Icon(
                                                              Icons.thumb_down,
                                                              color: selectedIndex ==
                                                                          index &&
                                                                      selectedVote ==
                                                                          2
                                                                  ? Colors.blue
                                                                  : Colors.grey,
                                                            ),
                                                            onTap: () {
                                                              setState(() {
                                                                if (selectedVote ==
                                                                    2) {
                                                                  selectedVote =
                                                                      0;
                                                                  updateVote(
                                                                      content
                                                                          .id,
                                                                      selectedVote);
                                                                } else {
                                                                  selectedVote =
                                                                      2;
                                                                  updateVote(
                                                                      content
                                                                          .id,
                                                                      selectedVote);
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        print(content.id);
                                                        commentVisible[
                                                                content.id] =
                                                            !(commentVisible[
                                                                    content
                                                                        .id] ??
                                                                true);
                                                        print('lohe:' +
                                                            commentVisible
                                                                .toString());
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: const Row(
                                                          children: [
                                                            Icon(Icons
                                                                .chat_bubble),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text("345"),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        const urlPreview =
                                                            'https://docs.google.com/spreadsheets/d/1FsG3d2vkTGiFbNP3LkjdAmBh66CcL40B3s-pupd1GQU/edit#gid=2068281591';

                                                        await Share.share(
                                                            'Check out this great video\n\n$urlPreview');
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
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
                                                    ),
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
                                                              width:
                                                                  MediaQuery.of(
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
                                                                        Icons
                                                                            .close,
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
                                                                        style:
                                                                            TextStyle(
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
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            0.5,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                      "Bagikan melalui.."),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            0.5,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                      "Tidak tertarik dengan ini"),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            0.5,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                        "Simpan")),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            0.5,
                                                                        color: Colors
                                                                            .grey),
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
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            0.5,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                child: const Center(
                                                                    child: Text(
                                                                        "Log")),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  border:
                                                                      Border(
                                                                    top: BorderSide(
                                                                        width:
                                                                            0.5,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                      "Laporkan",
                                                                      style:
                                                                          TextStyle(
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
                                                child: const Icon(
                                                    Icons.more_horiz),
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
                    //Jawaban
                    Container(
                      height: 1000.0,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Jawaban",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                topRight: Radius.circular(15.0),
                                              ),
                                            ),
                                            height: 150.0,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    217,
                                                                    217,
                                                                    217,
                                                                    100),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      height: 50,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                              'Diurutkan berdasarkan',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                'Terbaru',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                'Semua',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Terbaru",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Question
                    Container(
                      child: Container(
                        height: 1000.0,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(217, 217, 217, 100),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      "Pertanyaan",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Post
                    Container(
                      child: Container(
                        height: 1000.0,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(217, 217, 217, 100),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      "Kiriman",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Followers
                    Container(
                      height: 1000.0,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Pengikut",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   decoration: const BoxDecoration(
                          //       border: Border(
                          //           bottom: BorderSide(
                          //     width: 1,
                          //     color: Color.fromRGBO(217, 217, 217, 100),
                          //   ))),
                          //   child: Column(
                          //     children: [
                          //       ElevatedButton(
                          //         style: ElevatedButton.styleFrom(
                          //           backgroundColor: Colors.transparent,
                          //           elevation: 0,
                          //         ),
                          //         onPressed: () {},
                          //         child: Row(
                          //           children: [
                          //             Container(
                          //               margin: const EdgeInsets.only(
                          //                   top: 15, bottom: 15),
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(5),
                          //                 color: Colors.grey,
                          //               ),
                          //               width: 35,
                          //               height: 35,
                          //             ),
                          //             const SizedBox(
                          //               width: 10,
                          //             ),
                          //             Expanded(
                          //               child: Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     top: 10, bottom: 10),
                          //                 child: Column(
                          //                   children: [
                          //                     RichText(
                          //                       text: TextSpan(
                          //                         style: GoogleFonts.poppins(
                          //                           textStyle: const TextStyle(
                          //                               fontSize: 12.0,
                          //                               color: Colors.black),
                          //                         ),
                          //                         children: <TextSpan>[
                          //                           TextSpan(
                          //                             text: '$namefollow, ',
                          //                             style:
                          //                                 GoogleFonts.poppins(
                          //                               textStyle:
                          //                                   const TextStyle(
                          //                                       fontWeight:
                          //                                           FontWeight
                          //                                               .w600),
                          //                             ),
                          //                             recognizer:
                          //                                 TapGestureRecognizer()
                          //                                   ..onTap = () {},
                          //                           ),
                          //                           TextSpan(
                          //                             text: '$jobfollowers di ',
                          //                           ),
                          //                           TextSpan(
                          //                             text: companyfollowers,
                          //                             recognizer:
                          //                                 TapGestureRecognizer()
                          //                                   ..onTap = () {},
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       textAlign: TextAlign.start,
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //             FollowButton()
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: followerList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(217, 217, 217, 100),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey,
                                            ),
                                            width: 35,
                                            height: 35,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Column(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: '$namefollow, ',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '$jobfollowers di ',
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              companyfollowers,
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          FollowButton(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    //Following
                    Container(
                      height: 1000.0,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Mengikuti",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                topRight: Radius.circular(15.0),
                                              ),
                                            ),
                                            height: 200.0,
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    217,
                                                                    217,
                                                                    217,
                                                                    100),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                      ),
                                                      height: 50,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                              'Mengikuti',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                'Ruang',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                'Topik',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      elevation: 0,
                                                    ),
                                                    onPressed: () {},
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      217,
                                                                      217,
                                                                      217,
                                                                      100),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        height: 50,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              child: Text(
                                                                'Pertanyaan',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Ruang",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: followingList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // Dapatkan data yang sesuai dari followingList
                              ShowFollowings followings = followingList[index];

                              return Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color.fromRGBO(217, 217, 217, 100),
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 15, bottom: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey,
                                            ),
                                            width: 35,
                                            height: 35,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Column(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              '${followings.fullname}, ',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '${followings.job_position} di ',
                                                        ),
                                                        TextSpan(
                                                          text: followings
                                                              .company,
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {},
                                                        ),
                                                      ],
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          FollowButton(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    //Know About
                    Container(
                      height: 1000.0,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Tahu tentang",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TahuTentang()));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                        size: 20,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(217, 217, 217, 100),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'Universitas 17 Agustus 1945 Surabaya',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(217, 217, 217, 100),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'Teknik Informatika',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    //History
                    Container(
                      height: 1000.0,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Histori",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 14.0, color: Colors.blue),
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Jawaban ',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _tabController.animateTo(1);
                                          },
                                      ),
                                      TextSpan(
                                        text: 'ditambahkan oleh ',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Andri Dwi',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserAkun()),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'Apakah chat Telegram bisa dilihat orang lain? ',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.blue),
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {},
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            210, 210, 210, 100),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "Di Telegram, ada fitur secret chat biasanya digunakan untuk bertukar pesan dengan sistem client-server/server-client encrypted. Dengan kata lain, pesan yang dikirimkan hanya dapat dilihat oleh pengirim dan penerima. \n\nSecret chat adalah fitur yang dikembangkan oleh Telegram sebagai jenis percakapan satu lawan satu dan bukan untuk percakapan grup. Di dalam ruang obrolan rahasia ini, Anda tidak bisa meneruskan pesan atau melakukan tangkapan layar. \n\nFitur ini memang dirancang agar penggunanya bisa berkomunikasi dengan perlindungan privasi yang lebih ketat.",
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Activity
                    Container(
                      height: 1000.0,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 100),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Aktivitas",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
