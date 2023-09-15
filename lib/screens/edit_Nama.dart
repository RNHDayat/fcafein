import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:powershare/model/database.dart';

class EditNama extends StatefulWidget {
  // final Map ListData;
  const EditNama({super.key});

  @override
  State<EditNama> createState() => _EditNamaState();
}

class _EditNamaState extends State<EditNama> {
  final formKey = GlobalKey<FormState>();
  late Future<ChangeName> _futureChangeName;
  final TextEditingController _nameController = TextEditingController();
  final String apiUrl = 'http://10.0.2.2:8000/api/employee.updatefullname';

  // void updateEmployeeName() async {
  //   final response = await http.put(
  //     Uri.parse(
  //         'http://10.0.2.2:8000/api/employee.updatefullname/${widget.employeeId}'),
  //     // Uri.parse('http://10.0.2.2:8000/api/employee.updatefullname'),
  //     body: {
  //       'fullname': _nameController.text,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     // Data berhasil diperbarui, lakukan tindakan yang sesuai (misalnya, kembali ke layar sebelumnya).
  //     Navigator.pop(context, 'Employee name updated successfully');
  //   } else {
  //     // Kesalahan dalam mengirim permintaan ke API.
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text('Failed to update employee name'),
  //     ));
  //   }
  // }

  Future<ChangeName> fetchChangeName() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/employee.updatefullname'),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ChangeName.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ChangeName');
    }
  }

  Future<ChangeName> updateChangeName(String fullname) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/api/employee.updatefullname'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': fullname,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ChangeName.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }

  Future<void> updateUser() async {
    final apiUrl = Uri.parse('http://10.0.2.2:8000/employee/update-fullname');
    final response = await http.put(
      apiUrl,
      body: {'fullname': _nameController.text},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final message = jsonResponse['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update user'),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _futureChangeName = fetchChangeName();
  }

  // Future<void> updateEmployeeName() async {
  //   final String fullName = fullNameController.text.trim();

  //   if (fullName.isEmpty) {
  //     return;
  //   }

  //   final Map<String, String> data = {'fullname': fullName};

  //   final response = await http.put(
  //     Uri.parse(apiUrl),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     // Sukses mengubah nama
  //     final responseData = json.decode(response.body);
  //     print(responseData['message']);
  //   } else {
  //     // Gagal mengubah nama
  //     print('Gagal mengubah nama karyawan');
  //   }
  // }

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
                    setState(() {
                      _futureChangeName =
                          updateChangeName(_nameController.text);
                    });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Nama baru',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              ),
            ),
            FutureBuilder<ChangeName>(
              future: _futureChangeName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(snapshot.data!.fullname),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Title',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _futureChangeName =
                                  updateChangeName(_nameController.text);
                            });
                          },
                          child: const Text('Update Data'),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }

                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
