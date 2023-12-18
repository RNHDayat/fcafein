import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/pgDetailPosting.dart';
// import 'package:powershare/pgDetailPosting.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:powershare/screens/user_akun.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'model/database.dart';
import 'model/dbhelper.dart';
import 'services/global.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// class Post {
//   final id;
//   final id_user;
//   final id_knowfield;
//   final title;
//   final description;
//   final image;
//   final doc;
//   final status;
//   final nickname;
//   final fullname;
//   final company;
//   final follow_status;
//   int upvote;
//   int downvote;
//   int vote_status;
//   // final repliedData;
//   // bool isFollow = false;
//   Post(
//     this.id,
//     this.id_user,
//     this.id_knowfield,
//     this.title,
//     this.description,
//     this.image,
//     this.doc,
//     this.status,
//     this.nickname,
//     this.fullname,
//     this.company,
//     this.follow_status,
//     this.upvote,
//     this.downvote,
//     this.vote_status,
//     // this.repliedData,
//   );
//   // factory Post.fromJson(Map<String, dynamic> json) {
//   //   return Post(
//   //     id:json['id'],
//   //     id_user:json['id_user'],
//   //     id_postings:json['id_postings'],
//   //     nickname:json['nickname'],
//   //     title:json['title'],
//   //     description:json['description'],
//   //     company:json['company'],
//   //     image:json['image'],
//   //     repliedData:json['repliedData'],
//   //   );
//   // }
// }
class PostHome {
  final id;
  final id_user;
  final idKnowfield;
  final title;
  final description;
  final image;
  final doc;
  final status;
  final createdAt;
  final updatedAt;
  String nickname;
  final fullname;
  final company;
  int follow_status;
  int upvote;
  int downvote;
  final point;
  int vote_status;

  PostHome({
    this.id,
    this.id_user,
    this.idKnowfield,
    this.title,
    this.description,
    this.image,
    this.doc,
    this.status,
    this.createdAt,
    this.updatedAt,
    required this.nickname,
    this.fullname,
    this.company,
    required this.follow_status,
    required this.upvote,
    required this.downvote,
    this.point,
    required this.vote_status,
  });

  factory PostHome.fromJson(Map<String, dynamic> json) {
    return PostHome(
      id: json["id"],
      id_user: json["id_user"],
      idKnowfield: json["id_knowfield"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      doc: json["doc"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      nickname: json["nickname"],
      fullname: json["fullname"],
      company: json["company"],
      follow_status: json["follow_status"],
      upvote: json["upvote"] ?? 0,
      downvote: json["downvote"] ?? 0,
      point: json["point"] ?? 0,
      vote_status: json["vote_status"] ?? 0,
    );
  }
}

class _HomeState extends State<Home> {
  bool follow = false;
  int following = 0;
  final _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  bool isExpanded = false;
  String title =
      "Satu kata yang muncul di pikiranku ketika melihat foto ini, PEDIH! Bagaimana dengan kalian?Halo para Quorawan, ini tulisan pertamaku so m";

  final _perPage = 3;
  final controller = ScrollController();
  List<PostHome> items = [];
  List<PostHome> filterItems = [];
  List<PostHome> listPostHome = [];
  int page = 1;
  bool hasMore = true;
  bool isLoading = false;
  // final _numberOfPostsPerRequest = 3;
  // final PagingController<int, Post> _pagingController =
  //     PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    user();
    // _scrollController.addListener(_scrollListener);
    // _pagingController.addPageRequestListener((page) {
    //   _fetchPage(page);
    // });
    fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
        print("heyy");
      }
    });
    rank();
  }

  TopFun topFun = TopFun();
  List<TopFun> TopFunList = [];
  rank() async {
    TopFunList = await topFun.board();
    // await saveTopUsersToPrefs(TopFunList);
    TopFunList = TopFunList.where((item) {
      return item.rank <= 3;
    }).toList();
    setState(() {});
  }

  Future<void> saveTopUsersToPrefs(List<TopFun> topFunList) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<TopFun> top3Ids = topFunList.where((item) {
      return item.rank <= 3;
    }).toList();
    print(top3Ids.map((e) => e.id_user));
    // await sharedPreferences.setStringList('top3Ids', top3Ids);
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    // _pagingController.dispose();
    super.dispose();
    controller.dispose();

    // Saat pengguna pindah halaman, set _shouldCancelDataFetching menjadi true untuk membatalkan penguraian data JSON.
    // _shouldCancelDataFetching = true;
  }

  // void _scrollListener() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     // final nextPageKey = page + 1;
  //     //       _pagingController.appendPage(postList, nextPageKey);
  //   } else {
  //     setState(() {
  //       _showBackToTopButton = false;
  //     });
  //   }
  // }

  GetUser getUser = GetUser(follow_status: 0);
  String token = '';
  user() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    setState(() {
      token = data[0].token;
    });
  }

  // bool _shouldCancelDataFetching = false;
  // http.Response? _response;
  // Future<void> _fetchPage(int page) async {
  //   try {
  //     final _db = DBhelper();
  //     var data = await _db.getToken();
  //     // print(data[0].token);
  //     final response = await http.get(
  //       // Uri.parse("http://10.0.2.2:8000/api/home?page=$pageKey&limit=$_numberOfPostsPerRequest"),
  //       Uri.parse(URL + "home?per_page=$_perPage&page=$page"),
  //       headers: {
  //         "Authorization": 'Bearer ${data[0].token}',
  //         "Accept": "*/*",
  //         "login-type": "0",
  //         // 'Charset': 'utf-8',
  //       },
  //     );
  //     // if (!_shouldCancelDataFetching) {
  //     // setState(() {
  //     //   _response = response;
  //     // });
  //     try {
  //       var responseList;
  //       if (response.body.isNotEmpty) {
  //         responseList = json.decode(response.body)["data"];
  //       }
  //       // List<MapEntry<String, dynamic>> mapEntries = [];
  //       // mapEntries = responseList.entries.toList();

  //       // List result = mapEntries
  //       //     .firstWhere((entry) => entry.key == 'data',
  //       //         orElse: () => MapEntry('data', []))
  //       //     .value;
  //       List result = responseList;

  //       List<Post> postList = result
  //           .map((data) => Post(
  //                 data['id'],
  //                 data['id_user'],
  //                 data['id_knowfield'],
  //                 data['title'],
  //                 data['description'],
  //                 data['image'],
  //                 data['doc'],
  //                 data['status'],
  //                 data['nickname'],
  //                 data['fullname'],
  //                 data['company'],
  //                 data['follow_status'],
  //                 data['upvote'],
  //                 data['downvote'],
  //                 data['vote_status'] ?? 0,
  //                 // data['repliedData'],
  //               ))
  //           .toList();
  //       print(postList.length);
  //       // print(id);
  //       if (mounted) {
  //         final isLastPage = postList.length < _perPage;
  //         if (isLastPage) {
  //           _pagingController.appendLastPage(postList);
  //         } else {
  //           // final nextPageKey = page + 1;
  //           final nextPageKey = page + postList.length;
  //           _pagingController.appendPage(postList, nextPageKey);
  //         }
  //       }
  //     } catch (e) {
  //       print(response.statusCode);
  //       print('Terjadi kesalahan saat memproses data: $e');
  //     }
  //     // }
  //   } catch (e) {
  //     // if (!_shouldCancelDataFetching) {
  //     print('Error: $e');
  //     // }
  //     _pagingController.error = e;
  //   }
  // }

  // GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     GlobalKey<RefreshIndicatorState>();

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
      print(following_id);
    });
  }

  // final Map<int, bool> comment = {};
  // final commentVisible = <int, bool>{};
  // // late int following_id;

  // void toggleComment(int userId) {
  //   setState(() {
  //     comment[userId] = !(comment[userId] ?? false);
  //     // if (followStatus[userId] == true) {
  //     //   following_id = 1;
  //     // } else {
  //     //   following_id = 3;
  //     // }
  //     print(comment);
  //   });
  // }

  int selectedVote = 0;
  int selectedIndex = 0;

  updateVote(int id_posting, int voting, PostHome post) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      selectedVote = voting;
    });

    try {
      //publish vote
      Vote.voting(data[0].token, id_posting, voting).then((val) {
        ShowVote.showVoting(int.parse(val.postingsId)).then((value) {
          setState(() {
            post.vote_status = value.vote_status;
            post.upvote = value.upvote;
            post.downvote = value.downvote;
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

  Future downloadFile(int id, String fileName) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    // Uri url = Uri.parse(URL + "cafein/downloadRegulasi/$id");
    final directory = await getExternalStorageDirectory();
    int count = 1;
    String originalFileName = fileName;

    while (await _fileExists(fileName)) {
      fileName = '(${count++}) ${originalFileName}';
    }
    final taskId = await FlutterDownloader.enqueue(
      url: URL + "posting/downloadDoc/$id",
      headers: {
        // "Connection": "Keep-Alive",
        // "Keep-Alive": "timeout=5, max=1000",
        "Authorization": 'Bearer ${data[0].token}',
        "Content-Type": "application/pdf",
        "login-type": "0",
      }, // optional: header send with url (auth token etc)
      savedDir: '/storage/emulated/0/download/',
      fileName: fileName,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  Future<bool> _fileExists(String fileName) async {
    final file = File('/storage/emulated/0/download/$fileName');
    return await file.exists();
  }

  Future<List<PostHome>> fetch() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    if (isLoading) return fetch();
    isLoading = true;
    const limit = 2;
    final response = await http.get(
      // Uri.parse("http://10.0.2.2:8000/api/home?page=$pageKey&limit=$_numberOfPostHomesPerRequest"),
      Uri.parse(URL + "home?per_page=$limit&page=$page"),
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
      setState(() {
        page++;
        isLoading = false;
        if (listPostHome.length < limit) {
          hasMore = false;
        }
        items.addAll(listPostHome);
        // items.addAll(filterItems
        //     .where((element) => element.follow_status == 0)
        //     .toList());
        for (var i = 0; i < items.length; i++) {
          print("op" + items[i].follow_status.toString());
        }
        // print("hehe" + filterItems.length.toString());
      });
      return items;
    } else {
      print(response.statusCode);
      throw Exception('Failed to update or create vote');
    }
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 1;
      items.clear();
      listPostHome.clear();
    });
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.fromLTRB(fem, fem, fem, 5 * fem),
                padding:
                    EdgeInsets.fromLTRB(15 * fem, 10 * fem, 15 * fem, 15 * fem),
                width: double.infinity,
                decoration: const BoxDecoration(
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
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            color: Colors.grey[200],
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          // width: MediaQuery.of(context).size.width * 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const TambahPertanyaan(initialIndex: 0),
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
                              child: const Text(
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
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // controller: controller,
                itemCount: items.length + 1,
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    final item = items[index];
                    var rankOne = TopFunList.indexWhere((user) =>
                        user.id_user == item.id_user && user.rank == 1);
                    var rankTwo = TopFunList.indexWhere((user) =>
                        user.id_user == item.id_user && user.rank == 2);
                    var rankThree = TopFunList.indexWhere((user) =>
                        user.id_user == item.id_user && user.rank == 3);
                    return Column(
                      children: [
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserAkun(id_user: item.id_user),
                                    ),
                                  );
                                },
                                child: Padding(
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
                                                Radius.circular(8),
                                              ),
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
                                                  rankOne != -1
                                                      ? Text(
                                                          item.nickname == null
                                                              ? ""
                                                              : item.nickname +
                                                                  "🥇")
                                                      : rankTwo != -1
                                                          ? Text(item.nickname ==
                                                                  null
                                                              ? ""
                                                              : item.nickname +
                                                                  "🥈")
                                                          : rankThree != -1
                                                              ? Text(item.nickname ==
                                                                      null
                                                                  ? ""
                                                                  : item.nickname +
                                                                      "🥉")
                                                              : Text(item.nickname ==
                                                                      null
                                                                  ? ""
                                                                  : item
                                                                      .nickname),
                                                  FollowButton(
                                                    isFollowing: followStatus[
                                                            item.id_user] ??
                                                        false,
                                                    // isFollowing:
                                                    //     item.follow_status == 1
                                                    //         ? true
                                                    //         : false,
                                                    onPressed: () {
                                                      toggleFollow(
                                                          item.id_user);
                                                      Following.follow(
                                                        token,
                                                        item.id_user.toString(),
                                                        // following_id.toString(),
                                                        "1",
                                                      );
                                                    },
                                                  ),
                                                  // TextButton(
                                                  //   onPressed: () {
                                                  //     toggleFollow(item.id_user);
                                                  //     Following.follow(
                                                  //       token,
                                                  //       item.id_user.toString(),
                                                  //       following_id.toString(),
                                                  //     );
                                                  //   },
                                                  //   child: Text(
                                                  //     item.follow_status == 1
                                                  //         ? 'mengikuti'
                                                  //         : 'ikuti',
                                                  //     style: TextStyle(
                                                  //         color:
                                                  //             item.follow_status ==
                                                  //                     1
                                                  //                 ? Colors.grey
                                                  //                 : Colors.blue),
                                                  //   ),
                                                  // )
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
                                            GestureDetector(
                                              onTap: () => downloadFile(
                                                  item.id, item.doc),
                                              child: Icon(
                                                Icons.download,
                                                size: 32,
                                              ),
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
                                // Image.network(
                                //     URL +
                                //         "posting/showImagePost/" +
                                //         item.image,
                                //     headers: {
                                //       "Authorization": 'Bearer ${token}',
                                //       "login-type": "0",
                                //     },
                                //     fit: BoxFit.cover,
                                //     height: 200,
                                //     width: MediaQuery.of(context).size.width,
                                //     // width: 100,
                                //   ),
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
                                            //-comment
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
                                            //--share
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
                                            //--share
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
                                      //--horiz
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     showModalBottomSheet(
                                      //         isScrollControlled: true,
                                      //         context: context,
                                      //         builder: (context) {
                                      //           return Column(
                                      //             mainAxisSize:
                                      //                 MainAxisSize.min,
                                      //             mainAxisAlignment:
                                      //                 MainAxisAlignment.center,
                                      //             children: <Widget>[
                                      //               Container(
                                      //                 // width: double.infinity,
                                      //                 padding:
                                      //                     const EdgeInsets.all(
                                      //                         15),
                                      //                 width:
                                      //                     MediaQuery.of(context)
                                      //                         .size
                                      //                         .width,
                                      //                 child: Stack(
                                      //                   alignment: Alignment
                                      //                       .centerLeft,
                                      //                   children: <Widget>[
                                      //                     GestureDetector(
                                      //                       onTap: () {
                                      //                         Navigator.pop(
                                      //                             context);
                                      //                       },
                                      //                       child: Icon(
                                      //                           Icons.close,
                                      //                           color: Colors
                                      //                               .red[900]),
                                      //                     ),
                                      //                     const Row(
                                      //                       mainAxisAlignment:
                                      //                           MainAxisAlignment
                                      //                               .center,
                                      //                       children: <Widget>[
                                      //                         Text(
                                      //                           'Jawab',
                                      //                           style:
                                      //                               TextStyle(
                                      //                             color: Colors
                                      //                                 .grey,
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
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .all(15),
                                      //                   width: MediaQuery.of(
                                      //                           context)
                                      //                       .size
                                      //                       .width,
                                      //                   decoration:
                                      //                       const BoxDecoration(
                                      //                     border: Border(
                                      //                       top: BorderSide(
                                      //                           width: 0.5,
                                      //                           color: Colors
                                      //                               .grey),
                                      //                     ),
                                      //                   ),
                                      //                   child: const Center(
                                      //                     child: Text(
                                      //                         "Bagikan melalui.."),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap: () {},
                                      //                 child: Container(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .all(15),
                                      //                   width: MediaQuery.of(
                                      //                           context)
                                      //                       .size
                                      //                       .width,
                                      //                   decoration:
                                      //                       const BoxDecoration(
                                      //                     border: Border(
                                      //                       top: BorderSide(
                                      //                           width: 0.5,
                                      //                           color: Colors
                                      //                               .grey),
                                      //                     ),
                                      //                   ),
                                      //                   child: const Center(
                                      //                     child: Text(
                                      //                         "Tidak tertarik dengan ini"),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap: () {},
                                      //                 child: Container(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .all(15),
                                      //                   width: MediaQuery.of(
                                      //                           context)
                                      //                       .size
                                      //                       .width,
                                      //                   decoration:
                                      //                       const BoxDecoration(
                                      //                     border: Border(
                                      //                       top: BorderSide(
                                      //                           width: 0.5,
                                      //                           color: Colors
                                      //                               .grey),
                                      //                     ),
                                      //                   ),
                                      //                   child: const Center(
                                      //                       child:
                                      //                           Text("Simpan")),
                                      //                 ),
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap: () {},
                                      //                 child: Container(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .all(15),
                                      //                   width: MediaQuery.of(
                                      //                           context)
                                      //                       .size
                                      //                       .width,
                                      //                   decoration:
                                      //                       const BoxDecoration(
                                      //                     border: Border(
                                      //                       top: BorderSide(
                                      //                           width: 0.5,
                                      //                           color: Colors
                                      //                               .grey),
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
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .all(15),
                                      //                   width: MediaQuery.of(
                                      //                           context)
                                      //                       .size
                                      //                       .width,
                                      //                   decoration:
                                      //                       const BoxDecoration(
                                      //                     border: Border(
                                      //                       top: BorderSide(
                                      //                           width: 0.5,
                                      //                           color: Colors
                                      //                               .grey),
                                      //                     ),
                                      //                   ),
                                      //                   child: const Center(
                                      //                       child: Text("Log")),
                                      //                 ),
                                      //               ),
                                      //               GestureDetector(
                                      //                 onTap: () {},
                                      //                 child: Container(
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                           .all(15),
                                      //                   width: MediaQuery.of(
                                      //                           context)
                                      //                       .size
                                      //                       .width,
                                      //                   decoration:
                                      //                       const BoxDecoration(
                                      //                     border: Border(
                                      //                       top: BorderSide(
                                      //                           width: 0.5,
                                      //                           color: Colors
                                      //                               .grey),
                                      //                     ),
                                      //                   ),
                                      //                   child: Center(
                                      //                     child: Text(
                                      //                         "Laporkan",
                                      //                         style: TextStyle(
                                      //                           color: Colors
                                      //                               .red[900],
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child:
                            hasMore ? CircularProgressIndicator() : Container(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  final isFollowing;
  final onPressed;

  FollowButton({this.isFollowing, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: IsFollowing(
          isFollowing: isFollowing,
        ));
  }
}

class IsFollowing extends StatelessWidget {
  final bool isFollowing;

  IsFollowing({required this.isFollowing});

  @override
  Widget build(BuildContext context) {
    return Text(
      isFollowing ? 'mengikuti' : 'ikuti',
      style: TextStyle(color: isFollowing ? Colors.grey : Colors.blue),
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
