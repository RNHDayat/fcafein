import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/components/textfieldTahun2.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/add_Kpekerjaan.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/add_Kruang.dart';
import 'package:powershare/screens/setting_akun.dart';

class KredensialPendidikan extends StatefulWidget {
  const KredensialPendidikan({super.key});

  @override
  State<KredensialPendidikan> createState() => _KredensialPendidikanState();
}

class _KredensialPendidikanState extends State<KredensialPendidikan> {
  final _key = GlobalKey<FormState>();
  String token = '';
  int type = 1;
  String description = '';
  TextEditingController sekolah = TextEditingController();
  TextEditingController jurusan = TextEditingController();
  TextEditingController gelar = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  getToken() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      token = data[0].token;
    });
    print(data);
  }

  saveKredensial(String jurusan, sekolah, gelar) async {
    setState(() {
      description = 'Belajar $jurusan di $sekolah dengan gelar $gelar';
      StoreCredential.store(token, type.toString(), description);
    });
  }

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
                // TextButton(
                //   style: TextButton.styleFrom(foregroundColor: Colors.grey),
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const KredensialLokasi()));
                //   },
                //   child: const Text("Batal"),
                // ),
                // const SizedBox(
                //   width: 5,
                // ),
                TextButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      saveKredensial(jurusan.text, sekolah.text, gelar.text);
                      Fluttertoast.showToast(
                        msg: "Berhasil menambahkan kredensial",
                        backgroundColor: Colors.green,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Kredensial()));
                    }
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
                      color: const Color.fromRGBO(210, 210, 210, 100),
                      width: 1)),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 0, top: 15, bottom: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tambahkan Kredensial Pedidikan",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
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
                              "Sekolah",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: sekolah,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Sekolah tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Nama sekolah',
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
                              "Jurusan ",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: jurusan,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Jurusan tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Jurusan',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 15, right: 15, top: 0, bottom: 15),
                    //   child: Column(
                    //     children: [
                    //       Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           "Jurusan Sekunder",
                    //           style: GoogleFonts.poppins(
                    //               textStyle: const TextStyle(
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w500)),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       TextFormField(
                    //         decoration: InputDecoration(
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10.0),
                    //           ),
                    //           hintText: 'Jurusan',
                    //           contentPadding: const EdgeInsets.symmetric(
                    //               vertical: 7, horizontal: 15),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Jenis Gelar",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: gelar,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Gelar tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'M.Sn.',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 15, right: 15, top: 0, bottom: 15),
                    //   child: Column(
                    //     children: [
                    //       Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           "Tahun Kelulusan",
                    //           style: GoogleFonts.poppins(
                    //               textStyle: const TextStyle(
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w500)),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 10,
                    //       ),
                    //       YearDropdownFormField(),
                    //     ],
                    //   ),
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
