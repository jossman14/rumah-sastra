import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/upload_func.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/get_image.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/materi/materi_form.dart';

class AddMateriDialogWidget extends StatefulWidget {
  @override
  _AddMateriDialogWidgetState createState() => _AddMateriDialogWidgetState();
}

class _AddMateriDialogWidgetState extends State<AddMateriDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String linkVideo = '';
  String description = '';
  String imagegan = '';
  String link = '';
  List url;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetImageProvider>(context, listen: false);

    imagegan = provider.getImage;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Materi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: MateriFormWidget(
                title: title,
                linkVideo: linkVideo,
                description: description,
                imagegan: imagegan,
                link: link,

                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedlinkVideo: (linkVideo) =>
                    setState(() => this.linkVideo = linkVideo),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onChangedimagegan: (imagegan) =>
                    setState(() => this.imagegan = imagegan),
                onChangedlink: (link) => setState(() => this.link = link),
                onSavedMateri: addMateri,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addMateri() {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;

    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final materi = Materi(
        id: DateTime.now().toString(),
        linkVideo: linkVideo,
        title: title,
        description: description,
        createdTime: DateTime.now(),
        modifTime: DateTime.now(),
        writer: user[3],
        kelas: user[2],
        imagegan: imagegan,
        link: link,
        userID: user[9],
      );

      final provider = Provider.of<MateriProvider>(context, listen: false);
      provider.addMateri(materi);

      Navigator.of(context).pop();
    }
  }
}
