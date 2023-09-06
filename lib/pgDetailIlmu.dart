import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgDetailPosting.dart';
import 'package:share_plus/share_plus.dart';

class DetailIlmu extends StatefulWidget {
  final String codeIlmu;

  const DetailIlmu({super.key, required this.codeIlmu});

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
  }

  GetUser getUser = GetUser();
  // late int id;
  String token = '';
  user() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    setState(() {
      token = data[0].token;
    });
  }

  List<DetailPageIlmu> postinganIlmu = [];
  DetailPageIlmu pageIlmu = DetailPageIlmu();

  getIlmu() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    postinganIlmu = await pageIlmu.get(context,data[0].token, widget.codeIlmu);
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
        title: Text('judul nich'),
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
              ElevatedButton(
                onPressed: () {},
                child: Text('Ikuti'),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding: EdgeInsets.only(left: 50, right: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(thickness: 2),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: postinganIlmu.length,
                itemBuilder: (context, index) {
                  final ilmu = postinganIlmu[index];
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
                        // border: Border(
                        //   top: BorderSide(
                        //     //                   <--- left side
                        //     color: Colors.black,
                        //     width: 1,
                        //   ),
                        //   bottom: BorderSide(
                        //     //                    <--- top side
                        //     color: Colors.black,
                        //     width: 1,
                        //   ),
                        // ),
                      ),
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
                                            Text(ilmu.nickname),
                                            FollowButton(
                                                isFollowing: followStatus[
                                                        ilmu.id_user] ??
                                                    false,
                                                onPressed: () {
                                                  toggleFollow(ilmu.id_user);
                                                  Following.follow(
                                                      token,
                                                      ilmu.id_user.toString(),
                                                      following_id.toString());
                                                }),
                                            // TextButton(
                                            //   onPressed: () {
                                            //     setState(() {
                                            //       ilmu.isFollow =
                                            //           !ilmu.isFollow;
                                            //       print(index);
                                            //       toggleFollow(ilmu.id);
                                            //     });
                                            //   },
                                            //   child: Text(
                                            //     ilmu.isFollow
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
                                          ilmu.company,
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPosting(
                                        id: ilmu.id,
                                        title: ilmu.title == null
                                            ? ""
                                            : ilmu.title,
                                        nickname: ilmu.nickname,
                                        company: ilmu.company,
                                        description: ilmu.description == null
                                            ? ''
                                            : ilmu.description,
                                        image: ilmu.image == null
                                            ? ""
                                            : ilmu.image),
                                  ));
                              print(ilmu.id);
                              print(ilmu.id_user);
                            },
                            child: Container(
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
                                    ilmu.title == null ? "" : ilmu.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ExpandableText(
                                    ilmu.description == null
                                        ? ""
                                        : ilmu.description,
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
                          //   child: Image.network("${ilmu.image}",
                          //       fit: BoxFit.cover),
                          // ),
                          Container(
                            width: double.infinity,
                            // color: Colors.red,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                                      selectedIndex == index &&
                                                              selectedVote == 1
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedVote == 1) {
                                                      selectedVote = 0;
                                                      updateVote(ilmu.id,
                                                          selectedVote);
                                                    } else {
                                                      selectedVote = 1;
                                                      print(
                                                          ilmu.id.runtimeType);
                                                      updateVote(ilmu.id,
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
                                                child: const VerticalDivider(
                                                  color: Colors.black,
                                                  thickness: 1,
                                                ),
                                              ),
                                              InkWell(
                                                child: Icon(
                                                  Icons.thumb_down,
                                                  color:
                                                      selectedIndex == index &&
                                                              selectedVote == 2
                                                          ? Colors.blue
                                                          : Colors.grey,
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedVote == 2) {
                                                      selectedVote = 0;
                                                      updateVote(ilmu.id,
                                                          selectedVote);
                                                    } else {
                                                      selectedVote = 2;
                                                      updateVote(ilmu.id,
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
                                            print(ilmu.id);
                                            commentVisible[ilmu.id] =
                                                !(commentVisible[ilmu.id] ??
                                                    true);
                                            print('lohe:' +
                                                commentVisible.toString());
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
                                        GestureDetector(
                                          onTap: () async {
                                            const urlPreview =
                                                'https://docs.google.com/spreadsheets/d/1FsG3d2vkTGiFbNP3LkjdAmBh66CcL40B3s-pupd1GQU/edit#gid=2068281591';

                                            await Share.share(
                                                'Check out this great video\n\n$urlPreview');
                                          },
                                          child: Container(
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

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onPressed;

  FollowButton({required this.isFollowing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        isFollowing ? 'mengikuti' : 'ikuti',
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
