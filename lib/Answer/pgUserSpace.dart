import 'package:flutter/material.dart';

import '../components/radio.dart';

class UserSpace extends StatefulWidget {
  const UserSpace({super.key});

  @override
  State<UserSpace> createState() => _UserSpaceState();
}

class _UserSpaceState extends State<UserSpace> {
  final urlProfile =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80';
  final itemCount = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool about = true;
  bool post = false;
  bool question = false;
bool dorong = false;  
bool surel = false;  
  String? _groupValue;

  ValueChanged<String?> _valueChangedHandler(String? value) {
    return (value) => setState(() => _groupValue = value!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            // foregroundColor: Colors.black[600],
            shape: const CircleBorder(),
            // padding: EdgeInsets.all(24),
          ),
          child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
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
                                child:
                                    Icon(Icons.close, color: Colors.red[900]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Ruang',
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
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 0.5, color: Colors.grey),
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
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 0.5, color: Colors.grey),
                              ),
                            ),
                            child: Center(
                              child: Text("Undang"),
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
                                top: BorderSide(width: 0.5, color: Colors.grey),
                              ),
                            ),
                            child: Center(child: Text("Edit kredensial anda")),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 0.5, color: Colors.grey),
                              ),
                            ),
                            child: Center(
                                child: Text("Stop ikuti Level up Coding",
                                    style: TextStyle(
                                      color: Colors.red[900],
                                    ))),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 0.5, color: Colors.grey),
                              ),
                            ),
                            child: Center(
                                child: Text("Senyapkan Level up Coding")),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 0.5, color: Colors.grey),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Laporkan",
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              // foregroundColor: Colors.black[600],
              shape: const CircleBorder(),
              // padding: EdgeInsets.all(24),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.black,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Container(
                      color: Colors.orange,
                      // height: 120,
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
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
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            'Ruang',
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
                                                        const EdgeInsets.all(
                                                            15),
                                                    width:
                                                        MediaQuery.of(context)
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
                                                      child: Text("Undang"),
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
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            "Edit kredensial anda")),
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
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            "Stop ikuti Level up Coding",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .red[900],
                                                            ))),
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
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            "Senyapkan Level up Coding")),
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
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Laporkan",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
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
                                                      const EdgeInsets.all(10),
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
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    "Pengetahuan Notifikasi Ruang",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
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
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Notifikasi apa yang Anda terima",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      MyRadioOption<String>(
                                                        value: 'A',
                                                        groupValue: _groupValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _groupValue = value;
                                                          });
                                                          _valueChangedHandler(
                                                              value);
                                                        },
                                                        text:
                                                            'Semua kiriman informasi',
                                                      ),
                                                      SizedBox(height: 5),
                                                      MyRadioOption<String>(
                                                        value: 'B',
                                                        groupValue: _groupValue,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _groupValue = value;
                                                          });
                                                          _valueChangedHandler(
                                                              value);
                                                        },
                                                        text: 'Nonaktifkan',
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                ),
                                                Container(
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
                                                  child: Text(
                                                    "Tempat anda menerima notifikasi",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
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
                                                  child: Text(
                                                    "Tempat anda menerima notifikasi",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
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
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Ajukan diri untuk berkontribusi",
                                                      ),
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
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            width: 0.5,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      "Stop ikuti Level up Coding",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    )),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      // padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: const <Widget>[
                                          Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            'Following',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          Icon(Icons.keyboard_arrow_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const ListTile(
                            title: Text(
                              "Level up Coding",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                "Perkembangan dunia digital tidak akan pernah terjadi tanpa adanya komunitas yang baik"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text("6 Kontributor"),
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 170,
                                  width: MediaQuery.of(context).size.width - 10,
                                  child: ListView.builder(
                                    itemCount: (itemCount / 3).ceil(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: List.generate(3, (i) {
                                          final itemIndex = index * 3 + i;
                                          return itemIndex < itemCount
                                              ? _buildItem(itemIndex.toString())
                                              : const SizedBox.shrink();
                                        }),
                                      );
                                    },
                                  ))
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 10),
                            child: Text(
                              "12,1 rb 17 kiriman informasi dalam jangka waktu seminggu terakhir",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -40,
                      left: 20,
                      // right: 0,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: NetworkImage(urlProfile),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (about == false) {
                                about = true;
                                post = false;
                                question = false;
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Tentang Kami",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Visibility(
                                visible: about,
                                child: Container(
                                  height: 2,
                                  width: 90,
                                  color: Colors.amber,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (post == false) {
                                about = false;
                                post = true;
                                question = false;
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Kiriman",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Visibility(
                                visible: post,
                                child: Container(
                                  height: 2,
                                  width: 70,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (question == false) {
                                about = false;
                                post = false;
                                question = true;
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Pertanyaan",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Visibility(
                                visible: question,
                                child: Container(
                                  height: 2,
                                  width: 70,
                                  color: Colors.amber,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: about,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                              "Space edukasi dan sharing tentang teknologi yang berkembang dari masa ke masa"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            "Teknologi | Phython | IT | Programming",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 202, 202, 202),
                          child: Text(
                            "Orang",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.search),
                                      Text("Cari orang di Ngomongin IT"),
                                    ],
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.grey),
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            "Admin",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: const Icon(Icons.person),
                          ),
                          title: Expanded(
                            child: RichText(
                              maxLines: 2,
                              text: TextSpan(
                                text: 'Angga Aditya',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text:
                                        ' belajar Sistem Informasi di Istitut Teknologi Tangerang Selatan',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,
                                        // height: 1.5,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: const Icon(Icons.person),
                          ),
                          title: Expanded(
                            child: RichText(
                              maxLines: 2,
                              text: TextSpan(
                                text: 'Angga Aditya',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text:
                                        ' belajar Sistem Informasi di Istitut Teknologi Tangerang Selatan',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black,

                                        // height: 1.5,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: post,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey.shade400,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.north_east),
                              SizedBox(width: 10),
                              Text("Teratas"),
                              SizedBox(width: 10),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: question,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey.shade400,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.north_east),
                              SizedBox(width: 10),
                              Text("Baru"),
                              SizedBox(width: 10),
                              Icon(Icons.keyboard_arrow_down),
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
        ),
      ),
    );
  }

  Future refreshData() async {
    setState(() {});
  }

  Widget _buildItem(String textnya) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.person),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: RichText(
                maxLines: 2,
                text: TextSpan(
                  text: 'Angga Aditya $textnya',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: const <TextSpan>[
                    TextSpan(
                      text:
                          ' belajar Sistem Informasi di Istitut Teknologi Tangerang Selatan',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          // height: 1.5,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
