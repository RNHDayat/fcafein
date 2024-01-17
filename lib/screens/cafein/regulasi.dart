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
import 'package:powershare/model/database.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/cafein/PDFRegulasiViewer.dart';
import 'package:powershare/screens/cafein/PDFViewerPage.dart';
import 'package:powershare/screens/cafein/beranda.dart';
import 'package:powershare/screens/cafein/bookRegulasi.dart';
import 'package:powershare/services/global.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Regulasi extends StatefulWidget {
  const Regulasi({super.key});

  @override
  State<Regulasi> createState() => _RegulasiState();
}

class _RegulasiState extends State<Regulasi> {
  var dio = Dio();
  final TextEditingController _searchController = TextEditingController();

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
  getListRegulasi() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    listRegulasi = await showRegulasi.showReg();
    originalListRegulasi = await showRegulasi.showReg();

    setState(() {});
    // return listRegulasi;
    print(listRegulasi.length);
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        listRegulasi = originalListRegulasi;
      } else {
        listRegulasi = listRegulasi
            .where((item) =>
                (item.shortDesc).toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListRegulasi();
    getListJenis();
    getListKategori();
    loadBookmark();
  }

  var _selectedJenisValue;
  List<JenisRegulasi> listJenis = [];
  List<DropdownMenuItem<String>> itemJenis = [];
  JenisRegulasi jenisRegulasi = JenisRegulasi();
  getListJenis() async {
    listJenis = await jenisRegulasi.showJenis();
    itemJenis = List.generate(
      listJenis.length,
      (index) => DropdownMenuItem(
        value: listJenis[index].id.toString(),
        child: Text(
          listJenis[index].name,
        ),
      ),
    );
    setState(() {});
    // return itemKategori;
  }

  var _selectedKategoriValue;
  List<KategoriRegulasi> listKategori = [];
  List<DropdownMenuItem<String>> itemKategori = [];
  KategoriRegulasi kategoriRegulasi = KategoriRegulasi();
  getListKategori() async {
    listKategori = await kategoriRegulasi.showKategori();
    itemKategori = List.generate(
      listKategori.length,
      (index) => DropdownMenuItem(
        value: listKategori[index].id.toString(),
        child: Text(
          listKategori[index].name,
        ),
      ),
    );
    setState(() {});
    // return itemKategori;
  }

  kategori() {
    for (int i = 0; i < listRegulasi.length; i++) {
      return listRegulasi[i]
          .id_kategori
          .map((kategori) => kategori.id)
          .toList();
    }
  }

  void filter(jenis, kategori) {
    setState(() {
      if (jenis == null && kategori == null) {
        listRegulasi = originalListRegulasi;
      } else if (jenis != null && kategori != null) {
        listRegulasi = listRegulasi.where((item) {
          List<dynamic> kategorial =
              item.id_kategori.map((kategori) => kategori.id).toList();
          return (item.id_jenis).toString().contains(jenis) &&
              kategorial.contains(kategori);
        }).toList();
      } else if (jenis != null && kategori == null) {
        listRegulasi = listRegulasi.where((item) {
          List<dynamic> kategorial =
              item.id_kategori.map((kategori) => kategori.id).toList();
          return (item.id_jenis).toString().contains(jenis);
        }).toList();
      } else if (jenis == null && kategori != null) {
        listRegulasi = listRegulasi.where((item) {
          List<dynamic> kategorial =
              item.id_kategori.map((kategori) => kategori.id).toList();
          return kategorial.contains(kategori);
        }).toList();
      }
    });
  }

  List<String>? idBookmark = [];
  saveBookmark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataBookmark = jsonEncode(idBookmark.toString());
    // await prefs.setString("bookRegulasi", dataBookmark);
    await prefs.setStringList("bookRegulasi", idBookmark!);
  }
  // List<String>? bookmark = [];

  loadBookmark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    idBookmark = await prefs.getStringList("bookRegulasi") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
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
                builder: (context) => BookRegulasi(),
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
                color: Colors.blue.shade900,
                // borderRadius: BorderRadius.only(
                //   bottomLeft: Radius.circular(50),
                //   bottomRight: Radius.circular(50),
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Regulasi",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  Image.asset(
                    "assets/logo/ic_reg.png",
                    height: 80,
                    width: 80,
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
                                          'Jenis Aturan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        InputDecorator(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0))),
                                            contentPadding: EdgeInsets.all(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: Text("Pilih Jenis"),
                                              value: _selectedJenisValue,
                                              onChanged: (value) {
                                                state(() {
                                                  _selectedJenisValue = value!;
                                                  print(_selectedJenisValue);
                                                });
                                              },
                                              items: itemJenis,
                                              isExpanded: true,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Kategori Aturan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 5),
                                        InputDecorator(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0))),
                                            contentPadding: EdgeInsets.all(5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: Text("Pilih Jenis"),
                                              value: _selectedKategoriValue,
                                              onChanged: (value) {
                                                state(() {
                                                  _selectedKategoriValue =
                                                      value!;
                                                  print(_selectedKategoriValue);
                                                });
                                              },
                                              items: itemKategori,
                                              isExpanded: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      filter(_selectedJenisValue,
                                          _selectedKategoriValue);
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
                child: listRegulasi.isEmpty
                    ? Text("Data Tidak Ditemukan")
                    : ListView.builder(
                        itemCount: listRegulasi.length,
                        itemBuilder: (context, index) {
                          final reg = listRegulasi[index];
                          final idKategoriList = reg.id_kategori
                              .map((kategori) => kategori.text)
                              .toList();
                          final idKategoriString = idKategoriList
                              .join(', '); // Gabungkan ID kategori dengan koma
                          bool isBookmark =
                              idBookmark!.contains(reg.id.toString());
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
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
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
                                                        filename:
                                                            reg.shortDesc),
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
                                          // idBookmark.add(reg.id);
                                          if (idBookmark!
                                              .contains(reg.id.toString())) {
                                            idBookmark!
                                                .remove(reg.id.toString());
                                          } else {
                                            idBookmark!.add(reg.id.toString());
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
                      ), /////
              ),
            ),
          ],
        ),
      ),
    );
  }
}
