import 'package:flutter/material.dart';
import 'package:powershare/pgRegistration.dart';
import 'package:powershare/services/customTab.dart';

class US extends StatefulWidget {
  @override
  State<US> createState() => _USState();
}

class _USState extends State<US> {
  final urlProfile =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: Colors.orange,
                    // height: 120,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    // padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          'Following',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        Icon(Icons.keyboard_arrow_down),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Level up Coding",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              "Perkembangan dunia digital tidak akan pernah terjadi tanpa adanya komunitas yang baik"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("6 Kontributor"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  // height: 50,
                                  width: 250,
                                  color: Colors.blue,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[300],
                                                ),
                                                child: Icon(Icons.person),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: RichText(
                                                  maxLines: 2,
                                                  text: TextSpan(
                                                    text: 'Angga Aditya, ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: const <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            ' belajar Sistem Informasi di Istitut Teknologi Tangerang Selatan',
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            // height: 1.5,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10),
                          child: Text(
                            "12,1 rb 17 kiriman informasi dalam jangka waktu seminggu terakhir",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -20,
                    left: 20,
                    // right: 0,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: NetworkImage(urlProfile),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // SizedBox(height: 40),
              Container(
                color: Colors.red,
                // padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: TabBar(
                                tabs: [
                                  Tab(
                                    icon: Icon(Icons.directions_bike),
                                  ),
                                  Tab(
                                    icon: Icon(
                                      Icons.directions_car,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 400,
                              // flex: 5,
                              child: TabBarView(
                                children: [
                                  // first tab bar view widget
                                  Container(
                                    color: Colors.red,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // second tab bar viiew widget
                                  Container(
                                    color: Colors.pink,
                                    child: Center(
                                      child: Text(
                                        'Car',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage({
    required String urlImage,
    required EdgeInsets margin,
  }) =>
      Container(
        margin: margin,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(urlImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.25),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
        ),
      );
}
