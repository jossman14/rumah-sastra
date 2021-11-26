import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/api/materi_firebase_api.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/materi/add_materi.dart';
import 'package:rusa4/view/materi/materi_widget.dart';

class ViewMateri extends StatefulWidget {
  final String kelas;
  const ViewMateri({Key key, @required this.kelas}) : super(key: key);

  @override
  _ViewMateriState createState() => _ViewMateriState();
}

class _ViewMateriState extends State<ViewMateri> {
  @override
  void initState() {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Rumah Sastra"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              playSound();
              // Constants.prefs.setBool("loggedIn", false);
              notSet();
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AuthPage()));
              //
            },
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#2980b9'), HexColor('#d35400')],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List>(
          stream: MateriFirebaseApi.readMateris(widget.kelas),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return buildText(
                      'Ada yang error, mohon dicoba lagi nanti ya');
                } else {
                  final materis = snapshot.data;

                  final provider = Provider.of<MateriProvider>(context);
                  provider.setMateris(materis);

                  return materis.isEmpty
                      ? Center(
                          child: Text(
                            'Tidak ada materi',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(16),
                          separatorBuilder: (context, index) =>
                              Container(height: 8),
                          itemCount: materis.length,
                          itemBuilder: (context, index) {
                            final materi = materis[index];

                            return MateriWidget(materi: materi);
                          },
                        );
                }
            }
          },
        ),
      ),
      floatingActionButton: user[7] == "Guru" && user[2] == widget.kelas
          ? FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.black,
              onPressed: () {
                playSound();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMateriDialogWidget()));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
