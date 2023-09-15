import 'package:flutter/material.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/add_Kpekerjaan.dart';
import 'package:powershare/screens/add_Kpendidikan.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/textfieldTahun.dart';

class KredensialKehormatan extends StatefulWidget {
  const KredensialKehormatan({super.key});

  @override
  State<KredensialKehormatan> createState() => _KredensialKehormatanState();
}

class _KredensialKehormatanState extends State<KredensialKehormatan> {
  bool isChecked = false;
  // Color getColor(Set<MaterialState> states) {
  //   const Set<MaterialState> interactiveStates = <MaterialState>{
  //     MaterialState.pressed,
  //     MaterialState.hovered,
  //     MaterialState.focused,
  //   };
  //   if (states.any(interactiveStates.contains)) {
  //     return Colors.blue;
  //   }
  //   return Colors.blue;
  // }
  final _key = GlobalKey<FormState>();
  String token = '';
  int type = 4;
  String description = '';
  TextEditingController kehormatan = TextEditingController();

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

  saveKredensial(String kehormatan) async {
    setState(() {
      description = 'Memiliki gelar $kehormatan';
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
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const KredensialPekerjaan()));
                  },
                  child: const Text("Batal"),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      saveKredensial(kehormatan.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Kredensial()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const KredensialKehormatan()));
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
                              "Tambahkan Kredensial Kehormatan",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
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
                                  "Gelar Kehormatan",
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
                                controller: kehormatan,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: 'Masukkan gelar kehormatan',
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
                        //           "Tahun Mulai",
                        //           style: GoogleFonts.poppins(
                        //               textStyle: const TextStyle(
                        //                   fontSize: 14,
                        //                   fontWeight: FontWeight.w500)),
                        //         ),
                        //       ),
                        //       const SizedBox(
                        //         height: 10,
                        //       ),
                        //       const YearPickerTextField(),
                        //     ],
                        //   ),
                        // ),
                        // Visibility(
                        //   visible: !isChecked,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 15, right: 15, top: 0, bottom: 0),
                        //     child: Column(
                        //       children: [
                        //         Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Text(
                        //             "Tahun Selesai",
                        //             style: GoogleFonts.poppins(
                        //                 textStyle: const TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w500)),
                        //           ),
                        //         ),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         const YearPickerTextField(),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 0, right: 0, top: 0, bottom: 5),
                        //   child: CheckboxListTile(
                        //     controlAffinity: ListTileControlAffinity.leading,
                        //     title: const Text("Saya masih tinggal disini"),
                        //     checkColor: Colors.white,
                        //     // fillColor: MaterialStateProperty.resolveWith(getColor),
                        //     value: isChecked,
                        //     onChanged: (bool? value) {
                        //       setState(() {
                        //         isChecked = value!;
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
