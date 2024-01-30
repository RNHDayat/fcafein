import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/cafein/PDFRegulasiViewer.dart';
import 'package:powershare/screens/cafein/regulasi.dart';
import 'package:powershare/services/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRegulasi extends StatefulWidget {
  const BookRegulasi({super.key});

  @override
  State<BookRegulasi> createState() => _BookRegulasiState();
}

class _BookRegulasiState extends State<BookRegulasi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // load();
    getListRegulasi();
  }

  Future downloadRegulasi(int id, String fileName) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    // Uri url = Uri.parse(URL + "cafein/downloadRegulasi/$id");
    final directory = await getExternalStorageDirectory();
    int count = 1;
    String originalFileName = fileName;

    while (await _fileExists(fileName)) {
      fileName = '(${count++}) ${originalFileName}';
    }
    final taskId = await FlutterDownloader.enqueue(
      url: URL + "cafein/downloadRegulasi/$id",
      headers: {
        // "Connection": "Keep-Alive",
        // "Keep-Alive": "timeout=5, max=1000",
        "Authorization": 'Bearer ${data[0].token}',
        "Content-Type": "application/pdf",
        "login-type": "0",
      }, // optional: header send with url (auth token etc)
      savedDir: '/storage/emulated/0/download/',
      fileName: fileName,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  Future<bool> _fileExists(String fileName) async {
    final file = File('/storage/emulated/0/download/$fileName');
    return await file.exists();
  }

  List<ShowRegulasi> listRegulasi = [];
  List<ShowRegulasi> originalListRegulasi = [];
  ShowRegulasi showRegulasi = ShowRegulasi();
  List<String>? bookmark = [];
  getListRegulasi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bookmark = await prefs.getStringList("bookRegulasi");
    listRegulasi = await showRegulasi.showReg();
    originalListRegulasi = await showRegulasi.showReg();
    listRegulasi = listRegulasi.where((item) {
      if (bookmark != null) {
        return bookmark!.any((bm) => item.id == int.parse(bm));
      }
      return false;
    }).toList();

    setState(() {});
    // return listRegulasi;
    print(bookmark);
  }

  deleteBookmark(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (bookmark!.contains(id)) {
      bookmark!.remove(id);
      String dataBookmark = jsonEncode(bookmark.toString());

      await prefs.setStringList("bookRegulasi", bookmark!);
    }
    listRegulasi = listRegulasi.where((item) {
      if (bookmark != null) {
        return bookmark!.any((bm) => item.id.toString().contains(bm));
      }
      return false;
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
        leading: GestureDetector(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Regulasi(),
            ),
            (route) => false,
          ),
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: listRegulasi.isEmpty
          ? Text("Data Tidak Ditemukan")
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: listRegulasi.length,
                itemBuilder: (context, index) {
                  final reg = listRegulasi[index];
                  final idKategoriList =
                      reg.id_kategori.map((kategori) => kategori.text).toList();
                  final idKategoriString = idKategoriList
                      .join(', '); // Gabungkan ID kategori dengan koma

                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                                0.2), // Warna dan opasitas bayangan
                            offset: Offset(0, 2), // Geser bayangan
                            blurRadius: 4, // Radius blur
                            spreadRadius: 1, // Radius penyebaran
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${reg.name} Nomor ${reg.nomor} Tahun ${reg.tahun}',
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${reg.shortDesc}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Kategori : ${idKategoriString}",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  // downloadFile(reg.id);
                                  downloadRegulasi(reg.id, reg.doc);
                                  print(reg.id);
                                },
                                child: Icon(
                                  Icons.download,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            // PDFViewerPage(id: reg.id),
                                            PDFRegulasiViewer(
                                                id: reg.id,
                                                filename: reg.shortDesc),
                                      ));
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  print(reg.id);
                                  deleteBookmark(reg.id.toString());
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.bookmark_add,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(width: 5),
                              // Icon(
                              //   Icons.share,
                              //   color: Colors.blue.shade900,
                              // ),
                              // SizedBox(width: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ), /////
    );
  }
}
