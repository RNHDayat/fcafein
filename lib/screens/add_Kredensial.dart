import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/add_Kpekerjaan.dart';
import 'package:powershare/screens/add_Kpendidikan.dart';
import 'package:powershare/screens/add_Kruang.dart';
import 'package:powershare/screens/add_Ktopik.dart';
import 'package:powershare/screens/add_question.dart';
import 'setting_akun.dart';

class Kredensial extends StatefulWidget {
  const Kredensial({super.key});

  @override
  State<Kredensial> createState() => _KredensialState();
}

class _KredensialState extends State<Kredensial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 64,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.grey,
          ),
        ),
        toolbarHeight: 55,
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KredensialPekerjaan()));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    fixedSize: const Size(71, 0),
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Edit Kredensial",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Kredensial menambahkan kredibilitas ke konten Anda",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Tambah Kredensial

            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      height: 300,
                      child: Center(
                        child: ListView(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(217, 217, 217, 100),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        'Tambahkan Kredensial',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const KredensialLokasi()));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 100),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Keahlian',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const KredensialPendidikan()));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 100),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Pendidikan',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const KredensialLokasi()));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 100),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Lokasi',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            KredensialPekerjaan()));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 100),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Pekerjaan',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     alignment: Alignment.centerLeft,
                            //     backgroundColor: Colors.transparent,
                            //     elevation: 0,
                            //   ),
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const KredensialRuang()));
                            //   },
                            //   child: Container(
                            //       decoration: const BoxDecoration(
                            //         border: Border(
                            //           bottom: BorderSide(
                            //             color:
                            //                 Color.fromRGBO(217, 217, 217, 100),
                            //             width: 1.0,
                            //           ),
                            //         ),
                            //       ),
                            //       height: 50,
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           SizedBox(
                            //             child: Text(
                            //               'Ruang',
                            //               textAlign: TextAlign.center,
                            //               style: GoogleFonts.poppins(
                            //                 textStyle: const TextStyle(
                            //                   fontSize: 12,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       )),
                            // ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const KredensialLokasi()));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 100),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Kehormatan',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            KredensialTopik()));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 100),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Topik',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const KredensialLokasi()));
                              },
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(217, 217, 217, 100),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          'Lainnya',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.all(15),
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.blue,
                    ),
                    Text(
                      'Tambahkan Kredensial',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue)),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ),

            //Kredensial Anda
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 15, bottom: 5),
                      child: Align(
                        child: Row(children: [
                          Text(
                            'Kredensial Anda',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Color.fromRGBO(217, 217, 217, 100),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.school),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Belajar Teknik Informatika di Universitas 17 Agustus 1945 Surabaya",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Utama",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              const Icon(Icons.edit),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Color.fromRGBO(217, 217, 217, 100),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Tinggal di Menganti, Gresik, Jawa Timur",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        children: [
                                          Text(
                                            "2001 - saat ini",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              // Text(
                              //   'Belajar Teknik Informatika di Universitas 17 Agustus 1945 Surabaya',
                              //   style: GoogleFonts.poppins(
                              //       textStyle: TextStyle(
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w600)),
                              // ),

                              const Icon(Icons.edit),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Color.fromRGBO(217, 217, 217, 100),
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
