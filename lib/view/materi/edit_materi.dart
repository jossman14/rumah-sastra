import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/materi.dart';

import 'package:rusa4/provider/materi_provider.dart';
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
  String description;

  @override
  void initState() {
    super.initState();

    title = widget.materi.title;
    description = widget.materi.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Materi'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
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
                  description: description,
                  onChangedTitle: (title) => setState(() => this.title = title),
                  onChangedDescription: (description) =>
                      setState(() => this.description = description),
                  onSavedMateri: saveMateri,
                ),
              ),
            ),
          ),
        ),
      );

  void saveMateri() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<MateriProvider>(context, listen: false);
      provider.updateMateri(widget.materi, title, description);
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