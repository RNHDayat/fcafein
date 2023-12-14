import 'package:flutter/material.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/user_akun.dart';

class PageNotification extends StatefulWidget {
  const PageNotification({super.key});

  @override
  State<PageNotification> createState() => _NotificationState();
}

class _NotificationState extends State<PageNotification> {
  List<GetNotif> listNotif = [];
  // GetNotif GetNotif = GetNotif();
  getListNotif() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    listNotif = await GetNotif.getNotif(data[0].token);
    setState(() {});
    print(listNotif.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      listNotif.length.toString() + " Notifikasi",
                      style: TextStyle(color: Colors.grey),
                    ),
                    // Container(
                    //   child: const Row(
                    //     children: [
                    //       Icon(Icons.tune, color: Colors.grey),
                    //       SizedBox(width: 10),
                    //       Icon(Icons.settings_outlined, color: Colors.grey),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              // const SizedBox(height: 20),
              listNotif.isEmpty
                  ? Text("Tidak ada notifikasi")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listNotif.length,
                      itemBuilder: (context, index) {
                        final item = listNotif[index];
                        // Memisahkan string berdasarkan spasi
                        List<String> words = item.body.split(' ');
                        // Mengambil elemen pertama dari array (nama)
                        String name = words.isNotEmpty ? words[0] : '';
                        String targetTimeString =
                            item.created_at.toString(); // Waktu yang ditentukan
                        DateTime targetTime = DateTime.parse(targetTimeString);
                        Duration difference =
                            targetTime.toLocal().difference(DateTime.now());
                        bool isNegative = difference.isNegative;

                        if (isNegative) {
                          difference = -difference;
                        }
                        String formattedTime =
                            "${difference.inHours} jam, ${difference.inMinutes.remainder(60)} menit";
                        if (isNegative) {
                          formattedTime = "-$formattedTime";
                        }
                        formattedTime =
                            "${difference.inHours} jam ${difference.inMinutes.remainder(60)} menit";
                        return GestureDetector(
                          onTap: () async {
                            final _db = DBhelper();
                            var data = await _db.getToken();
                            GetNotif.read(data[0].token, item.id.toString())
                                .then((value) {
                              if (value.statusCode == 200) {
                                setState(() {
                                  item.status_read = 1;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserAkun(
                                          id_user: item.id_user_follow),
                                    ));
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            color: item.status_read == 1
                                ? Colors.white
                                : Colors.grey[200],
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 28,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${name}· ${formattedTime} yang lalu",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(item.body == null ? "" : item.body,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: Icon(Icons.more_horiz),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
