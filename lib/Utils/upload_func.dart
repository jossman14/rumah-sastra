import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/api/upload_to_firebase.dart';
import 'package:rusa4/provider/get_image.dart';

class UploadHelper {
  File file;

  /// Get from gallery
  static dynamic getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      print('check path gambar');
      print(imageFile);
      return imageFile;
    }
  }

  static dynamic getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
     
      return imageFile;
    }
  }

  static dynamic uploadFile(BuildContext context, File file) async {
    if (file == null) return;

    final fileName = file;
    final destination = 'files/$fileName';

    final task = FirebaseApiUpload.uploadFile(destination, file);

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    var hasil = [urlDownload, task, file];

    return hasil;
  }

  static buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            if (percentage == '100.00')
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'Upload Selesai',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                '$percentage %',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
            );
            return null;
          } else {
            return null;
          }
        },
      );
}
