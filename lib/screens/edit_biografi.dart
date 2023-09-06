import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBio extends StatefulWidget {
  const EditBio({super.key});

  @override
  State<EditBio> createState() => _EditBioState();
}

final TextEditingController _descriptionController = TextEditingController();

class _EditBioState extends State<EditBio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 64,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        // toolbarHeight: 55,
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    // fixedSize: const Size(75, 0),
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: Text(
                    'Selesai',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Deskripsi',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'katakan sesuatu',
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: 1,
                color: Color.fromRGBO(217, 217, 217, 100),
              ))),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
