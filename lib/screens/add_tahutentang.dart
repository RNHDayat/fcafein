import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TahuTentang extends StatefulWidget {
  const TahuTentang({super.key});

  @override
  State<TahuTentang> createState() => _TahuTentangState();
}

class _TahuTentangState extends State<TahuTentang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 55,
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
                        "Topik yang Anda tahu",
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
                    "Topik merupakan cara mengetahui pertanyaan mana yang harus dikirimkannya kepada Anda. Berikan informasi selengkap dan sespesifik mungkin untuk mendapatkan pertanyaan yang bersifat paling relevan",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Tambah topik',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              'Universitas 17 Agustus 1945 Surabaya',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              'Teknik Informatika',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.grey,
                              ))
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
