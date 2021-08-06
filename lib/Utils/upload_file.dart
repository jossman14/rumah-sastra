import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/button_widget.dart';
import 'package:rusa4/api/upload_to_firebase.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/get_image.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  UploadTask task;
  File file;

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file.path) : 'Belum ada file terpilih';

    return Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Upload Gambar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            SizedBox(height: 20),
            ButtonWidget(
              text: 'Pilih Gambar',
              icon: Icons.attach_file,
              onClicked: () {
                selectFile(context);
              },
            ),
            SizedBox(height: 8),
            fileName == 'Belum ada file terpilih'
                ? Text(
                    fileName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )
                : Image.file(
                    File(file.path),
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: 20),
            task != null ? buildUploadStatus(task) : Container(),
          ],
        ),
      ),
    );
  }

  Future selectFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));

    if (file != null) {
      uploadFile(context);
    }
  }

  Future uploadFile(BuildContext context) async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApiUpload.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    final provider = Provider.of<GetImageProvider>(context, listen: false);

    provider.getImage = urlDownload;
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            if (percentage == '100.00') {
              final provider = Provider.of<GetImageProvider>(context);

              provider.selesai = true;
              return Text(
                'Upload Selesai',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              );
            }

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
