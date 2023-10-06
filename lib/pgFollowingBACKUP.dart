import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:powershare/Answer/pgMessage.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:share_plus/share_plus.dart';

class FollowingBACKUP extends StatefulWidget {
  const FollowingBACKUP({super.key});

  @override
  State<FollowingBACKUP> createState() => _FollowingBACKUPState();
}

class _FollowingBACKUPState extends State<FollowingBACKUP> {
  // final List<String,dynamic> a =[
  //   'like' : 2,
  // ];
  // int like = 2;
  final List data = List.generate(
      2,
      (select) => {
            'id': select,
            'upVote': false,
            'downVote': false,
            'comment': false,
            'share': false,
            'like': 2,
          });
  // bool comment = false;
  bool isExpanded = false;
  String title =
      "Satu kata yang muncul di pikiranku ketika melihat foto ini, PEDIH! Bagaimana dengan kalian?Halo para Quorawan, ini tulisan pertamaku so m";
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
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
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TambahPertanyaan(initialIndex: 0),
                              ),
                            );
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const TambahPertanyaan(initialIndex: 0),
                          ));
                        },
                        child: Container(
                          child: const Row(
                            children: [
                              // ignore: prefer_const_constructors
                              Icon(Icons.question_mark_rounded),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Tanya",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const BottomNavBar(currentIndex: 2),
                          ));
                        },
                        child: Container(
                          child: const Row(
                            children: [
                              Icon(Icons.question_answer),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Jawab",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const TambahPertanyaan(initialIndex: 1),
                          ));
                        },
                        child: Container(
                          child: const Row(
                            children: [
                              Icon(Icons.edit),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text("Kiriman"),
                              ),
                            ],
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
              itemCount: data.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Container(
                    color: Colors.white,
                    // width: double.infinity,
                    // padding: EdgeInsets.only(bottom: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      title: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Ngomongin IT",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(
                                                  1.0), //I used some padding without fixed width and height
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            const Text("Mengikuti"),
                                          ],
                                        ),
                                      ),
                                      subtitle: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Dijawab oleh Reza",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(
                                                  1.0), //I used some padding without fixed width and height
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            const Text("Sel"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(
                                        Icons.close,
                                        size: 18,
                                      ),

                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Message(),
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              15 * fem,
                              0,
                              15 * fem,
                              15 * fem,
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Manakah yang akan anda dahulukan ketika upgrade sebuah laptop RAM atau HDD atau SSD?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ExpandableText(
                                  'Kalo saya mending RAM deh. Kalo RAM diupgrade, laptop masih bisa dipake walaupun dgn HDD biasa. Tapi kalo HDD diupgrade, nnt akan aaaaaaaaa',
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
                          // color: Colors.red,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  data[index]['upVote'] =
                                                      !data[index]['upVote'];
                                                  if (data[index]['upVote'] ==
                                                      true) {
                                                    data[index]['like']++;
                                                  } else {
                                                    data[index]['like']--;
                                                  }
                                                });
                                              },
                                              child: Icon(
                                                Icons.thumb_up_outlined,
                                                color: data[index]['upVote']
                                                    ? Colors.blue
                                                    : Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                data[index]['like'].toString()),
                                            Container(
                                              height: 20,
                                              child: const VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                            ),
                                            const Icon(Icons.thumb_down_outlined),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            data[index]['comment'] =
                                                !data[index]['comment'];
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child:
                                              const Icon(Icons.chat_bubble_outline),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          const urlPreview = 'www.flutter.dev';

                                          await Share.share(
                                              'Check out this great video\n\n$urlPreview');
                                        },
                                        child: Container(
                                          child: const Icon(Icons.share),
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
                                                        Navigator.pop(context);
                                                      },
                                                      child: Icon(Icons.close,
                                                          color:
                                                              Colors.red[900]),
                                                    ),
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          'Pertanyaan',
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
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.2,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                        "Tambahkan komentar"),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.2,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text("Bagikan"),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.7,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                      child:
                                                          Text("Jawab nanti")),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                      child: Text(
                                                          "Beritahu saya tentang editan")),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
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
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                      child: Text(
                                                          "Lihat rincian pertanyaan")),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: const BoxDecoration(
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
                        const SizedBox(height: 5),
                        //komentar
                        Visibility(
                          visible: data[index]['comment'],
                          child: Container(
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Text("Tambahkan komentar ..."),
                                  ),
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
      ),
    );
  }

  void showDataAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(
          //       20.0,
          //     ),
          //   ),
          // ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title: Container(
            // color: Colors.blue,
            child: const Text(
              "Bagikan Dengan",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          content: SingleChildScrollView(
            // padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/ic_twitter.png"),
                      const SizedBox(width: 10),
                      const Text("Direct Messsage"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.content_copy),
                      SizedBox(width: 10),
                      Text("DSalin tautan"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/ic_twitter.png"),
                      const SizedBox(width: 10),
                      const Text("Tweet"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/ic_whatsapp.png"),
                      const SizedBox(width: 10),
                      const Text("WhatsApp"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.mail),
                      SizedBox(width: 10),
                      Text("Gmail"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Batal",
                            style: TextStyle(
                              color: Colors.green,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
