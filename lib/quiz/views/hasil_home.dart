import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/services/save_result.dart';
import 'package:rusa4/quiz/views/quiz_result_widget.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/materi/add_materi.dart';
import 'package:rusa4/view/materi/materi_widget.dart';

class HasilHome extends StatefulWidget {
  final String kelas, idQuiz;
  const HasilHome({Key key, @required this.kelas, @required this.idQuiz})
      : super(key: key);

  @override
  _HasilHomeState createState() => _HasilHomeState();
}

class _HasilHomeState extends State<HasilHome> {
  UserRusa user;
  QuerySnapshot quizStreamUser;
  DatabaseService databaseService = new DatabaseService();
  List temp = [];

  var cekIdQuiz;
  var cekQuizGuru;

  cekUser(user) {
    for (var i = 0; i < utama.length; i++) {
      if (utama[i][0] == user) {
        temp.add(utama[i][1]);
      }
    }

    print("temp $temp");
    return true;
  }

  Map streamUser = new Map();
  List streamGan = [];
  List utama = [];
  @override
  void initState() {
    databaseService.getUserData().then((value) {
      quizStreamUser = value;

      for (var item in quizStreamUser.docs) {
        streamGan.add(item.id);
        streamGan.add(item.data()["quizId"]);
        streamGan.add(item.data()["user"]);
        streamGan.add(item.data()["quizGuru"]);
        // streamUser["${item.data()["quizId"]}"] = item.data()["user"];

        utama.add(streamGan);
        streamGan = [];
      }

      print("hasill map $utama");
      print("hasill list $streamGan");
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // databaseService.getUserData().then((value) {
    //   quizStreamUser = value;

    //   for (var item in quizStreamUser.docs) {
    //     streamGan.add(item.id);
    //     streamGan.add(item.data()["quizId"]);
    //     streamGan.add(item.data()["user"]);
    //     streamGan.add(item.data()["quizGuru"]);
    //     // streamUser["${item.data()["quizId"]}"] = item.data()["user"];

    //     utama.add(streamGan);
    //     streamGan = [];
    //   }

    //   print("hasill map dispose $utama");
    //   print("hasill list dispose  $streamGan");
    //   setState(() {});
    // });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akunRusa;

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
          stream: SaveResultFirebaseApi.readSaveResult(widget.kelas),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                print("errrorr quizzzz ${snapshot}");
                if (snapshot.hasError) {
                  return buildText(
                      'Ada yang error, mohon dicoba lagi nanti ya');
                } else {
                  final quizResults = snapshot.data;

                  final provider = Provider.of<QuizResultProvider>(context);
                  provider.setQuizResults(quizResults);
                  List cekHasilQuiz = [];

                  for (var item in quizResults) {
                    if (item.quizId == widget.idQuiz) {
                      cekHasilQuiz.add(item);
                    }
                  }

                  // print("hasilCekQuiz ${cekHasilQuiz[0].id}");
                  return cekHasilQuiz.isEmpty ||
                          cekHasilQuiz == null ||
                          cekHasilQuiz.length == 0
                      ? Center(
                          child: Text(
                            'TIdak ada hasil penilaian.',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(16),
                          separatorBuilder: (context, index) =>
                              Container(height: 8),
                          itemCount: cekHasilQuiz.length,
                          itemBuilder: (context, index) {
                            final quizResult = cekHasilQuiz[index];
                            var cekIdUser = "d";
                            // for (var item in quizStreamUser.docs) {
                            //   if (quizResult.userId == item.data()["user"]) {
                            //     cekIdUser = item.id;
                            //     print("cek iddd ${item.id}");
                            //   }
                            // }

                            for (var i = 0; i < utama.length; i++) {
                              if (utama[i][2] == quizResult.userId) {
                                cekIdUser = utama[i][2];
                                cekIdQuiz = utama[i][0];
                                cekQuizGuru = utama[i][3];
                              }
                            }
                            print("cek hasil cekiduser $cekIdUser");
                            print("cek hasil idResult ${quizResult}");
                            return quizResult.quizId == widget.idQuiz
                                ? QuizResultWidget(
                                    quizResult: quizResult,
                                    hidden: true,
                                    idResult: quizResult.id,
                                    cekIdUser: cekIdUser,
                                    cekIdQuiz: cekIdQuiz,
                                    cekQuizGuru: cekQuizGuru,
                                  )
                                : QuizResultWidget(
                                    quizResult: quizResult,
                                    hidden: false,
                                    idResult: quizResult.id,
                                    cekIdUser: cekIdUser,
                                    cekIdQuiz: cekIdQuiz,
                                    cekQuizGuru: cekQuizGuru,
                                  );
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
