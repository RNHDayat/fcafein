import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/pgRegistration.dart';
import 'package:pointycastle/export.dart' as pc;

import 'model/database.dart';
import 'model/dbhelper.dart';
import 'model/userToken.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? rememberMe = false;
  void _onRememberMeChanged(bool? newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe == true) {
          print("clicked");
        } else {
          // TODO: Forget the user
        }
      });
  TextEditingController username_ = TextEditingController();
  TextEditingController password_ = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passwordController =
      TextEditingController(text: 'harusbisa1');
  // the following controller have a default value
  TextEditingController iterationenController =
      TextEditingController(text: '999');

  TextEditingController outputController = TextEditingController();
  TextEditingController encryptedRequestController = TextEditingController();

  String txtDescription =
      'AES-256 CBC encryption, the key is derived from a password using PBKDF2 (selectable iterations).';

  String _returnJson(String data) {
    var parts = data.split(':');
    var algorithm = parts[0];
    var iterations = parts[1];
    var salt = parts[2];
    var iv = parts[3];
    var ciphertext = parts[4];
    var gcmTag = parts[5];

    JsonEncryption jsonEncryption = JsonEncryption(
        algorithm: algorithm,
        iterations: iterations,
        salt: salt,
        iv: iv,
        ciphertext: ciphertext,
        gcmTag: gcmTag);

    String encryptionResult = jsonEncode(jsonEncryption);
    // make it pretty
    var object = json.decode(encryptionResult);
    var luaran = {
      'ciphertext': object["ciphertext"],
      'iv': object["iv"],
      'salt': object["salt"],
      'iterations': object["iterations"]
    };
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    print(stringToBase64.encode(jsonEncode(luaran)));
    setState(() {
      //set state yang dikirim ke server
      encryptedRequestController.text =
          stringToBase64.encode(jsonEncode(luaran));
    });
    var prettyEncryptionResult2 =
        const JsonEncoder.withIndent('  ').convert(object);

    return encryptedRequestController.text;
  }

  bool visiblePassword = false;
  String? username, pasword;

  Future<void> saveToken(id, token) async {
    final _db = DBhelper();
    final newToken = User(id: int.parse(id), token: token);
    await _db.insertToken(newToken);
    print(await _db.getToken());
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
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    // padding: EdgeInsets.all(10),
                    child: Form(
                      key: _formKey,
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
                              "Masuk",
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

                          TextFormField(
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 10,
                          ),
                          TextFormField(
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 10,
                          ),

                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      builder: (BuildContext) =>
                                          Registration()));
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
                              // width: MediaQuery.of(context).size.width,
                              // height: MediaQuery.of(context).size.height * 0.05,
                              padding: EdgeInsets.all(10),
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
                                child: Text("Buat Akun",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // lineleftRUL (34:128)
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Color(0xffd9d9d9),
                                ),
                              ),
                              Container(
                                // atau99S (34:126)

                                child: Text(
                                  'Atau',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff5f5b5b),
                                  ),
                                ),
                              ),
                              Container(
                                // lineleftRUL (34:128)
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 1,
                                decoration: BoxDecoration(
                                  color: Color(0xffd9d9d9),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              // If all validators of the form's fields are valid.
                              if (_formKey.currentState!.validate()) {
                                String plaintext = username_.text;
                                String plaintext2 = password_.text;
                                String password = passwordController.text;
                                String iterations = iterationenController.text;
                                String output = aesCbcIterPbkdf2EncryptToBase64(
                                    password, iterations, plaintext);
                                String output2 =
                                    aesCbcIterPbkdf2EncryptToBase64(
                                        password, iterations, plaintext2);
                                String _formdata = 'AES-256 CBC PBKDF2' +
                                    ':' +
                                    iterations +
                                    ':' +
                                    output +
                                    ':Not Used'; // empty gcm tag
                                String _formdata2 = 'AES-256 CBC PBKDF2' +
                                    ':' +
                                    iterations +
                                    ':' +
                                    output2 +
                                    ':Not Used'; // empty gcm tag
                                String jsonOutput = _returnJson(_formdata);
                                String jsonOutput2 = _returnJson(_formdata2);
                                // Map<String, dynamic> map = json.decode(jsonOutput);
                                // print("salt : "+map["salt"]);
                                Map<String, dynamic> map = {
                                  "username": jsonOutput,
                                  "password": jsonOutput2
                                };
                                // print(jsonOutput);
                                // print(map["username"].runtimeType);
                                LoginAuth.login(
                                        map["username"], map["password"])
                                    .then((value) {
                                  if (value != null) {
                                    print("token : " + value.id.toString());
                                    print("token : " + value.token.toString());
                                    saveToken(value.id, value.token);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBar(currentIndex: 0),
                                        ));
                                  } else {
                                    print('ada salah');
                                  }
                                });
                                // outputController.text = jsonOutput;
                              } else {
                                print("Form is not valid");
                              }
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
                                child: Text("Masuk",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff000000),
                                    )),
                              ),
                            ),
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

String aesCbcIterPbkdf2EncryptToBase64(
    String password, String iterations, String plaintext) {
  try {
    var plaintextUint8 = createUint8ListFromString(plaintext);
    var passphrase = createUint8ListFromString(password);
    final PBKDF2_ITERATIONS = int.tryParse(iterations);
    final salt = generateSalt32Byte();
    pc.KeyDerivator derivator =
        new pc.PBKDF2KeyDerivator(new pc.HMac(new pc.SHA256Digest(), 64));
    pc.Pbkdf2Parameters params =
        new pc.Pbkdf2Parameters(salt, PBKDF2_ITERATIONS!, 32);
    derivator.init(params);
    final key = derivator.process(passphrase);
    final iv = generateRandomIv();
    final pc.CBCBlockCipher cipher =
        new pc.CBCBlockCipher(new pc.AESFastEngine());
    pc.ParametersWithIV<pc.KeyParameter> cbcParams =
        new pc.ParametersWithIV<pc.KeyParameter>(new pc.KeyParameter(key), iv);
    pc.PaddedBlockCipherParameters<pc.ParametersWithIV<pc.KeyParameter>, Null>
        paddingParams = new pc.PaddedBlockCipherParameters<
            pc.ParametersWithIV<pc.KeyParameter>, Null>(cbcParams, null);
    pc.PaddedBlockCipherImpl paddingCipher =
        new pc.PaddedBlockCipherImpl(new pc.PKCS7Padding(), cipher);
    paddingCipher.init(true, paddingParams);
    final ciphertext = paddingCipher.process(plaintextUint8);
    final saltBase64 = base64Encoding(salt);
    final ivBase64 = base64Encoding(iv);
    final ciphertextBase64 = base64Encoding(ciphertext);
    return saltBase64 + ':' + ivBase64 + ':' + ciphertextBase64;
  } catch (error) {
    return 'Encryption error';
  }
}

Uint8List generateSalt32Byte() {
  final _sGen = Random.secure();
  final _seed =
      Uint8List.fromList(List.generate(32, (n) => _sGen.nextInt(255)));
  pc.SecureRandom sec = pc.SecureRandom("Fortuna")
    ..seed(pc.KeyParameter(_seed));
  return sec.nextBytes(32);
}

Uint8List generateRandomIv() {
  final _sGen = Random.secure();
  final _seed =
      Uint8List.fromList(List.generate(32, (n) => _sGen.nextInt(255)));
  pc.SecureRandom sec = pc.SecureRandom("Fortuna")
    ..seed(pc.KeyParameter(_seed));
  return sec.nextBytes(16);
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

String base64Encoding(Uint8List input) {
  return base64.encode(input);
}

Uint8List base64Decoding(String input) {
  return base64.decode(input);
}

class JsonEncryption {
  JsonEncryption({
    required this.algorithm,
    this.iterations,
    this.salt,
    this.iv,
    required this.ciphertext,
    this.gcmTag,
  });

  final String algorithm;
  final String? iterations;
  final String? salt;
  final String? iv;
  final String ciphertext;
  final String? gcmTag;

  Map toJson() => {
        'algorithm': algorithm,
        'iterations': iterations,
        'salt': salt,
        'iv': iv,
        'ciphertext': ciphertext,
        'gcmTag': gcmTag,
      };
}
