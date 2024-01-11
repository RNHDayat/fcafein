import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:powershare/add_ilmu.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/audiens.dart';
import 'package:powershare/screens/audiens_post.dart';
import 'package:powershare/screens/ubah_sandi-2.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/database.dart';
import '../model/dbhelper.dart';

class TambahPertanyaan extends StatefulWidget {
  final int initialIndex;
  const TambahPertanyaan({super.key, required this.initialIndex});

  @override
  _TambahPertanyaanState createState() => _TambahPertanyaanState();
}

class _TambahPertanyaanState extends State<TambahPertanyaan> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController tag = TextEditingController();
  final List<Widget> _tabs = [
    const Tab(text: 'Tambahkan Pertanyaan'),
    // const Tab(text: 'Buat kiriman Informasi'),
  ];
  PageIlmu? ruang;
  List<String> ruangs = [];
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  bool isChecked = true;
  bool hastag = false;
  int? tabIndex;

  List<PageIlmu?> ilmu = [];
  List<PageIlmu> listIlmu = [];
  List<PageIlmu> _searchTag = [];
  List<PageIlmu> viewSelected = [];
  List selected = [];
  PageIlmu pageIlmu = PageIlmu();

  getIlmu() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    listIlmu = await pageIlmu.get(data[0].token);
    ilmu = await pageIlmu.get(data[0].token);
    ruangs = listIlmu.map((e) => e.codeIlmu).toList().cast<String>();
    setState(() {});
  }

  onSearch(String text) async {
    _searchTag.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    listIlmu.forEach((element) {
      if (element.name.toLowerCase().contains(text.toLowerCase())) {
        _searchTag.add(element);
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabIndex = widget.initialIndex;
    setState(() {
      // hastag = false;
      if (widget.initialIndex == 0) {
        isChecked = false;
      } else {
        isChecked = true;
      }
    });
    getIlmu();
  }

  File? imageFile;
  var maxFileSizeInBytes = 2 * 1048576;
  final _picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    var imagePath = await pickedFile!.readAsBytes();
    var fileSize = imagePath.length; // Get the file size in bytes
    if (pickedFile != null) {
      if (fileSize <= maxFileSizeInBytes) {
        // File is the right size, upload/use it
        setState(() {
          imageFile = File(pickedFile.path);
        });
      } else {
        // File is too large, ask user to upload a smaller file, or compress the file/image
        Fluttertoast.showToast(
          msg: "Ukuran gambar terlalu besar",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  File? docFile;
  String? fileName;
  FilePickerResult? pickedFile;
  Future getFile() async {
    pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    var fileSize = File(pickedFile!.files.single.path!)
        .lengthSync(); // Get the file size in bytes
    double sizeInMb = fileSize / (1024 * 1024);
    if (pickedFile != null) {
      if (sizeInMb < 10) {
        setState(() {
          docFile = File(pickedFile!.files.single.path!);
          fileName = pickedFile!.files.single.name;
        });
      } else {
        // File is too large, ask user to upload a smaller file, or compress the file/image
        Fluttertoast.showToast(
          msg: "Ukuran file terlalu besar",
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }
  // String? getStringImage(File? file) {
  //   if (file == null) return null;
  //   return base64Encode(file.readAsBytesSync());
  // }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabIndex!,
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
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
          titleSpacing: 0,
          // leadingWidth: 70,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(
          //     Icons.keyboard_arrow_left_rounded,
          //     color: Colors.grey,
          //   ),
          // ),
          // title: const Text(' '),
          centerTitle: false,
          title: Visibility(
            visible: isChecked,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AudiensRuang()));
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.blur_circular_rounded,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Semua Orang',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          bottom: TabBar(
            onTap: (index) {
              // setState(() {
              //   tabIndex = index;
              //   // isChecked = index == 0;
              //   if (index == 0) {
              //     isChecked = false;
              //   } else if (index == 1) {
              //     isChecked = true;
              //   }
              // });
            },
            splashBorderRadius: BorderRadius.circular(5),
            labelColor: Colors.black, // Color of the active tab label
            unselectedLabelColor:
                Colors.black54, // Color of the inactive tab label
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3, // Width of the bottom border
                  color:
                      Colors.blue, // Color of the bottom border for active tab
                ),
              ),
            ),

            tabs: _tabs,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: ElevatedButton(
                onPressed: () async {
                  final _db = DBhelper();
                  var data = await _db.getToken();
                  if (key.currentState!.validate()) {
                    Postings.share(
                        title.text,
                        description.text,
                        data[0].token,
                        // selected.isEmpty ? '' : jsonEncode(selected),
                        ruang!.codeIlmu,
                        imageFile,
                        docFile);
                    setState(() {
                      title.clear();
                      description.clear();
                      selected.clear();
                      // imageFile!.delete();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text("Simpan"),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(217, 217, 217, 100),
                        ))),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        width: double.infinity,
                        color: const Color.fromRGBO(217, 217, 217, 100),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 15, bottom: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Kiat untuk mendapatkan jawaban yang baik dengan cepat",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " · Pastikan pertanyaan Anda belum pernah diajukan sebelumnya",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " · Pastikan pertanyaan Anda singkat padat, dan lugas",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 0, bottom: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " · Perikas kembali tata bahasa dan ejaan yang ada",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(
                      //       left: 15, right: 15, top: 0, bottom: 0),
                      //   child: Row(
                      //     children: [
                      //       const Icon(
                      //         Icons.account_circle_rounded,
                      //         color: Colors.grey,
                      //       ),
                      //       const SizedBox(
                      //         width: 5,
                      //       ),
                      //       const Icon(
                      //         Icons.arrow_right_outlined,
                      //         color: Colors.grey,
                      //       ),
                      //       const SizedBox(
                      //         width: 5,
                      //       ),
                      //       ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             alignment: Alignment.centerLeft,
                      //             backgroundColor: Colors.transparent,
                      //             elevation: 0,
                      //             shape: RoundedRectangleBorder(
                      //               side: const BorderSide(color: Colors.grey),
                      //               borderRadius: BorderRadius.circular(18.0),
                      //             ),
                      //           ),
                      //           onPressed: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const Audiens()));
                      //           },
                      //           child: Row(
                      //             children: [
                      //               const Icon(
                      //                 Icons.groups_rounded,
                      //                 color: Colors.grey,
                      //               ),
                      //               const SizedBox(
                      //                 width: 10,
                      //               ),
                      //               Text(
                      //                 'Publik',
                      //                 style: GoogleFonts.poppins(
                      //                     textStyle: const TextStyle(
                      //                         fontSize: 14,
                      //                         fontWeight: FontWeight.w600,
                      //                         color: Colors.grey)),
                      //               ),
                      //               const SizedBox(
                      //                 width: 10,
                      //               ),
                      //               const Icon(
                      //                 Icons.keyboard_arrow_down_outlined,
                      //                 color: Colors.grey,
                      //               ),
                      //             ],
                      //           )),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 0,
                                bottom: 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'Judul Topik',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return 'Judul tidak boleh kosong';
                                      }
                                    },
                                    controller: title,
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Inputkan topik atau judul dari pertanyaan anda',
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 0,
                                bottom: 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'Deskripsi / Pertanyaan',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 0, bottom: 0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return 'Deskripsi tidak boleh kosong';
                                      }
                                    },
                                    controller: description,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                      hintText:
                                          'Awali pertanyaan Anda dengan “Apa”, “Bagaimana”, “Mengapa”, dll.',
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        hastag = value.contains('#');
                                        var x = value;
                                        // print(x.split('#')[1]);
                                        hastag
                                            ? onSearch(x.split('#')[1])
                                            : onSearch('');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 0,
                          bottom: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Ruang',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 0,
                          bottom: 0,
                        ),
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.black),
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(10),
                        //   ),
                        // ),
                        child: DropdownButtonFormField<PageIlmu?>(
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          value: ruang,
                          onChanged: (value) {
                            setState(() {
                              ruang = value;
                            });
                          },
                          hint: Text("Pilih ruang"),
                          isExpanded: true,
                          items: ilmu
                              .map<DropdownMenuItem<PageIlmu>>(
                                (e) => DropdownMenuItem(
                                  child: Text(
                                    (e?.name ?? '').toString(),
                                  ),
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      //add image
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                          image: imageFile == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(imageFile ?? File('')),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.image,
                              size: 50, color: Colors.black38),
                          onPressed: () => getImage(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Center(
                          child: Column(
                            children: [
                              Text(fileName == null ? '' : fileName.toString()),
                              ElevatedButton(
                                onPressed: () => getFile(),
                                child: Text('Tambah File'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: hastag,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            // border: Border(
                            //   top: BorderSide(
                            //     color: Colors.grey,
                            //     width: 0.5,
                            //   ),
                            // ),
                          ),
                          // height: 500,
                          // color: Colors.red,
                          child: _searchTag.length != 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _searchTag.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      // color: Colors.blue,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            // print(description.text);
                                            // var x = description.text.split('#');
                                            // // print(x[0] + '#');
                                            // description.text = x[0] +
                                            //     '#' +
                                            //     _searchTag[index].name;
                                            // print(description.text);

                                            if (!selected
                                                .contains(_searchTag[index])) {
                                              selected.add(
                                                  _searchTag[index].codeIlmu);
                                              viewSelected
                                                  .add(_searchTag[index]);
                                              // print(jsonEncode(selected));

                                              tag.clear();
                                              hastag = false;
                                            }
                                          });
                                        },
                                        child: Text(
                                          '#' + _searchTag[index].name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Cari',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text('Atau'),
                                        const SizedBox(height: 10),
                                        ElevatedButton(
                                          onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const Add_ilmu(),
                                          )),
                                          child: const Text(
                                            'Tambahkan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: Column(
                //     children: [
                //       Container(
                //         decoration: const BoxDecoration(
                //             border: Border(
                //                 bottom: BorderSide(
                //           width: 1,
                //           color: Color.fromRGBO(217, 217, 217, 100),
                //         ))),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(
                //             left: 10, right: 10, top: 15, bottom: 10),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Andri Dwi',
                //               textAlign: TextAlign.left,
                //               style: GoogleFonts.poppins(
                //                   textStyle: const TextStyle(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w600,
                //               )),
                //             ),
                //             const SizedBox(height: 5),
                //             InkWell(
                //               onTap: () {
                //                 Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) =>
                //                             const Kredensial()));
                //               },
                //               child: Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Icon(
                //                     Icons.account_circle_rounded,
                //                     color: Colors.grey[400],
                //                     size: 40,
                //                   ),
                //                   // Container(
                //                   //   padding: EdgeInsets.all(5),
                //                   //   decoration: BoxDecoration(
                //                   //     borderRadius:
                //                   //         BorderRadius.all(Radius.circular(25)),
                //                   //     color: Colors.grey[200],
                //                   //   ),
                //                   //   child: Icon(
                //                   //     Icons.person,
                //                   //     size: 24,
                //                   //   ),
                //                   // ),
                //                   const SizedBox(
                //                     width: 5,
                //                   ),
                //                   Expanded(
                //                     // width: MediaQuery.of(context).size.width * 2,
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                         borderRadius: const BorderRadius.all(
                //                             Radius.circular(25)),
                //                         color: Colors.grey[200],
                //                       ),
                //                       alignment: Alignment.centerLeft,
                //                       padding: const EdgeInsets.all(10),
                //                       child: const Text(
                //                         'Belajar di Universital 17 Agustus 1945 Surabaya',
                //                         style: TextStyle(
                //                           fontSize: 12,
                //                           color: Colors.grey,
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Container(
                //           margin: const EdgeInsets.all(15),
                //           child: const Column(
                //             children: [
                //               TextField(
                //                 maxLines: null,
                //                 decoration: InputDecoration(
                //                   hintText: 'Katakan sesuatu ...',
                //                   border: InputBorder.none,
                //                   enabledBorder: InputBorder.none,
                //                 ),
                //               ),
                //             ],
                //           )),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
