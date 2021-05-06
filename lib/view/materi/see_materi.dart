import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/provider/email_sign_in.dart';

import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/materi/edit_materi.dart';

class SeeMateriPage extends StatefulWidget {
  final Materi materi;

  const SeeMateriPage({Key key, @required this.materi}) : super(key: key);
  @override
  _SeeMateriPageState createState() => _SeeMateriPageState();
}

class _SeeMateriPageState extends State<SeeMateriPage> {
  String title;
  String description;

  @override
  void initState() {
    super.initState();

    title = widget.materi.title;
    description = widget.materi.description;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    return Scaffold(
      appBar: AppBar(
        title: Text('See Materi'),
        actions: user[7] == "Guru"
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            EditMateriPage(materi: widget.materi),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    final provider =
                        Provider.of<MateriProvider>(context, listen: false);
                    provider.removeMateri(widget.materi);

                    Navigator.of(context).pop();
                  },
                )
              ]
            : null,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
