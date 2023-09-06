import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/edit_Nama.dart';
import 'package:powershare/screens/edit_biografi.dart';

class EditProfile extends StatefulWidget {
  final String name;
  const EditProfile({super.key, required this.name});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String name = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
  }

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
        elevation: 0,
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          )),
        ),
        toolbarHeight: 70,
        backgroundColor: const Color.fromRGBO(217, 217, 217, 100),
      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      child: Column(
                        children: <Widget>[
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
                                      'Diurutkan berdasarkan',
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
                            onPressed: () {},
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        'Telefon',
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
                            onPressed: () {},
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        'Kamera',
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
                            onPressed: () {},
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        'Singkirkan Foto',
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
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SizedBox(
                    height: 68,
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
                        SizedBox(
                          child: Text(
                            'Edit Foto',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.edit_outlined,
                          color: Colors.grey,
                        )
                      ],
                    )),
              ),
            ),
            Container(
              height: 2,
              color: const Color.fromRGBO(217, 217, 217, 100),
            ),
            SizedBox(
              height: 70,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const EditNama()));
                    },
                    child: Container(
                        height: 68,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  child: Text(
                                    'Edit Nama',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    name,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.edit_outlined,
                              color: Colors.grey,
                            )
                          ],
                        )),
                  ),
                  Container(
                    height: 2,
                    color: const Color.fromRGBO(217, 217, 217, 100),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Kredensial()));
                    },
                    child: Container(
                        height: 68,
                        child: Row(
                          children: [
                            Align(
                              child: Text(
                                'Edit kredensial profil',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.edit_outlined,
                              color: Colors.grey,
                            )
                          ],
                        )),
                  ),
                  Container(
                    height: 2,
                    color: const Color.fromRGBO(217, 217, 217, 100),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditBio()));
                    },
                    child: Container(
                        height: 68,
                        child: Row(
                          children: [
                            Align(
                              child: Text(
                                'Edit biografi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.edit_outlined,
                              color: Colors.grey,
                            )
                          ],
                        )),
                  ),
                  Container(
                    height: 2,
                    color: const Color.fromRGBO(217, 217, 217, 100),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
