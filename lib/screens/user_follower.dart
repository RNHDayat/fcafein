import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/user_akun.dart';

import '../components/follow_button.dart';

class UserFollower extends StatefulWidget {
  final int id_user;

  const UserFollower({super.key, required this.id_user});

  @override
  _UserFollowerState createState() => _UserFollowerState();
}

class _UserFollowerState extends State<UserFollower>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchFollowers();
    fetchFollowings();
    fetchFollowingsLogin();
    userLogin();
    getUserLogin();
  }

  // Followers followers = Followers();

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
  String token = '';
  int idLogin = 0;
  getUserLogin() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      token = data[0].token;
      idLogin = data[0].id;
    });
  }

  bool checkFollow(int idUser) {
    return followingListLogin.any((user) => int.parse(user.id_user) == idUser);
  }

  ShowFollow getFollowingsLogin = ShowFollow();
  List<ShowFollow> followingListLogin = [];

  fetchFollowingsLogin() async {
    final _db = DBhelper();
    var data = await _db.getToken();

    followingListLogin =
        await getFollowings.showfollowings(data[0].token, data[0].id);
    print("NAHA" + followingListLogin.length.toString());
    // followingListLogin.map((e) => print(e.id_user))

    setState(() {});
  }

  ShowFollow getFollowings = ShowFollow();
  List<ShowFollow> followingList = [];

  fetchFollowings() async {
    final _db = DBhelper();
    var data = await _db.getToken();

    followingList =
        await getFollowings.showfollowings(data[0].token, widget.id_user);
    setState(() {});
  }

  List<ShowFollow> followerList = [];

  fetchFollowers() async {
    final _db = DBhelper();
    var data = await _db.getToken();

    followerList =
        await getFollowings.showfollowers(data[0].token, widget.id_user);
    setState(() {});
  }

  GetUser user = GetUser(follow_status: 0);
  userLogin() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    // print(data[0].token);
    user = await GetUser.getUser(data[0].token, widget.id_user);
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(' '),
            pinned: true,
            floating: true,
            leadingWidth: double.infinity,
            leading: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  user.fullname == null ? "" : user.fullname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              controller: _tabController,
              splashBorderRadius: BorderRadius.circular(5),
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 3, // Width of the bottom border
                    color: Colors
                        .blue, // Color of the bottom border for active tab
                  ),
                ),
              ),
              tabs: [
                SizedBox(
                  child: Tab(
                    text: 'Pengikut',
                  ),
                ),
                SizedBox(
                  child: Tab(
                    text: 'Mengikuti',
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                //Followers
                SingleChildScrollView(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: followerList.length,
                    itemBuilder: (context, index) {
                      final item = followerList[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserAkun(
                                  id_user: int.parse(item.id_user),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                width: 35,
                                height: 35,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: item.fullname,
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserAkun(
                                                      id_user: int.parse(
                                                          item.id_user),
                                                    ),
                                                  ),
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
                              int.parse(item.id_user) == idLogin
                                  ? Container()
                                  : checkFollow(int.parse(item.id_user)) == true
                                      ? FollowButton(isFollowing: false)
                                      : FollowButton(isFollowing: true),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //Following
                SingleChildScrollView(
                  child: Column(
                    children: [
                      //Border Top
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: followingList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Dapatkan data yang sesuai dari followingList
                          final followings = followingList[index];

                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserAkun(
                                          id_user:
                                              int.parse(followings.id_user),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                        width: 35,
                                        height: 35,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(followings.fullname),
                                      ),
                                      int.parse(followings.id_user) == idLogin
                                          ? Container()
                                          : checkFollow(int.parse(
                                                      followings.id_user)) ==
                                                  true
                                              ? FollowButton(isFollowing: false)
                                              : FollowButton(isFollowing: true),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
