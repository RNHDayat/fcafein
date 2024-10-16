import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:powershare/bottomNavBar.dart';
import 'package:powershare/model/database.dart';
import 'package:powershare/model/dbhelper.dart';
import 'package:powershare/pgLogin.dart';
import 'package:powershare/screens/cafein/media.dart';
import 'package:powershare/screens/cafein/regulasi.dart';
import 'package:powershare/splashScreen.dart';

class HomeCafein extends StatefulWidget {
  const HomeCafein({super.key});

  @override
  State<HomeCafein> createState() => _HomeCafeinState();
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class _HomeCafeinState extends State<HomeCafein> {
  @override
  void initState() {
    setupFlutterNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        await showFlutterNotification;
        showFlutterNotification(message);
      }
    });
    //Ketika Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await showFlutterNotification;
        showFlutterNotification(message);
      }
    });
    // if (!kIsWeb){
    //   await setupFlutterNotifications();
    // }
    super.initState();
    cekUser();
  }

  cekUser() async {
    final _db = DBhelper();
    var data = await _db.getToken();
    print("nih: " + data[0].token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/logo/ic_cafein.png"),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "CafeIN",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Colors.white,
          //     Colors.blue.shade200,
          //   ],
          // ),
          color: Colors.grey[300],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Regulasi(),
                            ),
                          )),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          // // boxShadow: [
                          // //   BoxShadow(
                          // //     color: Colors.black.withOpacity(
                          // //         0.2), // Warna dan opasitas bayangan
                          // //     offset: Offset(0, 2), // Geser bayangan
                          // //     blurRadius: 4, // Radius blur
                          // //     spreadRadius: 1, // Radius penyebaran
                          // //   ),
                          // ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Regulasi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            Image.asset(
                              "assets/logo/ic_reg.png",
                              height: 50,
                              width: 50,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Media(),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(
                        //         0.2), // Warna dan opasitas bayangan
                        //     offset: Offset(0, 2), // Geser bayangan
                        //     blurRadius: 4, // Radius blur
                        //     spreadRadius: 1, // Radius penyebaran
                        //   ),
                        // ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Media",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            "assets/logo/ic_media.png",
                            height: 75,
                            width: 75,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(currentIndex: 0),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(
                          //         0.2), // Warna dan opasitas bayangan
                          //     offset: Offset(0, 2), // Geser bayangan
                          //     blurRadius: 4, // Radius blur
                          //     spreadRadius: 1, // Radius penyebaran
                          //   ),
                          // ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "PowerShare",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/logo/logos.png",
                              height: 50,
                              width: 50,
                              fit: BoxFit.fitWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
