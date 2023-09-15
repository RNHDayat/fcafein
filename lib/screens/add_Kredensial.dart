import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/add_Kkeahlian.dart';
import 'package:powershare/screens/add_Kkehormatan.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/add_Kpekerjaan.dart';
import 'package:powershare/screens/add_Kpendidikan.dart';
import 'package:powershare/screens/add_Kruang.dart';
import 'package:powershare/screens/add_Ktopik.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:powershare/screens/edit_Kkeahlian.dart';
import 'package:powershare/screens/edit_Kkehormatan.dart';
import 'package:powershare/screens/edit_Klokasi.dart';
import 'package:powershare/screens/edit_Kpekerjaan.dart';
import 'package:powershare/screens/edit_Kpendidikan.dart';
import 'setting_akun.dart';

class Kredensial extends StatefulWidget {
  const Kredensial({super.key});

  @override
  State<Kredensial> createState() => _KredensialState();
}

class _KredensialState extends State<Kredensial> {
  @override
  void initState() {
    super.initState();
    getCredential();
    // getFollower();
  }

  List<ShowCredentials> credentials = [];
  ShowCredentials showCredentials = ShowCredentials();

  getCredential() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    credentials = await showCredentials.getCredential(data[0].token);
    setState(() {});
    print(credentials[0].description);
  }

  @override
  Widget getIcon(int type) {
    IconData iconData;
    if (type == 0) {
      iconData = Icons.construction;
    } else if (type == 1) {
      iconData = Icons.school;
    } else if (type == 2) {
      iconData = Icons.location_on_outlined;
    } else if (type == 3) {
      iconData = Icons.work;
    } else if (type == 4) {
      iconData = Icons.military_tech;
    } else {
      iconData = Icons.error;
    }
    return Icon(iconData);
  }

  editCredentials(int type, String description, int hide, int id) {
    int desc = description.length;
    if (type == 0) {
      var keahlian = description.substring(23, desc);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditKredensialKeahlian(
                hide: hide, id: id, keahlian: keahlian, type: type),
          ));
      print(keahlian);
    } else if (type == 1) {
      // Memecah kalimat menjadi potongan-potongan teks
      List<String> potonganTeks = description.split(' ');

      // Mencari indeks kata "belajar", "di", dan "gelar"
      int indexBelajar = potonganTeks.indexOf('Belajar');
      int indexDi = potonganTeks.indexOf('di');
      int indexDengan = potonganTeks.indexOf('dengan');
      int indexGelar = potonganTeks.indexOf('gelar');

      // Bagian 1: Mulai dari "Belajar" (indeks setelah "Belajar") hingga sebelum "di"
      List<String> jurusan = potonganTeks.sublist(indexBelajar + 1, indexDi);

      // Bagian 2: Mulai dari "di" (indeks setelah "di") hingga sebelum "dengan"
      List<String> sekolah = potonganTeks.sublist(indexDi + 1, indexDengan);

      // Bagian 3: Mulai dari "gelar" (indeks setelah "gelar") hingga akhir
      List<String> gelar = potonganTeks.sublist(indexGelar + 1);

      // Menggabungkan potongan-potongan teks menjadi kalimat-kalimat baru
      String kalimatjurusan = jurusan.join(' ');
      String kalimatsekolah = sekolah.join(' ');
      String kalimatgelar = gelar.join(' ');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditKredensialPendidikan(
                hide: hide,
                id: id,
                sekolah: kalimatsekolah,
                jurusan: kalimatjurusan,
                gelar: kalimatgelar,
                type: type),
          ));

      print("Bagian 1: $kalimatjurusan");
      print("Bagian 2: $kalimatsekolah");
      print("Bagian 3: $kalimatgelar");
    } else if (type == 2) {
      var lokasi = description.substring(11, desc);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditKredensialLokasi(
                hide: hide, id: id, lokasi: lokasi, type: type),
          ));
      print(lokasi);
    } else if (type == 3) {
      // Memecah kalimat menjadi potongan-potongan teks
      List<String> potonganTeks = description.split(' ');

      // Mencari indeks kata "belajar", "di", dan "gelar"
      int indexSebagai = potonganTeks.indexOf('sebagai');
      int indexDi = potonganTeks.indexOf('di');
      // Bagian 1: Mulai dari "Belajar" (indeks setelah "Belajar") hingga sebelum "di"
      List<String> pekerjaan = potonganTeks.sublist(indexSebagai + 1, indexDi);
      List<String> lokasiKerja = potonganTeks.sublist(indexDi + 1);
      // Menggabungkan potongan-potongan teks menjadi kalimat-kalimat baru
      String kalimatjurusan = pekerjaan.join(' ');
      String kalimatsekolah = lokasiKerja.join(' ');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditKredensialPekerjaan(
                hide: hide,
                id: id,
                jabatan: kalimatjurusan,
                perusahaan: kalimatsekolah,
                type: type),
          ));
      print("Bagian 1: $pekerjaan");
      print("Bagian 2: $lokasiKerja");
    } else if (type == 4) {
      var gelar = description.substring(15, desc);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditKredensialKehormatan(
                hide: hide, id: id, kehormatan: gelar, type: type),
          ));
      print(gelar);
    } else {
      print('eror');
    }
  }

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
                                            const KredensialKeahlian()));
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
                                            const KredensialPekerjaan()));
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
                                            const KredensialKehormatan()));
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
                            //                 const KredensialLokasi()));
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
                            //               'Lainnya',
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
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
                    const Icon(
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
                      color: const Color.fromRGBO(217, 217, 217, 100),
                    ),
                    ListView.builder(
                      itemCount: credentials.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
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
                                  getIcon(credentials[index].type),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            credentials[index].description,
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ),
                                        // Align(
                                        //   alignment: Alignment.centerLeft,
                                        //   child: Column(
                                        //     children: [
                                        //       Text(
                                        //         "Utama",
                                        //         style: GoogleFonts.poppins(
                                        //             textStyle: const TextStyle(
                                        //                 fontSize: 14,
                                        //                 fontWeight:
                                        //                     FontWeight.w400,
                                        //                 color: Colors.grey)),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )),
                                  InkWell(
                                      onTap: () {
                                        editCredentials(
                                          credentials[index].type,
                                          credentials[index].description,
                                          credentials[index].hide,
                                          credentials[index].id,
                                        );
                                        setState(() {});
                                      },
                                      child: const Icon(Icons.edit)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 2,
                      color: const Color.fromRGBO(217, 217, 217, 100),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 0, right: 0, top: 0, bottom: 0),
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         alignment: Alignment.centerLeft,
                    //         backgroundColor: Colors.transparent,
                    //         elevation: 0,
                    //       ),
                    //       onPressed: () {},
                    //       child: Row(
                    //         children: [
                    //           const Icon(Icons.location_on),
                    //           const SizedBox(
                    //             width: 5,
                    //           ),
                    //           Expanded(
                    //               child: Padding(
                    //             padding: const EdgeInsets.all(10.0),
                    //             child: Column(
                    //               children: [
                    //                 Align(
                    //                   alignment: Alignment.centerLeft,
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         "Tinggal di Menganti, Gresik, Jawa Timur",
                    //                         style: GoogleFonts.poppins(
                    //                             textStyle: const TextStyle(
                    //                                 fontSize: 14,
                    //                                 fontWeight:
                    //                                     FontWeight.w400)),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Align(
                    //                   alignment: Alignment.centerLeft,
                    //                   child: Column(
                    //                     children: [
                    //                       Text(
                    //                         "2001 - saat ini",
                    //                         style: GoogleFonts.poppins(
                    //                             textStyle: const TextStyle(
                    //                                 fontSize: 14,
                    //                                 fontWeight: FontWeight.w400,
                    //                                 color: Colors.grey)),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           )),
                    //           // Text(
                    //           //   'Belajar Teknik Informatika di Universitas 17 Agustus 1945 Surabaya',
                    //           //   style: GoogleFonts.poppins(
                    //           //       textStyle: TextStyle(
                    //           //           fontSize: 14,
                    //           //           fontWeight: FontWeight.w600)),
                    //           // ),

                    //           const Icon(Icons.edit),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: 2,
                    //   color: const Color.fromRGBO(217, 217, 217, 100),
                    // ),
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
