import 'package:flutter/material.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/audiens.dart';
import 'package:powershare/screens/audiens_post.dart';
import 'package:powershare/screens/ubah_sandi-2.dart';
import 'package:google_fonts/google_fonts.dart';

class TambahPertanyaan extends StatefulWidget {
  final int initialIndex;
  const TambahPertanyaan({super.key, required this.initialIndex});

  @override
  _TambahPertanyaanState createState() => _TambahPertanyaanState();
}

class _TambahPertanyaanState extends State<TambahPertanyaan> {
  final List<Widget> _tabs = [
    const Tab(text: 'Tambahkan Pertanyaan'),
    const Tab(text: 'Buat kiriman Informasi'),
  ];

  bool isChecked = true;
  int? tabIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabIndex = widget.initialIndex;
    setState(() {
      if(widget.initialIndex==0){
        isChecked = false;
      }else{
        isChecked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabIndex!,
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          titleSpacing: 0,
          // leadingWidth: 70,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(
          //     Icons.keyboard_arrow_left_rounded,
          //     color: Colors.grey,
          //   ),
          // ),
          // title: const Text(' '),
          centerTitle: false,
          title: Visibility(
            visible: isChecked,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AudiensRuang()));
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.blur_circular_rounded,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Semua Orang',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          bottom: TabBar(
            onTap: (index) {
              setState(() {
                tabIndex = index;
                // isChecked = index == 0;
                if (index == 0) {
                  isChecked = false;
                } else if (index == 1) {
                  isChecked = true;
                }
              });
            },
            splashBorderRadius: BorderRadius.circular(5),
            labelColor: Colors.black, // Color of the active tab label
            unselectedLabelColor:
                Colors.black54, // Color of the inactive tab label
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3, // Width of the bottom border
                  color:
                      Colors.blue, // Color of the bottom border for active tab
                ),
              ),
            ),

            tabs: _tabs,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
                child: Text("Simpan"),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 1,
                        color: Color.fromRGBO(217, 217, 217, 100),
                      ))),
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
                                  "Kiat untuk mendapatkan jawaban yang baik dengan cepat",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  " · Pastikan pertanyaan Anda belum pernah diajukan sebelumnya",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  " · Pastikan pertanyaan Anda singkat padat, dan lugas",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  " · Perikas kembali tata bahasa dan ejaan yang ada",
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 0, bottom: 0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_circle_rounded,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_right_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Audiens()));
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.groups_rounded,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Publik',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 0, bottom: 0),
                        child: Column(
                          children: [
                            TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText:
                                    'Awali pertanyaan Anda dengan “Apa”, “Bagaimana”, “Mengapa”, dll.',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(217, 217, 217, 100),
                        ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Andri Dwi',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                            SizedBox(height: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Kredensial()));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.grey[400],
                                    size: 40,
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.all(5),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius:
                                  //         BorderRadius.all(Radius.circular(25)),
                                  //     color: Colors.grey[200],
                                  //   ),
                                  //   child: Icon(
                                  //     Icons.person,
                                  //     size: 24,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    // width: MediaQuery.of(context).size.width * 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        color: Colors.grey[200],
                                      ),
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Belajar di Universital 17 Agustus 1945 Surabaya',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              TextField(
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'Katakan sesuatu ...',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
