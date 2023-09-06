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
        title: const Text(
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      "Budget saya 20 juta dan saya akan kuliah di bidang it, apa recomendasi macbook/laptop yang cocok?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey[200],
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 28,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Yanto Hendriyana",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
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
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      const Text(
                                        "Ikuti",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                const IntrinsicHeight(
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
                    const SizedBox(height: 10),

                    const Text(
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
                    const SizedBox(height: 10),
                    const Text(
                        "108 tayangan · Lihat 1 dukungan naik · Kiriman diterima oleh Yesaya | BTK"),
                  ],
                ),
              ),
              Divider(color: Colors.grey[300]),
              Container(
                // color: Colors.red,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.thumb_up),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text("12,5rb"),
                                  Container(
                                    height: 20,
                                    child: const VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                  ),
                                  const Icon(Icons.thumb_down),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Row(
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
                              padding: const EdgeInsets.all(10),
                              child: const Row(
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
                      const Icon(Icons.more_horiz),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                color: Colors.grey[300],
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Text("Tambahkan komentar ..."),
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
