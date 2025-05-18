import 'dart:io';
import 'package:cam_scanner/selectedImage/selectedImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _capturedImages = [];

  Future<void> _captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _capturedImages.add(File(pickedFile.path));
      });
    }
    // If user cancels, just do nothing, stay on page
  }

  void _finishCapturing() {
    if (_capturedImages.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedImagePage(images: _capturedImages),
        ),
      );
    } else {
      // Optionally show a message: "No images captured yet"
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture at least one image')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Optionally open camera on page load automatically:
    Future.delayed(Duration.zero, _captureImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Images'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _finishCapturing,
            tooltip: 'Done',
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _capturedImages.isEmpty
                  ? const Text('No images captured yet')
                  : const Text('Keep capturing images or press Done'),
            ),
          ),
          Container(
            height: 110,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _capturedImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Image.file(
                    _capturedImages[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Capture Image'),
              onPressed: _captureImage,
            ),
          ),
        ],
      ),
    );
  }
}
