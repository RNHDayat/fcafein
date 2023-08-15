import 'package:flutter/material.dart';
import 'package:powershare/Answer/pgUserSpace.dart';
import 'package:powershare/components/listItem.dart';
import 'package:powershare/components/searchdelegate.dart';
import 'package:powershare/screens/setting_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenRuang extends StatefulWidget {
  const ScreenRuang({super.key});

  @override
  State<ScreenRuang> createState() => _ScreenRuangState();
}

class _ScreenRuangState extends State<ScreenRuang> {
  final scrollTemukan = GlobalKey();
  Future scrollToIndex() async {
    final context = scrollTemukan.currentContext!;
    await Scrollable.ensureVisible(context, duration: Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.push(context,
      //           MaterialPageRoute(builder: (context) => const SettingScreen()));
      //     },
      //     icon: const Icon(
      //       Icons.account_circle,
      //       color: Colors.white,
      //     ),
      //   ),
      //   toolbarHeight: 70,
      //   title: Text(
      //     "Ruang",
      //     style: GoogleFonts.poppins(
      //       textStyle: const TextStyle(
      //           fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //         onPressed: () => {
      //               showSearch(
      //                   context: context, delegate: CustomSearchDelegate())
      //             },
      //         icon: const Icon(
      //           Icons.search,
      //           color: Colors.white,
      //         ))
      //   ],
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(16),
      //       bottomRight: Radius.circular(16),
      //     ),
      //   ),
      // ),
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
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text("Alfabetis"),
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
                                      child: Center(
                                          child: Text("Berdasarkan peran")),
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
                                          child:
                                              Text("Baru-baru ini dikunjungi")),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            const Text("Baru-baru dikunjungi",
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
                      onPressed: () => {},
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserSpace(),
                      ))
                    },
                    label: Row(
                      children: [
                        Text(
                          "Ngomongin IT",
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
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                key: scrollTemukan,
                color: Color(0x30726D6D),
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
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
                        SizedBox(
                          height: 10,
                        ),
                        listItem(),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Text(
                              "3D",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        listItem(),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Grafik",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        listItem(),
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
