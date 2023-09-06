import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/pgLogin.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  // bool? rememberMe = false;
  // void _onRememberMeChanged(bool? newValue) => setState(() {
  //       rememberMe = newValue;

  //       if (rememberMe == true) {
  //         print("clicked");
  //       } else {
  //         // TODO: Forget the user
  //       }
  //     });
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController fullname = new TextEditingController();
  TextEditingController nickname = new TextEditingController();
  TextEditingController datebirth = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  // String? gender;
  String? selectedGender;
  TextEditingController password = new TextEditingController();
  List<String> genderOptions = ['Laki-Laki', 'Perempuan'];
  // String strUsername = '1462000142';
  // String strPassword = 'dayat';
  String error = '';

  bool visiblePassword = false;
  @override
  void initState() {
    // TODO: implement initState
    datebirth.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
        // appBar: topBar(),
        body: Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/logo/logo.png",
                    width: MediaQuery.of(context).size.width),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.50,
                minChildSize: 0.2,
                maxChildSize: 0.8,
                builder: (BuildContext c, s) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    // padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        controller: s,
                        children: [
                          // Center(child: Image.asset("storage/icon_minimize.png")),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              "Buat Akun",
                              style: TextStyle(
                                  fontSize: 24,
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: const Text(
                              "Silahkan masukkan identitas anda",
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: username,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Username",
                              labelText: "Username",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius:
                              //       BorderRadius.all(Radius.circular(10)),
                              // ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: email,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Alamat Email",
                              labelText: "Alamat Email",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius:
                              //       BorderRadius.all(Radius.circular(10)),
                              // ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: fullname,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Nama Lengkap",
                              labelText: "Nama Lengkap",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius:
                              //       BorderRadius.all(Radius.circular(10)),
                              // ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: nickname,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Nama Panggilan",
                              labelText: "Nama Panggilan",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius:
                              //       BorderRadius.all(Radius.circular(10)),
                              // ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller:
                                datebirth, //editing controller of this TextFormField
                            decoration: const InputDecoration(
                                suffixIcon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText: "Tanggal Lahir" //label text of field
                                ),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('y-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  datebirth.text =
                                      formattedDate; //set output date to TextFormField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phone,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Nomor Telepon",
                              labelText: "Nomor Telepon",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              // border: OutlineInputBorder(
                              //   borderRadius:
                              //       BorderRadius.all(Radius.circular(10)),
                              // ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Jenis Kelamin',
                            ),
                            value: selectedGender,
                            items: genderOptions.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedGender = newValue;
                                if (newValue == "Laki-Laki") {
                                  gender.text = "L";
                                  print(gender);
                                } else {
                                  gender.text = "P";
                                  print(gender);
                                }
                                // gender = newValue;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // TextFormField(
                          //   controller: password_,
                          //   obscureText: !visiblePassword,
                          //   style: TextStyle(color: Colors.black),
                          //   decoration: InputDecoration(
                          //     // errorText: this.error,
                          //     suffixIcon: GestureDetector(
                          //       onLongPress: () {
                          //         setState(() {
                          //           visiblePassword = true;
                          //         });
                          //       },
                          //       onLongPressUp: () {
                          //         setState(() {
                          //           visiblePassword = false;
                          //         });
                          //       },
                          //       child: Icon(
                          //         visiblePassword
                          //             ? Icons.visibility
                          //             : Icons.visibility_off,
                          //         color: Colors.grey[600],
                          //         size: 20,
                          //       ),
                          //     ),
                          //     hintText: "Password",
                          //     hintStyle: TextStyle(color: Colors.black),
                          //     labelText: "Password",
                          //     labelStyle: TextStyle(color: Colors.black),
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //     // border: OutlineInputBorder(
                          //     //   borderRadius:
                          //     //       BorderRadius.all(Radius.circular(10)),
                          //     // ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // TextField(
                          //   controller: password_,
                          //   obscureText: !visiblePassword,
                          //   style: TextStyle(color: Colors.black),
                          //   decoration: InputDecoration(
                          //     // errorText: this.error,
                          //     suffixIcon: GestureDetector(
                          //       onLongPress: () {
                          //         setState(() {
                          //           visiblePassword = true;
                          //         });
                          //       },
                          //       onLongPressUp: () {
                          //         setState(() {
                          //           visiblePassword = false;
                          //         });
                          //       },
                          //       child: Icon(
                          //         visiblePassword
                          //             ? Icons.visibility
                          //             : Icons.visibility_off,
                          //         color: Colors.grey[600],
                          //         size: 20,
                          //       ),
                          //     ),
                          //     hintText: "Konfirmasi Password",
                          //     hintStyle: TextStyle(color: Colors.black),
                          //     labelText: "Konfirmasi Password",
                          //     labelStyle: TextStyle(color: Colors.black),
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //     // border: OutlineInputBorder(
                          //     //   borderRadius:
                          //     //       BorderRadius.all(Radius.circular(10)),
                          //     // ),
                          //   ),
                          // ),
                          //
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                CreateAccount.create(
                                        username.text,
                                        email.text,
                                        fullname.text,
                                        nickname.text,
                                        datebirth.text,
                                        phone.text,
                                        gender.text)
                                    .then((value) {
                                  if (value != null) {
                                    print(value);
                                  } else {
                                    print("eror guys");
                                  }
                                });
                              } else {
                                print("Form harap diisi");
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                color: const Color(0xffd9d9d9),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  const BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius: 3,
                                    offset: Offset(0, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text("Buat",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff000000),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Sudah memiliki akun? ",
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext) => const Login()));
                                },
                                child: const Text(
                                  'Masuk Disini',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
