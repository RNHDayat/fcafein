import 'package:flutter/material.dart';

class Search extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My App'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // tindakan yang dilakukan saat tombol pencarian ditekan
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Cari...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onSubmitted: (String value) {
              // tindakan yang dilakukan saat teks dicari
            },
          ),
        ),
      ),
    );
  }
}
