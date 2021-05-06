import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/provider/uji_pemahaman_provider.dart';
import 'package:rusa4/view/feed_menulis/feed_menulis_form.dart';
import 'package:rusa4/view/uji_pemahaman/uji_pemahaman_form.dart';

class AddUjiPemahamanDialogWidget extends StatefulWidget {
  @override
  _AddUjiPemahamanDialogWidgetState createState() =>
      _AddUjiPemahamanDialogWidgetState();
}

class _AddUjiPemahamanDialogWidgetState
    extends State<AddUjiPemahamanDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah UjiPemahaman'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.delete),
        //     onPressed: () {
        //       final provider =
        //           Provider.of<UjiPemahamanProvider>(context, listen: false);
        //       provider.removeUjiPemahaman(widget.ujiPemahaman);

        //       Navigator.of(context).pop();
        //     },
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                // child: UjiPemahamanFormWidget(
                //   title: title,
                //   description: description,
                //   onChangedTitle: (title) => setState(() => this.title = title),
                //   onChangedDescription: (description) =>
                //       setState(() => this.description = description),
                //   onSavedUjiPemahaman: addUjiPemahaman,
                // ),
                child: Container()),
          ),
        ),
      ),
    );
  }

  void addUjiPemahaman() {
    List soal;
    List jawaban;
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;

    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final ujiPemahaman = UjiPemahaman(
          id: DateTime.now().toString(),
          title: title,
          soal: soal,
          jawaban: jawaban,
          createdTime: DateTime.now(),
          kelas: user[2],
          guru: 'dd');

      final provider =
          Provider.of<UjiPemahamanProvider>(context, listen: false);
      provider.addUjiPemahaman(ujiPemahaman);

      Navigator.of(context).pop();
    }
  }
}
