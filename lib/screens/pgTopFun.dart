import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/screens/user_akun.dart';

class PageTopFun extends StatefulWidget {
  const PageTopFun({super.key});

  @override
  State<PageTopFun> createState() => _PageTopFunState();
}

class _PageTopFunState extends State<PageTopFun> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rank();
  }

  TopFun topFun = TopFun();
  List<TopFun> TopFunList = [];
  rank() async {
    TopFunList = await topFun.board();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Fun"),
        backgroundColor: Colors.amber,
      ),
      body: TopFunList.isEmpty
          ? Center(child: Text("Maintenance"))
          : ListView.builder(
              itemCount: TopFunList.length,
              itemBuilder: (context, index) =>
                  buildList(context, index, TopFunList)),
    );
  }
}

Widget buildList(BuildContext ctxt, int index, List<TopFun> leaderBoardList) {
  int ind = index + 1;

  Widget crown;

  if (ind == 1) {
    crown = Container(
      child: Center(
        child: Text(
          '🥇',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  } else if (ind == 2) {
    crown = Container(
      child: Center(
        child: Text(
          '🥈',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  } else if (ind == 3) {
    crown = Container(
      child: Center(
        child: Text(
          '🥉',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  } else {
    crown = Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 13,
          child: Text(
            ind.toString(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          )),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)]),
    child: GestureDetector(
      onTap: () => Navigator.push(
          ctxt,
          MaterialPageRoute(
            builder: (context) =>
                UserAkun(id_user: leaderBoardList[index].id_user),
          )),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              // color: Colors.red,
              // alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  crown,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 3),
                        child: Text(
                          leaderBoardList[index].fullname,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              leaderBoardList[index].point.toString() + " pts ",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )
        ],
      ),
    ),
  );
}
