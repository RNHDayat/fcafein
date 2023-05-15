import 'package:flutter/material.dart';
import 'package:powershare/screens/screen_ruang.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

void main() {
  runApp(
    const MaterialApp(home: SettingScreen()), // use MaterialApp
  );
}

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double _value = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        toolbarHeight: 70,
        title: Text(
          "Setelan",
          style: GoogleFonts.poppins(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Column(
            children: [
              //Akun
              Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingAkun()));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Akun',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 2.5 * _value,
                                  fontWeight: FontWeight.w600)),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ),
              ),

              //Privasi
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 60,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         alignment: Alignment.centerLeft,
              //         backgroundColor: Colors.transparent,
              //         elevation: 0,
              //       ),
              //       onPressed: () {},
              //       child: Row(
              //         children: [
              //           Text(
              //             'Privasi',
              //             style: GoogleFonts.poppins(
              //                 textStyle: TextStyle(
              //                     fontSize: 2.5 * _value,
              //                     fontWeight: FontWeight.w600)),
              //           ),
              //           Spacer(),
              //           Icon(Icons.keyboard_arrow_right),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              // //Bahasa
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 0, right: 5, top: 0, bottom: 0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 60,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         alignment: Alignment.centerLeft,
              //         backgroundColor: Colors.transparent,
              //         elevation: 0,
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const SettingBahasa()));
              //       },
              //       child: Row(
              //         children: [
              //           Text(
              //             'Bahasa',
              //             style: GoogleFonts.poppins(
              //                 textStyle: TextStyle(
              //                     fontSize: 2.5 * _value,
              //                     fontWeight: FontWeight.w600)),
              //           ),
              //           const Spacer(),
              //           const Icon(Icons.keyboard_arrow_right),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              //Border
              Container(
                  height: 2, color: const Color.fromRGBO(217, 217, 217, 100)),

              //Tampilan
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 0, top: 15, bottom: 0),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            "Tampilan",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 2.5 * _value,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //Border
              Container(
                height: 2,
                color: Color.fromRGBO(217, 217, 217, 100),
              ),

              //Slider
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        Text(
                          "Ukuran Huruf",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 2.5 * _value,
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                      ]),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Aa",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                )),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: const SliderThemeData(),
                                  child: Container(
                                    width: 300,
                                    child: Slider(
                                      min: 1,
                                      max: 10,
                                      divisions: 4,
                                      value: _value,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Aa",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                )),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),

              //Border
              Container(
                height: 2,
                color: Color.fromRGBO(217, 217, 217, 100),
              ),

              //Dark Mode
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, top: 5, bottom: 4),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'DarkMode',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 2.5 * _value,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    MyApp.themeNotifier.value =
                                        MyApp.themeNotifier.value ==
                                                ThemeMode.light
                                            ? ThemeMode.dark
                                            : ThemeMode.light;
                                  });
                                },
                                icon: Icon(
                                    MyApp.themeNotifier.value == ThemeMode.light
                                        ? Icons.dark_mode
                                        : Icons.light_mode))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
