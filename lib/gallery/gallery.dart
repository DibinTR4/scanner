import 'dart:io';
import 'package:cam_scanner/selectedImage/selectedImage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  Future<void> _pickImagesAndNavigate(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.files.isNotEmpty) {
      final selectedImages = result.paths.map((path) => File(path!)).toList();

      // Navigate directly to SelectedImagePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedImagePage(images: selectedImages),
        ),
      );
    } else {
      // If user canceled, go back to home
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trigger file picking after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pickImagesAndNavigate(context);
    });

    // Return an empty Scaffold to avoid flicker or blank screen
    return const SizedBox.shrink();
  }
}
