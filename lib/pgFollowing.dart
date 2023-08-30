import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:powershare/Answer/pgMessage.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:share_plus/share_plus.dart';

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
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
              decoration: BoxDecoration(
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
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.grey[200],
                        ),
                        child: Icon(
                          Icons.person,
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        // width: MediaQuery.of(context).size.width * 2,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    TambahPertanyaan(initialIndex: 0),
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
                            child: Text(
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TambahPertanyaan(initialIndex: 0),
                          ));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              // ignore: prefer_const_constructors
                              Icon(Icons.question_mark_rounded),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
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
                            builder: (context) => BottomNavBar(currentIndex: 2),
                          ));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.question_answer),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
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
                                TambahPertanyaan(initialIndex: 1),
                          ));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
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
            SizedBox(
              height: 5,
            ),
            ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.grey[200],
                                    ),
                                    child: Icon(
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
                                            Text(
                                              "Ngomongin IT",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
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
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text("Mengikuti"),
                                          ],
                                        ),
                                      ),
                                      subtitle: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Dijawab oleh Reza",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(
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
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text("Sel"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
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
                              builder: (context) => Message(),
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(
                              15 * fem,
                              0,
                              15 * fem,
                              15 * fem,
                            ),
                            child: Column(
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
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.all(
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
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                                data[index]['like'].toString()),
                                            Container(
                                              height: 20,
                                              child: VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                            ),
                                            Icon(Icons.thumb_down_outlined),
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
                                          padding: EdgeInsets.all(10),
                                          child:
                                              Icon(Icons.chat_bubble_outline),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final urlPreview = 'www.flutter.dev';

                                          await Share.share(
                                              'Check out this great video\n\n$urlPreview');
                                        },
                                        child: Container(
                                          child: Icon(Icons.share),
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
                                                    Row(
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
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.2,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: Center(
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
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.2,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: Center(
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
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.7,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: Center(
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
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 1,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: Center(
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
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: Center(
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
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                          width: 0.5,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  child: Center(
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
                                                  decoration: BoxDecoration(
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
                                  child: Icon(Icons.more_horiz),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        //komentar
                        Visibility(
                          visible: data[index]['comment'],
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            color: Colors.grey[300],
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[100],
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 28,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Text("Tambahkan komentar ..."),
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
          titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
          title: Container(
            // color: Colors.blue,
            child: Text(
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
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/ic_twitter.png"),
                      SizedBox(width: 10),
                      Text("Direct Messsage"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
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
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/ic_twitter.png"),
                      SizedBox(width: 10),
                      Text("Tweet"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/icon/ic_whatsapp.png"),
                      SizedBox(width: 10),
                      Text("WhatsApp"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
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
                    child: Row(
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
