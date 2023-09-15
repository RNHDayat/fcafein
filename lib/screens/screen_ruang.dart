import 'package:flutter/material.dart';
import 'package:powershare/Answer/pgUserSpace.dart';
import 'package:powershare/add_ilmu.dart';
import 'package:powershare/components/listItem.dart';
import 'package:powershare/components/searchdelegate.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgDetailIlmu.dart';
import 'package:powershare/screens/setting_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenRuang extends StatefulWidget {
  const ScreenRuang({super.key});

  @override
  State<ScreenRuang> createState() => _ScreenRuangState();
}

class _ScreenRuangState extends State<ScreenRuang> {
  @override
  void initState() {
    super.initState();
    getFollowingIlmu();
  }

  List<ShowFollowIlmu> showFollowIlmu = [];
  ShowFollowIlmu showIlmu = ShowFollowIlmu();

  getFollowingIlmu() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    showFollowIlmu = await showIlmu.getFollow(data[0].token);
    setState(() {});
    // print(showFollowIlmu[0].name);
  }

  // ShowFollowIlmu showFollowIlmu = ShowFollowIlmu();
  // getFollowingIlmu() async {
  //   final _db = DBhelper();
  //   var data = await _db.getToken();
  //   ShowFollowIlmu.getFollow(data[0].token).then((value) {
  //     setState(() {
  //       showFollowIlmu = value;
  //       print(showFollowIlmu.name);
  //     });
  //   });
  // }

  final scrollTemukan = GlobalKey();
  Future scrollToIndex() async {
    final context = scrollTemukan.currentContext!;
    await Scrollable.ensureVisible(context,
        duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Row(
                  children: [
                    const Text(
                      "Ruang Kamu",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Spacer(),
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
                                        child: Text("Alfabetis"),
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
                                      child: const Center(
                                          child: Text("Berdasarkan peran")),
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
                                          child:
                                              Text("Baru-baru ini dikunjungi")),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        child: const Row(
                          children: [
                            Text("Baru-baru dikunjungi",
                                style: TextStyle(color: Colors.grey)),
                            Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 4, bottom: 0),
                child: Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Add_ilmu())),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      icon: const Icon(Icons.add_circle_outline),
                      label: const Text("Buat"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    OutlinedButton.icon(
                      onPressed: () => scrollToIndex(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      icon: const Icon(Icons.map),
                      label: const Text("Temukan"),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: showFollowIlmu.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 0, bottom: 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailIlmu(
                                        id: showFollowIlmu[index].id,
                                        codeIlmu:
                                            showFollowIlmu[index].codeIlmu,
                                        name: showFollowIlmu[index].name,
                                      )))
                        },
                        label: Row(
                          children: [
                            Text(
                              showFollowIlmu[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                        icon: const Icon(Icons.account_circle_outlined),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                key: scrollTemukan,
                color: const Color(0x30726D6D),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 4),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Temukan Ruang",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Ruang yang mungkin Anda suka",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 16),
                            ),
                            const Spacer(),
                            TextButton(
                                onPressed: () => {},
                                child: const Text("Lihat Semua",
                                    style: TextStyle(color: Colors.grey)))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        listItem(),
                        const SizedBox(
                          height: 30,
                        ),
                        // const Row(
                        //   children: [
                        //     Text(
                        //       "3D",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal, fontSize: 16),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // listItem(),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        // const Row(
                        //   children: [
                        //     Text(
                        //       "Grafik",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal, fontSize: 16),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // listItem(),
                      ]),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
