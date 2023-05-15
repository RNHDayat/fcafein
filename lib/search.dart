import 'package:flutter/material.dart';

class Search extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('My App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // tindakan yang dilakukan saat tombol pencarian ditekan
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            decoration: InputDecoration(
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
