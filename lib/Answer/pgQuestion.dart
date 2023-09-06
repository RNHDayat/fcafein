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
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Pertanyaan"),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      "Apa arti kebahagiaan dan kesuksesan bagimu?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
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
                                              const Row(
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
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            child: const Center(
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
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    width: 0.5,
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
                                            padding: const EdgeInsets.all(15),
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
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    width: 0.5,
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
                                            padding: const EdgeInsets.all(15),
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
                                            padding: const EdgeInsets.all(15),
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
                                            padding: const EdgeInsets.all(15),
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
                              child: const Column(
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
              const Divider(
                color: Colors.grey,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[400],
                      ),
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Andri dwi, dapatkah anda menjawab pertanyaan ini?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Orang-orang sedang mencari jawaban lebih baik untuk pertanyaan ini.",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: const Row(
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
                padding: const EdgeInsets.all(10),
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
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text("Semua yang terkait"),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: const Center(child: Text("Jawaban")),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        child: const Row(
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
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text("Disarankan"),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child:
                                          const Center(child: Text("Dukungan naik")),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: const Center(child: Text("Baru")),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: const Row(
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey[200],
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 28,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Yanto Hendriyana",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(
                                            1.0), //I used some padding without fixed width and height
                                        decoration:  BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      const Text("Ikuti"),
                                    ],
                                  ),
                                ),
                                const IntrinsicHeight(
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
                    const SizedBox(height: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sesuatu yang tidak membebani terhadap diri kita itu suatu kebahagiaan tersendiri, segala sesuatu yang kita hasilkan yang berguna dan bermanfaat bagi semua orang itu suatu kesuksesan',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.thumb_up),
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
                                        const Icon(Icons.thumb_down),
                                      ],
                                    ),
                                  ),
                                  Container(
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
                                  Container(
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
                                                        width: 0.5,
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
                                                        width: 0.5,
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
                                                        width: 0.5,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: const Center(
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
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
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
                                                        color: Colors.red[900],
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Icon(Icons.more_horiz)),
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey[200],
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 28,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Yanto Hendriyana",
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
                                      const Text("Ikuti"),
                                    ],
                                  ),
                                ),
                                const IntrinsicHeight(
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
                    const SizedBox(height: 10),
                    Container(
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sesuatu yang tidak membebani terhadap diri kita itu suatu kebahagiaan tersendiri, segala sesuatu yang kita hasilkan yang berguna dan bermanfaat bagi semua orang itu suatu kesuksesan',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.thumb_up),
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
                                        const Icon(Icons.thumb_down),
                                      ],
                                    ),
                                  ),
                                  Container(
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
                                  Container(
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
                                                        width: 0.5,
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
                                                        width: 0.5,
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
                                                        width: 0.5,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                child: const Center(
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
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
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
                                                        color: Colors.red[900],
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Icon(Icons.more_horiz)),
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
