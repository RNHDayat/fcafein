import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/services/global.dart';

class PDFMediaViewer extends StatefulWidget {
  final id, filename;
  const PDFMediaViewer({super.key, required this.id, required this.filename});

  @override
  State<PDFMediaViewer> createState() => _PDFMediaViewerState();
}

class _PDFMediaViewerState extends State<PDFMediaViewer> {
  bool _isLoading = true;
  PDFDocument document = PDFDocument();

  @override
  void initState() {
    super.initState();
    changePDF();
  }

  changePDF() async {
    setState(() => _isLoading = true);
    final _db = DBhelper();
    var data = await _db.getToken();
    document = await PDFDocument.fromURL(
        "${URL}cafein/viewFileMedia/${widget.id}",
        headers: {
          "Authorization": 'Bearer ${data[0].token}',
          "Content-Type": "application/pdf",
          "login-type": "0",
        });

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filename),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
                //uncomment below line to preload all pages
                lazyLoad: false,
                // uncomment below line to scroll vertically
                scrollDirection: Axis.vertical,

                
              ),
      ),
    );
  }
}
