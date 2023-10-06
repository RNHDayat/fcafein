import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:powershare/components/showToast.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:powershare/screens/setting_screen.dart';
import 'package:powershare/screens/ubah_sandi-1.dart';

class UbahSandi2 extends StatefulWidget {
  const UbahSandi2({super.key});

  @override
  State<UbahSandi2> createState() => _UbahSandi2State();
}

class _UbahSandi2State extends State<UbahSandi2> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;
  bool _iisObscure = true;

  bool isPasswordValid(String password) {
    final RegExp uppercaseRegex = RegExp(r'[A-Z]');
    final RegExp digitRegex = RegExp(r'[0-9]');

    if (password.length < 6 ||
        !uppercaseRegex.hasMatch(password) ||
        !digitRegex.hasMatch(password)) {
      return false;
    }

    return true;
  }

  String? confirmPasswordErrorText;
  String? passwordErrorText;

  _changePassword(String password) async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      UpdatePassword.changePassword(data[0].token, password);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UbahSandi()));
                  },
                  child: const Text("Batal"),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (newPasswordController.text ==
                          confirmPasswordController.text) {
                        if (isPasswordValid(newPasswordController.text)) {
                          _changePassword(newPasswordController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingScreen()),
                          );
                        } else {
                          ShowToast.showErrorSnackbar(
                            context,
                            'Password harus terdiri dari huruf besar, angka, dan minimal 6 karakter',
                          );
                        }
                      } else {
                        ShowToast.showErrorSnackbar(
                          context,
                          'Password harus sama',
                        );
                      }
                    } else {
                      ShowToast.showErrorSnackbar(
                        context,
                        'Pastikan Anda Mengisi Password',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Masukkan Password",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Untuk alasan keamanan, silahkan masukkan sandi baru Anda untuk mengubahnya.",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Kata Sandi Baru",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: _isObscure,
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          passwordErrorText = 'Password harus diisi';
                        } else if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                            .hasMatch(value)) {
                          passwordErrorText =
                              'Gunakan kombinasi huruf besar, huruf kecil, dan angka dan minimun 8 huruf.';
                        } else {
                          passwordErrorText = null;
                        }
                      });
                    },
                    // (r'^(?=.*[A-Z])(?=.*\d).+$')
                    // r'^
                    //   (?=.*[A-Z])       // should contain at least one upper case
                    //   (?=.*[a-z])       // should contain at least one lower case
                    //   (?=.*?[0-9])      // should contain at least one digit
                    //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
                    //   .{8,}             // Must be at least 8 characters in length
                    //$
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kata Sandi Baru tidak boleh kosong';
                      }
                      if (!RegExp(r'^(?=.*[A-Z])(?=.*[0-9])').hasMatch(value)) {
                        return 'Password harus mengandung setidaknya satu huruf besar dan satu angka';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      errorText: passwordErrorText,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          "Konfirmasi Sandi Baru",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: _iisObscure,
                    onChanged: (value) {
                      if (value != newPasswordController.text) {
                        setState(() {
                          confirmPasswordErrorText =
                              'Konfirmasi sandi tidak sesuai.';
                        });
                      } else {
                        setState(() {
                          confirmPasswordErrorText = null;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_iisObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _iisObscure = !_iisObscure;
                          });
                        },
                      ),
                      errorText: confirmPasswordErrorText,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
