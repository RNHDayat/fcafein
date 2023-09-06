import 'package:flutter/material.dart';
import 'package:powershare/pgFollowing.dart';
import 'package:powershare/pgHome.dart';
import 'package:powershare/drawerWidget.dart';
import 'package:powershare/Answer/pgAnswer.dart';
import 'package:powershare/pgLogin.dart';
import 'package:powershare/pgNotification.dart';
import 'package:powershare/pgRegistration.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:powershare/screens/screen_ruang.dart';
import 'package:powershare/search.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  // BottomNavBar(this.selectedPage);
  const BottomNavBar({super.key, required this.currentIndex});
  // const BottomNavBar ({ Key? key, required this.selectedPage }): super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //inisialisasi variabel
  bool search = true;
  bool addQuestion = true;
  // int _currentIndex = 0;
  String _currentMenu = 'Home';
  int? getIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIndex = widget.currentIndex;
  }

  //metod ini akan dijalankna saat diklik
  void _changeSelectedNavBar(int index) {
    setState(() {
      getIndex = index;
      if (index == 0) {
        _currentMenu = 'Beranda';
        search = true;
        addQuestion = true;
      } else if (index == 1) {
        _currentMenu = 'Mengikuti';
        search = true;
        addQuestion = true;
      } else if (index == 2) {
        _currentMenu = 'Jawab';
        search = true;
        addQuestion = true;
      } else if (index == 3) {
        _currentMenu = 'Ruang';
        search = true;

        addQuestion = false;
      } else if (index == 4) {
        _currentMenu = 'Notifikasi';
        search = true;

        addQuestion = false;
      } else if (index == 5) {
        _currentMenu = 'Account';
      }
    });
  }

  List pages = [
    const Home(),
    const Following(),
    Answer(),
    const ScreenRuang(),
    const PageNotification(),
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // toolbarHeight: 70,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: Colors.grey[300],
          ),
        ),
        leading: InkWell(
          onTap: (() {
            if (scaffoldKey.currentState!.isDrawerOpen) {
              scaffoldKey.currentState!.closeDrawer();
              //close drawer, if drawer is open
            } else {
              scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          }),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.black),
            ),
          ),
        ),
        title: Text(_currentMenu),
        actions: [
          Visibility(
            visible: search,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(),
                    ),
                  );
                },
                child: const Icon(Icons.search),
              ),
            ),
          ),
          Visibility(
            visible: addQuestion,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TambahPertanyaan(initialIndex: 0),
                    ));
                  },
                  child: const Icon(Icons.add_circle_outline)),
            ),
          ),
        ],
      ),
      body: pages[getIndex!],
      //membuat bottom navigation
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false, // <-- HERE
        showUnselectedLabels: false,
        //membuat item navigasi
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.article), label: 'Mengikuti'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.question_answer), label: 'Jawab'),
          const BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Ruang'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifikasi'),
        ],

        //currentindex mengikuti baris item bottom navigasi yang diklik
        currentIndex: getIndex!,

        //warna saat item diklik
        selectedItemColor: Colors.black,

        //metode yang dijalankan saat ditap
        onTap: _changeSelectedNavBar,

        //agar bottom navigation tidak bergerak saat diklik
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
