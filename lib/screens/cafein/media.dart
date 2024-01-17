import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/cafein/PDFMediaViewer.dart';
import 'package:powershare/screens/cafein/PDFViewerPage.dart';
import 'package:powershare/screens/cafein/beranda.dart';
import 'package:powershare/screens/cafein/bookMedia.dart';
import 'package:powershare/services/global.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Media extends StatefulWidget {
  const Media({super.key});

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  var dio = Dio();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController volumeController =
      TextEditingController(text: '0');
  final TextEditingController tahunController =
      TextEditingController(text: '0');

  Future<void> downloadFile(int id) async {
    try {
      final _db = DBhelper();
      var data = await _db.getToken(); // Ganti dengan endpoint yang sesuai
      Uri url = Uri.parse(URL + "cafein/downloadRegulasi/$id");
      var response = await http.get(url, headers: {
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000",
        "Authorization": 'Bearer ${data[0].token}',
        "Content-Type": "application/pdf",
        "login-type": "0",
      });

      if (response.statusCode == 200) {
        final fileName =
            'nama_file.pdf'; // Ganti dengan nama file yang diinginkan
        final directory =
            await getExternalStorageDirectory(); // atau getApplicationDocumentsDirectory() untuk penyimpanan dalam aplikasi

        final file = File('/storage/emulated/0/download/$fileName');
        await file.writeAsBytes(response.bodyBytes);

        print('File berhasil diunduh di ${file.path}');
      } else {
        print('Gagal mengunduh file. Kode status: ${response.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
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
  getListMedia() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    listMedia = await showMedia.showMedia();
    originalListMedia = await showMedia.showMedia();
    setState(() {});
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        listMedia = originalListMedia;
      } else {
        listMedia = listMedia
            .where((item) =>
                (item.headline).toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void filter(volume, tahun) {
    setState(() {
      if (volume.isEmpty && tahun.isEmpty) {
        listMedia = originalListMedia;
      } else if (volume.isNotEmpty && tahun.isNotEmpty) {
        listMedia = listMedia.where((item) {
          return (item.no_volume).toString().contains(volume) &&
              (item.tahun).toString().contains(tahun);
        }).toList();
      } else if (volume.isNotEmpty && tahun.isEmpty) {
        listMedia = listMedia.where((item) {
          return (item.no_volume).toString().contains(volume);
        }).toList();
      } else if (volume.isEmpty && tahun.isNotEmpty) {
        listMedia = listMedia.where((item) {
          return (item.tahun).toString().contains(tahun);
        }).toList();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    getListMedia();
    loadBookmark();
  }

  String token = '';

  getToken() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      token = data[0].token;
    });
  }

  List<String>? idBookmark = [];
  saveBookmark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataBookmark = jsonEncode(idBookmark.toString());
    // await prefs.setString("bookRegulasi", dataBookmark);
    await prefs.setStringList("bookMedia", idBookmark!);
  }
  // List<String>? bookmark = [];

  loadBookmark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    idBookmark = await prefs.getStringList("bookMedia") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeCafein(),
            ),
            (route) => false,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BookMedia(),
              ),
              (route) => false,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.yellow.shade900,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(50),
                //   bottomRight: Radius.circular(50),
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Media",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  Image.asset(
                    "assets/logo/ic_media.png",
                    height: 100,
                    width: 100,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            // Add padding around the search bar
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            // Use a Material design search bar
                            child: TextField(
                              onChanged: (value) {
                                filterSearchResults(value);
                              },
                              style: TextStyle(color: Colors.white),
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Cari...',

                                // suffixIcon: IconButton(
                                //   icon: Icon(Icons.clear, color: Colors.white),
                                //   onPressed: () => _searchController.clear(),
                                // ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search, color: Colors.white),
                                  onPressed: () {
                                    // Perform the search here
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: StatefulBuilder(
                                    builder: (BuildContext context, state) {
                                  return Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          'Volume',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        TextField(
                                          controller: volumeController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Tahun',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        TextField(
                                          controller: tahunController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      filter(volumeController.text,
                                          tahunController.text);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Terapkan"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 5),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: listMedia.isEmpty
                    ? Text("Data Tidak Ditemukan")
                    : ListView.builder(
                        itemCount: listMedia.length,
                        itemBuilder: (context, index) {
                          final media = listMedia[index];
                          bool isBookmark =
                              idBookmark!.contains(media.id.toString());
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black.withOpacity(
                                //         0.2), // Warna dan opasitas bayangan
                                //     offset: Offset(0, 2), // Geser bayangan
                                //     blurRadius: 4, // Radius blur
                                //     spreadRadius: 1, // Radius penyebaran
                                //   ),
                                // ],
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
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
                                              URL +
                                                  "cafein/showCover/" +
                                                  media.cover,
                                              headers: {
                                                "Authorization":
                                                    'Bearer ${token}',
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
                                          URL +
                                              "cafein/showCover/" +
                                              media.cover,
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
                                          downloadFileMedia(
                                              media.id, media.attachment);
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
                                                builder: (context) =>
                                                    PDFMediaViewer(
                                                        id: media.id,
                                                        filename:
                                                            media.headline),
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
                                          if (idBookmark!
                                              .contains(media.id.toString())) {
                                            idBookmark!
                                                .remove(media.id.toString());
                                          } else {
                                            idBookmark!
                                                .add(media.id.toString());
                                          }
                                          print(jsonEncode(
                                              idBookmark!.toString()));
                                          saveBookmark();
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
                                      //--share
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
            ),
          ],
        ),
      ),
    );
  }
}
