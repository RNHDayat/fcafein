import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool jawab = false;
  bool ikuti = false;
  bool minta = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Pertanyaan"),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Apa arti kebahagiaan dan kesuksesan bagimu?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                jawab = !jawab;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.draw,
                                    color: jawab ? Colors.blue : Colors.grey,
                                  ),
                                  Text(
                                    "Jawab",
                                    style: TextStyle(
                                      color: jawab ? Colors.blue : Colors.grey,
                                    ),
                                  )
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
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.rss_feed,
                                    color: ikuti ? Colors.blue : Colors.grey,
                                  ),
                                  Text(
                                    ikuti ? "Ikuti 1" : "ikuti",
                                    style: TextStyle(
                                      color: ikuti ? Colors.blue : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                minta = !minta;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.person_add,
                                    color: minta ? Colors.blue : Colors.grey,
                                  ),
                                  Text(
                                    "Minta",
                                    style: TextStyle(
                                      color: minta ? Colors.blue : Colors.grey,
                                    ),
                                  )
                                ],
                              ),
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
                                          padding: const EdgeInsets.all(15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.close,
                                                    color: Colors.red[900]),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                            padding: const EdgeInsets.all(15),
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
                                              child: Text("Tambahkan komentar"),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
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
                                              child: Text("Bagikan"),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
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
                                                child: Text("Jawab nanti")),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
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
                                                    "Beritahu saya tentang editan")),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
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
                                            padding: const EdgeInsets.all(15),
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
                                            padding: const EdgeInsets.all(15),
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
                                                    color: Colors.red[900],
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Icon(Icons.more_horiz),
                                  Text("Lainnya")
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
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                      ),
                      child: Icon(Icons.person),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Andri dwi, dapatkah anda menjawab pertanyaan ini?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Orang-orang sedang mencari jawaban lebih baik untuk pertanyaan ini.",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.draw,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Jawab",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: Colors.grey[300],
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    // width: double.infinity,
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.close,
                                              color: Colors.red[900]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text("Semua yang terkait"),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(child: Text("Jawaban")),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Text("Jawaban (2)"),
                            Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    // width: double.infinity,
                                    padding: const EdgeInsets.all(15),
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.close,
                                              color: Colors.red[900]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text("Disarankan"),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child:
                                          Center(child: Text("Dukungan naik")),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(child: Text("Baru")),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 3,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Disarankan",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //cardd
              Container(
                // color: Colors.blue,
                // width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //user
                    Container(
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
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
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Yanto Hendriyana",
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
                                      Text("Ikuti"),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text("9 Jam"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sesuatu yang tidak membebani terhadap diri kita itu suatu kebahagiaan tersendiri, segala sesuatu yang kita hasilkan yang berguna dan bermanfaat bagi semua orang itu suatu kesuksesan',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      // color: Colors.red,
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
                                        Icon(Icons.thumb_up),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("12,5rb"),
                                        Container(
                                          height: 20,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                        ),
                                        Icon(Icons.thumb_down),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.chat_bubble),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("345"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.share),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("120"),
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
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              // width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(Icons.close,
                                                        color: Colors.red[900]),
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
                                                        width: 0.5,
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
                                                        width: 0.5,
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
                                                        width: 0.5,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text("Jawab nanti")),
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
                                                        color: Colors.red[900],
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
              Divider(color: Colors.grey[300], thickness: 3),
              Container(
                // color: Colors.blue,
                // width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
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
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Yanto Hendriyana",
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
                                      Text("Ikuti"),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text("9 Jam"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sesuatu yang tidak membebani terhadap diri kita itu suatu kebahagiaan tersendiri, segala sesuatu yang kita hasilkan yang berguna dan bermanfaat bagi semua orang itu suatu kesuksesan',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      // color: Colors.red,
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
                                        Icon(Icons.thumb_up),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("12,5rb"),
                                        Container(
                                          height: 20,
                                          child: VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1,
                                          ),
                                        ),
                                        Icon(Icons.thumb_down),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.chat_bubble),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("345"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.share),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("120"),
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
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              // width: double.infinity,
                                              padding: const EdgeInsets.all(15),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(Icons.close,
                                                        color: Colors.red[900]),
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
                                                        width: 0.5,
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
                                                        width: 0.5,
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
                                                        width: 0.5,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Text("Jawab nanti")),
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
                                                        color: Colors.red[900],
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
                    Divider(color: Colors.grey[300], thickness: 3),
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
