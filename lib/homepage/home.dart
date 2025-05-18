import 'package:cam_scanner/camera/camera.dart';
import 'package:cam_scanner/gallery/gallery.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Camera Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.camera_alt, size: 30),
                  ),
                  const SizedBox(height: 8),
                  const Text("Camera"),
                ],
              ),
            ),
            // Gallery Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryPage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.photo_library, size: 30),
                  ),
                  const SizedBox(height: 8),
                  const Text("Gallery"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}