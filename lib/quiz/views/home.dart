import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/audio_provider.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/views/cerita_page.dart';
import 'package:rusa4/quiz/views/create_quiz.dart';
import 'package:rusa4/quiz/views/edit_quiz.dart';
import 'package:rusa4/quiz/views/quiz_play.dart';
import 'package:rusa4/quiz/widget/widget.dart';
import 'package:rusa4/view/audioGan.dart';

class HomeQuiz extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeQuiz> {
  Stream quizStream;
  QuerySnapshot quizStreamUser;
  DatabaseService databaseService = new DatabaseService();
  // Map allAkun;
  UserRusa user;

  // Map quizListGan;
  // Map quizLocal;

  List temp;

  Widget quizList() {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    user = provider.akunRusa;

    final providerCekSoal = Provider.of<AudioProvider>(context);

    providerCekSoal.resetJawaban = true;
    providerCekSoal.resetSoalProvider = 0;
    providerCekSoal.resetcorrectAnswer = "reset";
    providerCekSoal.resetoptionSelected = "reset";
    var quizListGan = new Map();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: quizStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  snapshot.data.documents.forEach((data) {
                    quizListGan[data.documentID] = {
                      "kelas": data.data()['quizKelas'],
                      "quizTime": data.data()['quizTime'],
                      "imageUrl": data.data()['quizImgUrl'],
                      "title": data.data()['quizTitle'],
                      "authorId": data.data()['quizAuthorID'],
                      "description": data.data()['quizDesc'],
                      "id": data.documentID,
                    };
                  });

                  provider.quizList = quizListGan;
                  // print("quizListGan ${quizListGan.length}");
                  List cekKelas = [];

                  for (var item in snapshot.data.documents) {
                    if (item.data()['quizKelas'] == user.kelas) {
                      cekKelas.add(item);
                    }
                  }
                  // print("cek jumlah kelas ${cekKelas.length}");
                  return snapshot.data == null
                      ? Container()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: cekKelas.length,
                          itemBuilder: (context, index) {
                            var cek = cekUser(cekKelas[index].documentID);
                            // print("hehe ${temp}");
                            // print("iddd ${cekKelas[index].documentID}");
                            // print(
                            //     "temp.contains(user.id) = ${temp.contains(user.id)}");
                            // print(
                            //     "cek == temp.contains(user.id) --> ${cek == temp.contains(user.id)}");
                            // print(
                            //     "cekKelas[index].data()['quizKelas'] ==   user.kelas --> ${cekKelas[index].data()['quizKelas'] == user.kelas}");
                            // print(
                            //     "cekKelas[index].data()['quizKelas'] ==   user.kelas --> ${cekKelas[index].data()['quizTitle']}");
                            return (cekKelas[index].data()['quizKelas'] ==
                                        user.kelas) &&
                                    temp.contains(user.id)
                                ? QuizTile(
                                    quizTime:
                                        cekKelas[index].data()['quizTime'],
                                    noOfQuestions: cekKelas.length,
                                    imageUrl:
                                        cekKelas[index].data()['quizImgUrl'],
                                    title: cekKelas[index].data()['quizTitle'],
                                    description:
                                        cekKelas[index].data()['quizDesc'],
                                    authorId:
                                        cekKelas[index].data()['quizAuthorID'],
                                    kelas: cekKelas[index].data()['quizKelas'],
                                    id: cekKelas[index].documentID,
                                    hidden: false,
                                    kelasPilih: user.kelas,
                                  )
                                : QuizTile(
                                    quizTime:
                                        cekKelas[index].data()['quizTime'],
                                    noOfQuestions: cekKelas.length,
                                    imageUrl:
                                        cekKelas[index].data()['quizImgUrl'],
                                    title: cekKelas[index].data()['quizTitle'],
                                    description:
                                        cekKelas[index].data()['quizDesc'],
                                    authorId:
                                        cekKelas[index].data()['quizAuthorID'],
                                    kelas: cekKelas[index].data()['quizKelas'],
                                    id: cekKelas[index].documentID,
                                    hidden: true,
                                    kelasPilih: user.kelas,
                                  );
                          });
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  cekUser(idDoc) {
    temp = [];
    for (var i = 0; i < utama.length; i++) {
      if (utama[i][0] == idDoc) {
        // temp.add(utama[i][0]);
        temp.add(utama[i][1]);
      }
    }

    if (temp == []) {
      return true;
    }

    print("temp $temp");
    return false;
  }

  Map streamUser = new Map();
  List streamGan = [];
  List utama = [];
  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });
    databaseService.getUserData().then((value) {
      quizStreamUser = value;

      for (var item in quizStreamUser.docs) {
        streamGan.add(item.data()["quizId"]);
        streamGan.add(item.data()["user"]);
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
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      backgroundColor: Colors.white,
      appBar: appBarMainGan(context),
      body: quizList(),
      floatingActionButton: user.jenisAkun == "Guru"
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                playSound();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateQuiz()));
              },
            )
          : null,
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl,
      title,
      id,
      description,
      authorId,
      kelas,
      kelasPilih,
      quizTime;
  final int noOfQuestions;
  final bool hidden;

  Map allAkun;

  List user;
  var userRusa;

  QuizTile({
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.id,
    @required this.authorId,
    @required this.kelas,
    @required this.noOfQuestions,
    @required this.hidden,
    @required this.kelasPilih,
    @required this.quizTime,
  });

  void deleteQuiz(BuildContext context, String quizId) async {
    DatabaseService databaseService = new DatabaseService();

    await databaseService.deleteQuizData(quizId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    allAkun = provider.listAkun;
    user = provider.akun;
    userRusa = provider.akunRusa;
    print("quizHome $id");
    return user[9] == authorId
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                key: Key(id),
                actions: [
                  IconSlideAction(
                    color: Colors.green,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditQuiz(id),
                      ),
                    ),
                    caption: 'Ubah',
                    icon: Icons.edit,
                  )
                ],
                secondaryActions: [
                  IconSlideAction(
                    color: Colors.red,
                    caption: 'Hapus',
                    onTap: () {
                      deleteQuiz(context, id);
                    },
                    icon: Icons.delete,
                  )
                ],
                child: mainQuiz(context),
              ),
            ),
          )
        : mainQuiz(context);
  }

  Visibility mainQuiz(BuildContext context) {
    return Visibility(
      visible: cekGuru(hidden, allAkun, userRusa),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CeritaPage(id, title, description, quizTime)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        color: Colors.black26,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                color: Colors.orange,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          allAkun[authorId].username,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              kelas,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  cekGuru(hidden, allAkun, userRusa) {
    if (userRusa.id == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3' && hidden) {
      return true;
    } else {
      if (hidden && allAkun[authorId].emailGuru == userRusa.emailGuru ||
          (authorId == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3' && hidden)) {
        return true;
      } else {
        return false;
      }
    }

    // userRusa.emailGuru == allAkun[materi.userID].emailGuru ||
    //           materi.userID == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3'
  }
}
