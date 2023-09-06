import 'package:flutter/material.dart';

class PageNotification extends StatefulWidget {
  const PageNotification({super.key});

  @override
  State<PageNotification> createState() => _NotificationState();
}

class _NotificationState extends State<PageNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Semua Notifikasi Terbaca",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      child: const Row(
                        children: [
                          Icon(Icons.tune, color: Colors.grey),
                          SizedBox(width: 10),
                          Icon(Icons.settings_outlined, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                // color: Colors.red,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngomongin IT · Dijawab oleh Salim · 3 jam yang lalu",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text("Apa peran teknologi di lingkungan?",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
