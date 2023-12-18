import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/user_akun.dart';

class EditNama extends StatefulWidget {
  final fullname, id;
  const EditNama({super.key, this.fullname, this.id});

  @override
  State<EditNama> createState() => _EditNamaState();
}

class _EditNamaState extends State<EditNama> {
  String token = '';
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullname = TextEditingController();

  saveNama(String fullname) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      UpdateNama.updateNama(data[0].token, fullname);
      // StoreCredential.store(token, type.toString(), description);
    });
  }

  // GetUser getUser = GetUser();
  // String fullnamee = '';
  // user() async {
  //   final _db = DBhelper();
  //   var data = await _db.getToken();
  //   print(data[0].token);
  //   GetUser.getUser(data[0].token).then((value) {
  //     setState(() {
  //       getUser = value;
  //       fullnamee = getUser.fullname!;
  //     });
  //   });
  // }
  // List<GetUser> user = [];
  GetUser user = GetUser(follow_status: 0);
  userLogin() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    // print(data[0].token);
    user = await GetUser.getUser(data[0].token, data[0].id);
    setState(() {});
    // GetUser.getUser(data[0].token).then((value) {
    //   setState(() {
    //     getUser = value;
    //     fullname = getUser.fullname!;
    //     address = getUser.address_house!;
    //     job = getUser.job_position!;
    //     company = getUser.company!;
    //     description = getUser.description!;
    //     start_year = getUser.start_year!;
    //     id_user = data[0].id;
    //     token = data[0].token;
    //     // print("nihhhhhhhh : ${getUser.description}");
    //     // // print(company);
    //     // print(getUser.id);
    //     // print(description);
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    userLogin();
    setState(() {
      fullname.text = widget.fullname;
    });
  }

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
                  onPressed: () async {
                    final _db = DBhelper();
                    var data = await _db.getToken();
                    if (formKey.currentState!.validate()) {
                      // saveNama(fullname.text);
                      UpdateNama.updateNama(data[0].token, fullname.text)
                          .then((value) {
                        if (value.statusCode == 200) {
                          Navigator.pop(context);
                        }
                      });
                    }
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
                    'Simpan',
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
        margin: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Edit Nama',
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: fullname,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Masukkan Nama",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
