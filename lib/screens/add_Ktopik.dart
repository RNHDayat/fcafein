import 'package:flutter/material.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/add_Kruang.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/screens/user_akun.dart';

class KredensialTopik extends StatefulWidget {
  KredensialTopik({super.key});

  @override
  State<KredensialTopik> createState() => _KredensialTopikState();
}

class _KredensialTopikState extends State<KredensialTopik> {
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
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KredensialRuang()));
                  },
                  child: const Text("Batal"),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserAkun()));
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
                  left: 20, right: 20, top: 15, bottom: 0),
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
            Container(
                margin: const EdgeInsets.all(15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(210, 210, 210, 100), width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IntrinsicHeight(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 0, top: 15, bottom: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tambahkan Kredensial Topik",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: const Color.fromRGBO(217, 217, 217, 100),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15.0),
                      width: double.infinity,
                      color: const Color.fromRGBO(217, 217, 217, 100),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Kredensial yang baik: ",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Bersifat singkat dan spesifik",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Bersifat membantu dan tulus",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 15),
                              child: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Memiliki ejaan dan tata bahasa yang benar",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pilih Topik",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: 'Perang Dunia II',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Deskripsikan pengalaman",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLength: 60,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: ' ',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
          ],
        ),
      ),
    );
  }
}
