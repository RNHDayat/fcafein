import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:powershare/OnBoard/onBoard.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgFollowingBACKUP.dart';
import 'package:powershare/pgHome.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/Answer/pgAnswer.dart';
import 'package:powershare/pgLogin.dart';
import 'package:powershare/pgNewPassword.dart';
import 'package:powershare/pgNotification.dart';
import 'package:powershare/pgRegistration.dart';
import 'package:powershare/pgUserSpace.dart';
import 'package:powershare/screens/add_Klokasi.dart';
import 'package:powershare/screens/add_Kpekerjaan.dart';
import 'package:powershare/screens/add_Kredensial.dart';
import 'package:powershare/screens/add_Kruang.dart';
import 'package:powershare/screens/add_Ktopik.dart';
import 'package:powershare/screens/add_question.dart';
import 'package:powershare/screens/add_tahutentang.dart';
import 'package:powershare/screens/audiens.dart';
import 'package:powershare/screens/audiens_post.dart';
import 'package:powershare/screens/cafein/beranda.dart';
import 'package:powershare/screens/edit_Nama.dart';
import 'package:powershare/screens/edit_biografi.dart';
import 'package:powershare/screens/edit_profile.dart';
import 'package:powershare/screens/screen_ruang.dart';
import 'package:powershare/screens/setting_akun.dart';
import 'package:powershare/screens/setting_screen.dart';
import 'package:powershare/screens/test.dart';
import 'package:powershare/screens/ubah_sandi-1.dart';
import 'package:powershare/screens/user_akun.dart';
import 'package:powershare/screens/user_follower.dart';
import 'package:powershare/search.dart';
import 'package:powershare/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Answer/pgMessage.dart';
import 'Answer/pgQuestion.dart';
import 'Answer/pgUserSpace.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String token = '';
  getToken() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    setState(() {
      token = data[0].token;
    });
    print(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          theme: ThemeData(primarySwatch: Colors.lightBlue),
          // home: const SplashScreen(),
          home: token.isEmpty ? Login() : HomeCafein(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
