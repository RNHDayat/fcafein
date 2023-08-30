import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';

class Add_ilmu extends StatefulWidget {
  const Add_ilmu({super.key});

  @override
  State<Add_ilmu> createState() => _Add_ilmuState();
}

class _Add_ilmuState extends State<Add_ilmu> {
  final _key = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  final Faker faker = Faker();

  String generateRandomCode() {
    String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String randomCode = String.fromCharCodes(Iterable.generate(
        5,
        (_) => characters.codeUnitAt(
            faker.randomGenerator.integer(characters.length - 1, min: 0))));
    return randomCode;
  }

  @override
  Widget build(BuildContext context) {
    String randomCode = generateRandomCode();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        final _db = DBhelper();
                        var data = await _db.getToken();
                        Ilmu.add(data[0].token, randomCode, nama.text);
                      }
                    },
                    child: Text(
                      'Buat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Buat Ilmu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Bagikan minat, kurasikan konten, selenggarakan diskusi, dan banyak lagi',
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Nama',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 8,
              ),
              Form(
                key: _key,
                child: TextFormField(
                  controller: nama,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama terlebih dahulu';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Nama Ilmu',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.blue), //<-- SEE HERE
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
