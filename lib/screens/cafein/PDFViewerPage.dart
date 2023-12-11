import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/services/global.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatefulWidget {
  final int id;
  const PDFViewerPage({super.key, required this.id});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PdfViewerController _pdfViewerController = PdfViewerController();
  PdfTextSearchResult _searchResult = PdfTextSearchResult();

  @override
  void initState() {
    super.initState();
    loadPDF();
    // dtoken();
  }

  var pdfData = Uint8List(0);
  Future<void> loadPDF() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    Uri url = Uri.parse(URL + "cafein/downloadRegulasi/${widget.id}");
    var response = await http.get(url, headers: {
      "Authorization": 'Bearer ${data[0].token}',
      "Content-Type": "application/pdf",
      "login-type": "0",
    });

    if (response.statusCode == 200) {
      pdfData = response.bodyBytes;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.memory(
        pdfData,
      ),
    );
  }
}
