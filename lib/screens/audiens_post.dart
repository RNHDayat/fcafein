import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_question.dart';

class AudiensRuang extends StatefulWidget {
  const AudiensRuang({super.key});

  @override
  State<AudiensRuang> createState() => _AudiensRuangState();
}

class _AudiensRuangState extends State<AudiensRuang> {
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
                    'Pilih Suatu Ruang',
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
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 15),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'pilih suatu ruang',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 15),
                      ),
                    )
                  ],
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
                        const Icon(
                          Icons.blur_circular_outlined,
                          color: Colors.blue,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Semua Orang",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
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
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ruang yang disarankan",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                )),
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
                        const Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(
                                  "Ngomongin IT",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                          ),
                        ),
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
