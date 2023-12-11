import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/edit_profile.dart';
import 'package:powershare/screens/user_akun.dart';

class EditBio extends StatefulWidget {
  final String description;
  const EditBio({super.key, required this.description});

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  String token = '';
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  saveDescrip(String description) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      UpdateDescrip.updateDescrip(data[0].token, description);
      // StoreCredential.store(token, type.toString(), description);
    });
  }

  GetUser getUser = GetUser();
  String descriptions = '';
  String name = '';
  user() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print(data[0].token);
    // GetUser.getUser(data[0].token).then((value) {
    //   setState(() {
    //     getUser = value;
    //     descriptions = getUser.description!;
    //     name = getUser.fullname!;
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      description.text = widget.description;
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
                      saveDescrip(description.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(
                                    name: name,
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserAkun(id_user:data[0].id)));
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
        child: Form(
          key: formKey,
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
                    controller: description,
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
      ),
    );
  }
}
