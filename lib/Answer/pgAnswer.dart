import 'package:flutter/material.dart';
import 'package:powershare/Answer/pgQuestion.dart';
import 'package:powershare/bottomNavBar.dart';

import '../services/customTab.dart';

class Answer extends StatefulWidget {
  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  bool ikuti = false;
  int follow = 5;
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     // title: Text('Tabs Example'),
      //     ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // SizedBox(height: 20.0),
            // Text(
            //   'Tabs Inside Body',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 22),
            // ),
            DefaultTabController(
              length: 3, // length of tabs

              initialIndex: tab,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.black,
                      indicator: const CustomTabIndicator(color: Colors.red),
                      tabs: [
                        Tab(text: 'Untuk Anda'),
                        Tab(text: 'Permintaan'),
                        Tab(text: 'Draf'),
                      ],
                    ),
                  ),
                  Container(
                    height: 400, //height of TabBarView
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.amber,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color.fromARGB(255, 182, 12, 0),
                                      ),
                                      child: Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Pertanyaan untuk anda"),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.amber,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          // flex: 5,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    Question(),
                                              ));
                                            },
                                            child: Text(
                                              "Apa arti kebahagiaan dan kesuksesan bagimu?",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            // SizedBox(
                                            //   height: 20,
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "10 Jawaban",
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
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
                                            width: 5,
                                          ),
                                          Text(
                                            "Terakhir diikuti 31 Jan",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // width: double.infinity,
                                      // color: Colors.red,
                                      // padding:
                                      //     EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            Question(),
                                                      ));
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(50),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.draw),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text("Jawab"),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        ikuti = !ikuti;
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.rss_feed,
                                                            color: ikuti
                                                                ? Colors.blue
                                                                : Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Ikuti",
                                                            style: TextStyle(
                                                              color: ikuti
                                                                  ? Colors.blue
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .all(
                                                                    1.0), //I used some padding without fixed width and height
                                                            decoration:
                                                                new BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            ikuti
                                                                ? (follow + 1)
                                                                    .toString()
                                                                : follow
                                                                    .toString(),
                                                            style: TextStyle(
                                                              color: ikuti
                                                                  ? Colors.blue
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.edit_off),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("Lewati"),
                                                      ],
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
                                                                children: <
                                                                    Widget>[
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
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        'Pertanyaan',
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
                                                                        .all(15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
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
                                                                      "Tambahkan komentar"),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
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
                                                                      "Bagikan"),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
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
                                                                        "Jawab nanti")),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
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
                                                                        "Beritahu saya tentang editan")),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
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
                                                                        "Dorong turun pertamyaan")),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
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
                                                                        "Lihat rincian pertanyaan")),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(15),
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                decoration:
                                                                    BoxDecoration(
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
                                                child: Icon(Icons.more_horiz)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // color: Colors.amber,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          // flex: 5,
                                          child: Text(
                                            "Apakah chat Telegram bisa dilihat orang lain?",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.close,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            // SizedBox(
                                            //   height: 20,
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "1 Jawaban",
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
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
                                            width: 5,
                                          ),
                                          Text(
                                            "Terakhir diikuti 8 Feb",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // width: double.infinity,
                                      // color: Colors.red,
                                      // padding:
                                      //     EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      // color: Colors.grey[400],
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(50),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.draw),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("Jawab"),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.rss_feed),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("Ikuti"),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets
                                                                  .all(
                                                              1.0), //I used some padding without fixed width and height
                                                          decoration:
                                                              new BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text("1"),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.edit_off),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text("Lewati"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.more_horiz),
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

                        //Draf
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset("assets/draft.png"),
                              ),
                              Text(
                                "Permintaan Jawaban",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Minta jawaban dari pengguna lain dengan mengklik Mintajawaban di pertanyaan. Permintaan yang Anda terima akan ditampilkan disini.",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavBar(currentIndex: 2),
                                  ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Lihat pertanyaan untuk anda",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Permintaan
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset("assets/draft.png"),
                              ),
                              Text(
                                "Tidak ada draf jawaban",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Mulailah menuliskan jawaban dengan mencari pertanyaan untuk dijawab pada bagian Pertanyaan untuk Anda.",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavBar(currentIndex: 2),
                                  ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Lihat pertanyaan untuk anda",
                                      style: TextStyle(color: Colors.white),
                                    ),
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
          ],
        ),
      ),
    );
  }
}
