import 'package:flutter/material.dart';

class PhotoZoomIconButton extends StatelessWidget {
  final String imageUrl;

  PhotoZoomIconButton({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: imageUrl,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.zoom_in,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
