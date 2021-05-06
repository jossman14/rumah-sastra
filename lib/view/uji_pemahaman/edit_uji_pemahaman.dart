import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/provider/uji_pemahaman_provider.dart';
import 'package:rusa4/view/feed_menulis/feed_menulis_form.dart';
import 'package:rusa4/view/uji_pemahaman/uji_pemahaman_form.dart';

class EditUjiPemahamanPage extends StatefulWidget {
  final UjiPemahaman ujiPemahaman;

  const EditUjiPemahamanPage({Key key, @required this.ujiPemahaman})
      : super(key: key);
  @override
  _EditUjiPemahamanPageState createState() => _EditUjiPemahamanPageState();
}

class _EditUjiPemahamanPageState extends State<EditUjiPemahamanPage> {
  final _formKey = GlobalKey<FormState>();

  List title;
  String description;

  @override
  void initState() {
    super.initState();

    // title = widget.ujiPemahaman.title;
    // description = widget.ujiPemahaman.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit UjiPemahaman'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<UjiPemahamanProvider>(context, listen: false);
                provider.removeUjiPemahaman(widget.ujiPemahaman);

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
                child: Container(),
                // child: UjiPemahamanFormWidget(
                //   title: title,
                //   description: description,
                //   onChangedTitle: (title) => setState(() => this.title = title),
                //   onChangedDescription: (description) =>
                //       setState(() => this.description = description),
                //   onSavedUjiPemahaman: saveUjiPemahaman,
                // ),
              ),
            ),
          ),
        ),
      );

  void saveUjiPemahaman() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider =
          Provider.of<UjiPemahamanProvider>(context, listen: false);
      // provider.updateUjiPemahaman(widget.ujiPemahaman, title, title, title);
      // ubah == "edit"
      //     ? provider.updateUjiPemahaman(widget.ujiPemahaman, title, description)
      //     : provider.addUjiPemahaman(widget.ujiPemahaman);

      Navigator.of(context).pop();
    }
  }
}
