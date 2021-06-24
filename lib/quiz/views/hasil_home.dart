import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/api/materi_firebase_api.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/provider/quiz_result_provider.dart';
import 'package:rusa4/quiz/services/save_result.dart';
import 'package:rusa4/quiz/views/quiz_result_widget.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/materi/add_materi.dart';
import 'package:rusa4/view/materi/materi_widget.dart';

class HasilHome extends StatefulWidget {
  final String kelas;
  const HasilHome({Key key, @required this.kelas}) : super(key: key);

  @override
  _HasilHomeState createState() => _HasilHomeState();
}

class _HasilHomeState extends State<HasilHome> {
  UserRusa user;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akunRusa;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("RuSa"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app_rounded),
            onPressed: () {
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
              colors: [HexColor('#FF3A00'), HexColor('#FBE27E')],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List>(
          stream: SaveResultFirebaseApi.readSaveResult(widget.kelas),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return buildText(
                      'Ada yang error, mohon dicoba lagi nanti ya');
                } else {
                  final quizResults = snapshot.data;
                  print(quizResults);

                  final provider = Provider.of<QuizResultProvider>(context);
                  provider.setQuizResults(quizResults);

                  return quizResults.isEmpty
                      ? Center(
                          child: Text(
                            'TIdak ada Hasil Quiz.',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(16),
                          separatorBuilder: (context, index) =>
                              Container(height: 8),
                          itemCount: quizResults.length,
                          itemBuilder: (context, index) {
                            final quizResult = quizResults[index];

                            return QuizResultWidget(quizResult: quizResult);
                          },
                        );
                }
            }
          },
        ),
      ),
    );
  }
}

Widget buildText(String text) => Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
