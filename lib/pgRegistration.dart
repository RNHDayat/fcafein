import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/pgLogin.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool? rememberMe = false;
  void _onRememberMeChanged(bool? newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe == true) {
          print("clicked");
        } else {
          // TODO: Forget the user
        }
      });
  TextEditingController username_ = new TextEditingController();
  TextEditingController password_ = new TextEditingController();
  String strUsername = '1462000142';
  String strPassword = 'dayat';
  String error = '';

  bool visiblePassword = false;
  String? username, pasword;
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
              margin: EdgeInsets.only(top: 100),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    // padding: EdgeInsets.all(10),
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      controller: s,
                      children: [
                        // Center(child: Image.asset("storage/icon_minimize.png")),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Buat Akun",
                            style: TextStyle(
                                fontSize: 24,
                                // color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          height: 30,
                        ),
                        TextField(
                          controller: username_,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
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
                        Container(
                          height: 10,
                        ),
                        TextField(
                          controller: username_,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
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
                        Container(
                          height: 10,
                        ),
                        TextField(
                          controller: password_,
                          obscureText: !visiblePassword,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            // errorText: this.error,
                            suffixIcon: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  visiblePassword = true;
                                });
                              },
                              onLongPressUp: () {
                                setState(() {
                                  visiblePassword = false;
                                });
                              },
                              child: Icon(
                                visiblePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                            labelText: "Password",
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
                        Container(
                          height: 10,
                        ),
                        TextField(
                          controller: password_,
                          obscureText: !visiblePassword,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            // errorText: this.error,
                            suffixIcon: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  visiblePassword = true;
                                });
                              },
                              onLongPressUp: () {
                                setState(() {
                                  visiblePassword = false;
                                });
                              },
                              child: Icon(
                                visiblePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            hintText: "Konfirmasi Password",
                            hintStyle: TextStyle(color: Colors.black),
                            labelText: "Konfirmasi Password",
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                  child: Row(
                                children: [
                                  Checkbox(
                                      value: rememberMe,
                                      onChanged: _onRememberMeChanged),
                                  Text(
                                    "Ingat Saya",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(
                                height: 16,
                              ),
                              TextButton(
                                child: Text(
                                  "Lupa password ?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext) => Login()));
                            // if (username_.text == strUsername &&
                            //     password_.text == strPassword) {
                            //   Navigator.pushReplacement(context,
                            //       MaterialPageRoute(builder: (BuildContext) {
                            //     // return pageBeranda();
                            //     // return pageHome();
                            //   }));
                            // } else {
                            //   setState(() {
                            //     this.error = "Username atau Password Salah!";
                            //   });
                            //   // password_.notifyListeners()
                            // }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            // width: MediaQuery.of(context).size.width,
                            // height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: Color(0xffd9d9d9),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 3,
                                  offset: Offset(0, 3), // Shadow position
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text("Buat",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sudah memiliki akun? ",
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext) => Login()));
                              },
                              child: Text(
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
