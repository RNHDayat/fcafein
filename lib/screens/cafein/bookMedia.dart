import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/cafein/PDFMediaViewer.dart';
import 'package:powershare/screens/cafein/media.dart';
import 'package:powershare/services/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMedia extends StatefulWidget {
  const BookMedia({super.key});

  @override
  State<BookMedia> createState() => _BookMediaState();
}

class _BookMediaState extends State<BookMedia> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getListMedia();
  }

  String token = '';

  getToken() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      token = data[0].token;
    });
  }

  Future downloadFileMedia(int id, String fileName) async {
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
      url: URL + "cafein/downloadFileMedia/$id",
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

  List<ShowMedia> listMedia = [];
  List<ShowMedia> originalListMedia = [];
  ShowMedia showMedia = ShowMedia();
  List<String>? bookmark = [];
  getListMedia() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bookmark = await prefs.getStringList("bookMedia");
    listMedia = await showMedia.showMedia();
    originalListMedia = await showMedia.showMedia();
    listMedia = listMedia.where((item) {
      if (bookmark != null) {
        return bookmark!.any((bm) => item.id == int.parse(bm));
      }
      return false;
    }).toList();

    setState(() {});
    print(bookmark);
    for (int i = 0; i < listMedia.length; i++) {
      print(listMedia[i].id);
    }
  }

  deleteBookmark(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (bookmark!.contains(id)) {
      bookmark!.remove(id);
      String dataBookmark = jsonEncode(bookmark.toString());

      await prefs.setStringList("bookRegulasi", bookmark!);
    }
    listMedia = listMedia.where((item) {
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
              builder: (context) => Media(),
            ),
            (route) => false,
          ),
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: listMedia.isEmpty
            ? Text("Data Tidak Ditemukan")
            : ListView.builder(
                itemCount: listMedia.length,
                itemBuilder: (context, index) {
                  final media = listMedia[index];
                  bool isBookmark = bookmark!.contains(media.id.toString());
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
                            '${media.nama_media}',
                            style: TextStyle(
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${media.headline}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Volume : ${media.no_volume}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tahun ${media.tahun}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  icon: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: Hero(
                                    tag: media.id,
                                    child: Image.network(
                                      URL + "cafein/showCover/" + media.cover,
                                      headers: {
                                        "Authorization": 'Bearer ${token}',
                                        "login-type": "0",
                                      },
                                      fit: BoxFit.cover,
                                      // height: 100,
                                      // width: 100,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Center(
                              child: Hero(
                                tag: media.id,
                                child: Image.network(
                                  URL + "cafein/showCover/" + media.cover,
                                  headers: {
                                    "Authorization": 'Bearer ${token}',
                                    "login-type": "0",
                                  },
                                  fit: BoxFit.cover,
                                  height: 100,
                                  // width: 100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  downloadFileMedia(media.id, media.attachment);
                                  print(media.id);
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
                                        builder: (context) => PDFMediaViewer(
                                            id: media.id,
                                            filename: media.headline),
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
                                  print(media.id);
                                  deleteBookmark(media.id.toString());
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.bookmark_add,
                                  color: isBookmark
                                      ? Colors.red
                                      : Colors.blue.shade900,
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
      ),
    );
  }
}
