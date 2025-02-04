import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () => Navigator.pop(context), // Close on tap
          child: Center(
            child: PhotoView(
              imageProvider: AssetImage(imagePath),
              backgroundDecoration: BoxDecoration(color: Colors.white),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      ),
    );
  }
}