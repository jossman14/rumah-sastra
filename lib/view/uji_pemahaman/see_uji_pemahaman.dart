import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/model/uji_pemahaman.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/provider/uji_pemahaman_provider.dart';
import 'package:rusa4/view/feed_menulis/edit_feed_menulis.dart';
import 'package:rusa4/view/uji_pemahaman/edit_uji_pemahaman.dart';

class SeeUjiPemahamanPage extends StatefulWidget {
  final UjiPemahaman ujiPemahaman;

  const SeeUjiPemahamanPage({Key key, @required this.ujiPemahaman})
      : super(key: key);
  @override
  _SeeUjiPemahamanPageState createState() => _SeeUjiPemahamanPageState();
}

class _SeeUjiPemahamanPageState extends State<SeeUjiPemahamanPage> {
  String title;
  String jawaban;

  @override
  void initState() {
    super.initState();

    title = widget.ujiPemahaman.title;
    // jawaban = widget.ujiPemahaman.jawaban;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    return Scaffold(
      appBar: AppBar(
        title: Text('See UjiPemahaman'),
        actions: user[7] == "Guru"
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditUjiPemahamanPage(
                            ujiPemahaman: widget.ujiPemahaman),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    final provider = Provider.of<UjiPemahamanProvider>(context,
                        listen: false);
                    provider.removeUjiPemahaman(widget.ujiPemahaman);

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
                    jawaban,
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
