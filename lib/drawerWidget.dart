import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/comment.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/pgLogin.dart';
import 'package:powershare/pgNewPassword.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/cafein/beranda.dart';
import 'package:powershare/screens/pgTopFun.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:powershare/screens/setting_screen.dart';
import 'package:powershare/screens/user_akun.dart';
import 'package:powershare/splashScreen.dart';

import 'model/dbhelper.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // user();
  }

  GetUser getUser = GetUser();
  String fullname = '';
  String nickname = '';
  String address = '';
  String job = '';
  String company = '';
  String start_year = '';
  int id_user = 0;
  String token = '';

  // user() async {
  //   final _db = DBhelper();
  //   var data = await _db.getToken();
  //   print(data[0].token);
  //   GetUser.getUser(data[0].token).then((value) {
  //     setState(() {
  //       getUser = value;
  //       fullname = getUser.fullname!;
  //       nickname = getUser.nickname!;
  //       address = getUser.address_house!;
  //       job = getUser.job_position!;
  //       company = getUser.company!;
  //       start_year = getUser.start_year!;
  //       id_user = data[0].id;
  //       token = data[0].token;
  //       // print("nihhhhhhhh : ${getUser.description}");
  //       // print(company);
  //     });
  //   });
  //   // _db.getToken().then((value) {
  //   //   print('nih : $value');
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 1.5,
        child: Column(children: <Widget>[
          _drawerHeader(context, nickname),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: const Text('Top Fun'),
                leading: const Icon(
                  Icons.leaderboard_rounded,
                  color: Colors.amber,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageTopFun(),
                      ));
                },
              ),
              // ListTile(
              //   title: const Text('Konten & Statistik Anda'),
              //   leading: const Icon(Icons.bar_chart),
              //   onTap: () {},
              // ),
              // ListTile(
              //   title: const Text('Daftar Bacaan'),
              //   leading: const Icon(Icons.bookmark_outline),
              //   onTap: () {},
              // ),
              // ListTile(
              //   title: const Text('Draf'),
              //   leading: const Icon(Icons.drafts_sharp),
              //   onTap: () {},
              // ),
            ],
          )),
          // This container holds the align
          Container(
            // This align moves the children to the bottom
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              // This container holds all the children that will be aligned
              // on the bottom and should not scroll with the above ListView
              child: Container(
                child: Column(
                  children: <Widget>[
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingScreen(),
                                    ));
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.settings),
                                      SizedBox(width: 5),
                                      Text("Setelan"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    height: 300,
                                    child: Center(
                                      child: ListView(
                                        children: [
                                          // Container(
                                          //   decoration: const BoxDecoration(
                                          //     border: Border(
                                          //       bottom: BorderSide(
                                          //         color: Color.fromRGBO(
                                          //             217, 217, 217, 100),
                                          //         width: 1.0,
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   height: 50,
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment.center,
                                          //     children: [
                                          //       SizedBox(
                                          //         child: Text(
                                          //           'Tambahkan Kredensial',
                                          //           textAlign: TextAlign.center,
                                          //           style: GoogleFonts.poppins(
                                          //             textStyle:
                                          //                 const TextStyle(
                                          //                     fontSize: 12,
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w500,
                                          //                     color:
                                          //                         Colors.grey),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              alignment: Alignment.centerLeft,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                            ),
                                            onPressed: () async {
                                              final _db = DBhelper();
                                              // await _db.deleteToken();
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeCafein()),
                                                      (route) => false);
                                            },
                                            child: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color.fromRGBO(
                                                          217, 217, 217, 100),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                height: 50,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        'Kembali ke beranda',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          textStyle:
                                                              const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(Icons.more_horiz),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

Widget _drawerHeader(context, String nickname) {
  return UserAccountsDrawerHeader(
    decoration: const BoxDecoration(color: Colors.white),
    // currentAccountPicture: const ClipOval(
    //   child:
    //       Image(image: AssetImage('assets/logo/logo.png'), fit: BoxFit.cover),
    // ),
    // otherAccountsPictures: [
    //   const ClipOval(
    //     child:
    //         Image(image: AssetImage('assets/logo/logo.png'), fit: BoxFit.cover),
    //   ),
    // ],
    accountName: const Text(''),
    accountEmail: GestureDetector(
      onTap: () async {
        final _db = DBhelper();
        var data = await _db.getToken();
        print(data[0].id);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  UserAkun(id_user: data[0].id),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profil",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    ),
  );
}

Widget _drawerItem({IconData? icon, String? text, GestureTapCallback? onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            text!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
