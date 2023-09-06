import 'dart:async';

import 'package:flutter/material.dart';
import 'package:powershare/OnBoard/onBoard.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/pgRegistration.dart';

import 'model/dbhelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    final _db = DBhelper();
    // final get = await _db.getToken();
    // final data = get[0].toString();

    _db.getToken().then((value) {
      print(value.length);
      if (value.length != 0) {
        print('ada token');
        Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(currentIndex: 0),
            ),
          ),
        );
      } else {
        print('tidak ada token');
        Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnBoard()),
          ),
        );
      }
      ;
    });

    // if (_db.getToken() != null) {
    //   Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => BottomNavBar(currentIndex: 0),
    //       ),
    //     ),
    //   );
    // } else {
    //   Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => OnBoard()),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.center,
        child: Image.asset("assets/logo/logo.png",
            width: MediaQuery.of(context).size.width),
      ),
    );
  }
}
