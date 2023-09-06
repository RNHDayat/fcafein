import 'package:flutter/material.dart';
import 'package:powershare/screens/add_Kpekerjaan.dart';
import 'package:powershare/screens/add_Kpendidikan.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/textfieldTahun.dart';

class KredensialLokasi extends StatefulWidget {
  const KredensialLokasi({super.key});

  @override
  State<KredensialLokasi> createState() => _KredensialLokasiState();
}

class _KredensialLokasiState extends State<KredensialLokasi> {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const KredensialPendidikan()));
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
                        color: const Color.fromRGBO(210, 210, 210, 100), width: 1)),
                child: IntrinsicHeight(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 0, top: 15, bottom: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tambahkan Kredensial Lokasi",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
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
                              "Lokasi (diwajibkan)",
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Masukkan alamat',
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
                              "Tahun Mulai",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const YearPickerTextField(),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !isChecked,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 0, bottom: 0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Tahun Selesai",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const YearPickerTextField(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 0, bottom: 5),
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Saya masih tinggal disini"),
                        checkColor: Colors.white,
                        // fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
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
