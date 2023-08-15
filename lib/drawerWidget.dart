import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/pgNewPassword.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:powershare/screens/user_akun.dart';
import 'package:powershare/splashScreen.dart';

import 'model/dbhelper.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 1.5,
        child: Column(children: <Widget>[
          _drawerHeader(context),
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                title: Text('Pesan'),
                leading: Icon(Icons.chat),
                onTap: () {},
              ),
              ListTile(
                title: Text('Konten & Statistik Anda'),
                leading: Icon(Icons.bar_chart),
                onTap: () {},
              ),
              ListTile(
                title: Text('Daftar Bacaan'),
                leading: Icon(Icons.bookmark_outline),
                onTap: () {},
              ),
              ListTile(
                title: Text('Draf'),
                leading: Icon(Icons.drafts_sharp),
                onTap: () {},
              ),
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
                    Divider(),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                                      builder: (context) => SettingAkun(),
                                    ));
                                  },
                                  child: Row(
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
                                          Container(
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
                                                    'Tambahkan Kredensial',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              alignment: Alignment.centerLeft,
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0,
                                            ),
                                            onPressed: () async {
                                              final _db = DBhelper();
                                              await _db.deleteToken();
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) =>
                                                    SplashScreen(),
                                              ));
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
                                                        'Keluar',
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
                            child: Icon(Icons.more_horiz),
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

Widget _drawerHeader(context) {
  return UserAccountsDrawerHeader(
    decoration: BoxDecoration(color: Colors.white),
    currentAccountPicture: ClipOval(
      child:
          Image(image: AssetImage('assets/logo/logo.png'), fit: BoxFit.cover),
    ),
    otherAccountsPictures: [
      ClipOval(
        child:
            Image(image: AssetImage('assets/logo/logo.png'), fit: BoxFit.cover),
      ),
    ],
    accountName: Text(''),
    accountEmail: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserAkun(),
            ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Andri Dwi',
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
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
