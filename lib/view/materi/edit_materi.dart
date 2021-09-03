import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/provider/get_image.dart';

import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/materi/materi_form.dart';
import 'package:rusa4/view/materi/see_materi.dart';

class EditMateriPage extends StatefulWidget {
  final Materi materi;

  const EditMateriPage({Key key, @required this.materi}) : super(key: key);
  @override
  _EditMateriPageState createState() => _EditMateriPageState();
}

class _EditMateriPageState extends State<EditMateriPage> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String linkVideo;
  String description;
  String imagegan;
  String link;

  String imageganNew;

  @override
  void initState() {
    super.initState();

    title = widget.materi.title;
    description = widget.materi.description;
    linkVideo = widget.materi.linkVideo;
    imagegan = widget.materi.imagegan;

    link = widget.materi.link;
    imageganNew = "";
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<GetImageProvider>(context, listen: false);

    // imagegan = provider.getImage;

    // print("provider get image ${provider.getImage}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Materi'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              playSound();
              final provider =
                  Provider.of<MateriProvider>(context, listen: false);
              provider.removeMateri(widget.materi);

              Navigator.of(context).pop();
            },
          )
        ],
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
                onSavedMateri: saveMateri,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveMateri() {
    final isValid = _formKey.currentState.validate();

    final providerImage = Provider.of<GetImageProvider>(context, listen: false);

    imagegan = providerImage.getImage;

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<MateriProvider>(context, listen: false);
      provider.updateMateri(
          widget.materi, title, description, imagegan, linkVideo, link);
      // ubah == "edit"
      //     ? provider.updateMateri(widget.materi, title, description)
      //     : provider.addMateri(widget.materi);

      // Navigator.of(context).pop();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => SeeMateriPage(materi: widget.materi)));
    }
  }
}
