import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/screens/user_akun.dart';

import '../components/follow_button.dart';

class UserFollower extends StatefulWidget {
  const UserFollower({super.key});

  @override
  _UserFollowerState createState() => _UserFollowerState();
}

class _UserFollowerState extends State<UserFollower>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(' '),
            pinned: true,
            floating: true,
            leadingWidth: double.infinity,
            leading: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      side: const BorderSide(color: Colors.transparent),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                    ),
                    label: const Text('Andri Dwi'))
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: TabBar(
                controller: _tabController,
                splashBorderRadius: BorderRadius.circular(5),
                indicatorColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicator: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 3, // Width of the bottom border
                      color: Colors
                          .blue, // Color of the bottom border for active tab
                    ),
                  ),
                ),
                tabs: const [
                  SizedBox(
                    child: Tab(
                      text: 'Pengikut',
                    ),
                  ),
                  SizedBox(
                    child: Tab(
                      text: 'Mengikuti',
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      //BorderTop
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(217, 217, 217, 100),
                        ))),
                      ),

                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(217, 217, 217, 100),
                        ))),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey,
                                    ),
                                    width: 35,
                                    height: 35,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Column(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black),
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Nur Rojabiyah, ',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {},
                                                ),
                                                const TextSpan(
                                                  text: 'S1 di Teknik Fisika, ',
                                                ),
                                                TextSpan(
                                                  text:
                                                      'Institut Teknologi Sepuluh November(2023)',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {},
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "86 Pengikut",
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const FollowButton()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(217, 217, 217, 100),
                        ))),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey,
                                    ),
                                    width: 35,
                                    height: 35,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Column(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black),
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Julyanto Dui, ',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {},
                                                ),
                                                const TextSpan(
                                                  text:
                                                      'Mekanik alat berat di Pertambangan. ',
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {},
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "203 Pengikut",
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const FollowButton()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      //Border Top
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(217, 217, 217, 100),
                        ))),
                      ),

                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(217, 217, 217, 100),
                        ))),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey,
                                    ),
                                    width: 35,
                                    height: 35,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black),
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Nur Rojabiyah, ',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {},
                                                ),
                                                const TextSpan(
                                                  text: 'S1 di Teknik Fisika, ',
                                                ),
                                                TextSpan(
                                                  text:
                                                      'Institut Teknologi Sepuluh November(2023)',
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {},
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "86 Pengikut",
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.grey)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const FollowButton()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
