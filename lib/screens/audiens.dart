import 'package:flutter/material.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:google_fonts/google_fonts.dart';

class Audiens extends StatefulWidget {
  const Audiens({super.key});

  @override
  State<Audiens> createState() => _AudiensState();
}

class _AudiensState extends State<Audiens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 5),
              child: Align(
                child: Row(children: [
                  Text(
                    'Audiens',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ]),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2, // Width of the bottom border
                    color: Color.fromRGBO(217, 217, 217,
                        100), // Color of the bottom border for active tab
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
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
                        const Icon(Icons.supervisor_account_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Publik",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      "Orang lain akan melihat identitas Anda di samping pertanyaan ini di profil Anda dan di lini masa mereka.",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2, // Width of the bottom border
                    color: Color.fromRGBO(217, 217, 217,
                        100), // Color of the bottom border for active tab
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
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
                        const Icon(Icons.shield_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dibatasi",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      "Identitas Anda akan ditampilkan, namun pertanyaan ini tidak akan ditampilkan pada lini masa pengikut Anda atau profil Anda.",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
