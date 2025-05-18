import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class SelectedImagePage extends StatelessWidget {
  final List<File> images;

  const SelectedImagePage({super.key, required this.images});

  Future<void> createPdfAndSave(BuildContext context) async {
    final pdf = pw.Document();

    for (var imageFile in images) {
      final image = pw.MemoryImage(imageFile.readAsBytesSync());
      pdf.addPage(
        pw.Page(build: (pw.Context context) => pw.Center(child: pw.Image(image))),
      );
    }

    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied")),
      );
      return;
    }

    final downloadsDir = Directory('/storage/emulated/0/Download');
    final fileName = "converted_images_${DateTime.now().millisecondsSinceEpoch}.pdf";
    final file = File(path.join(downloadsDir.path, fileName));

    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF saved in Downloads as $fileName")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Selected Images")),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemBuilder: (context, index) {
                return Image.file(images[index], fit: BoxFit.cover);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () => createPdfAndSave(context),
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text("Convert to PDF"),
            ),
          ),
        ],
      ),
    );
  }
}
