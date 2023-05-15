import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Jawab",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[300],
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      "Budget saya 20 juta dan saya akan kuliah di bidang it, apa recomendasi macbook/laptop yang cocok?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey[200],
                            ),
                            child: Icon(
                              Icons.person,
                              size: 28,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Yanto Hendriyana",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(
                                            1.0), //I used some padding without fixed width and height
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "Ikuti",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Text("3 Jam"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                        "Macbook/Laptop Kuliah IT \nBudget saya 20 juta dan saya akan kuliah di bidang it, apa rekomendasi macbook/laptop yang cocok:\nMacBook Air (M1, 2020): MacBook Air dengan chipset M1 terbaru dari Apple memberikan performa yang sangat baik untuk tugas-tugas IT. Selain itu, laptop ini memiliki layar Retina yang jernih, keyboard yang nyaman dan baterai yang tahan lama.Dell XPS 13: Laptop ini adalah salah satu laptop terbaik dari Dell dengan desain yang ramping, layar yang tajam, performa yang sangat baik dan baterai yang tahan lama.Asus ZenBook UX425: Laptop dari Asus ini mempunyai performa yang baik, layar 14 inci yang tajam, keyboard yang nyaman dan baterai yang tahan lama. HP Spectre x360: Laptop dari HP ini mempunyai desain yang cantik, performa yang sangat baik, layar yang tajam dan baterai yang tahan lama.Saran terbaik untuk memilih laptop adalah dengan menyesuaikan dengan kebutuhan dan preferensi pribadi Anda, termasuk ukuran layar, bobot, portabilitas, dan spesifikasi teknis. Pastikan laptop yang Anda pilih memiliki spesifikasi yang cukup untuk menjalankan aplikasi dan program yang akan Anda gunakan selama kuliah dibidangIT."),
                    // Row(
                    //   children: [
                    //     Text("108 tayangan"),
                    //     Container(
                    //       padding: const EdgeInsets.all(
                    //           1.0), //I used some padding without fixed width and height
                    //       decoration: new BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.grey[400],
                    //       ),
                    //     ),
                    //     Text("Lihat 1 dukungan naik"),
                    //     Container(
                    //       padding: const EdgeInsets.all(
                    //           1.0), //I used some padding without fixed width and height
                    //       decoration: new BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Colors.grey[400],
                    //       ),
                    //     ),
                    //     Expanded(
                    //         child: Text("Kiriman diterima oleh Yesaya | BTK")),
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    Text(
                        "108 tayangan · Lihat 1 dukungan naik · Kiriman diterima oleh Yesaya | BTK"),
                  ],
                ),
              ),
              Divider(color: Colors.grey[300]),
              Container(
                // color: Colors.red,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.thumb_up),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("12,5rb"),
                                  Container(
                                    height: 20,
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  Icon(Icons.thumb_down),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(Icons.chat_bubble),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("345"),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("120"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.more_horiz),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text("Tambahkan komentar ..."),
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
}
