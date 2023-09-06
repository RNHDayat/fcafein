import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/components/textfieldPass.dart';
import 'package:powershare/screens/add_Kpekerjaan.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:powershare/screens/ubah_sandi-1.dart';

class UbahSandi2 extends StatefulWidget {
  const UbahSandi2({super.key});

  @override
  State<UbahSandi2> createState() => _UbahSandi2State();
}

class _UbahSandi2State extends State<UbahSandi2> {
  bool _isObscure = true;
  bool _iisObscure = true;
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
          // toolbarHeight: 55,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 12, bottom: 12),
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UbahSandi()));
                    },
                    child: const Text("Batal"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TambahPertanyaan(initialIndex: 0,)));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      // fixedSize: const Size(71, 0),
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Masukkan Password",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Untuk alasan keamanan, silahkan masukkan sandi baru Anda untuk mengubahnya.",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Kata Sandi Baru",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextFieldPass(),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Konfirmasi Sandi Baru",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextFieldPass(),
                ],
              ),
            )
          ],
        ));
  }
}
