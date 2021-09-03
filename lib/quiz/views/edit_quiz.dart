import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/views/add_question.dart';
import 'package:rusa4/quiz/views/edit_question.dart';
import 'package:rusa4/quiz/widget/widget.dart';

class EditQuiz extends StatefulWidget {
  final String quizIdGan;
  EditQuiz(this.quizIdGan);

  @override
  _EditQuizState createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl, quizTitle, quizDesc, quizTime;

  bool isLoading = false;
  String quizId;

  UserRusa user;
  DocumentSnapshot snapshotQuiz;

  var futureGan;

  EditQuiz() {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    user = provider.akunRusa;

    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {
        "quizImgUrl": "https://picsum.photos/seed/$quizId/500/500/?blur",
        "quizTitle": quizTitle,
        "quizDesc": quizDesc,
        "quizAuthor": user.username,
        "quizAuthorID": user.id,
        "quizKelas": user.kelas,
        "quizTime": quizTime,
      };

      databaseService.editQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EditQuestion(quizId, quizDesc)));
      });
    }
  }

  getQuizDataGan(quizIdLocal) async {
    await databaseService.getQuizDataSingle(quizIdLocal).then((snapshot) {
      print("hasil snapshot $snapshot");

      snapshotQuiz = snapshot;
      // quizTitle = snapshotQuiz.data()["quizTitle"];
      // quizDesc = snapshotQuiz.docs[0].data()["quizDesc"];

      setState(() {
        quizTitle = snapshotQuiz.data()["quizTitle"];
        quizDesc = snapshotQuiz.data()["quizDesc"];
        quizTime = snapshotQuiz.data()["quizTime"];
        quizId = widget.quizIdGan;
      });
    });
  }

  @override
  void initState() {
    // getQuizDataGan(widget.quizIdGan);
    futureGan = databaseService.getQuizDataSingle(widget.quizIdGan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hasil quizTitle $quizTitle");
    print("hasil quizDesc $quizDesc");
    return FutureBuilder(
        future: futureGan,
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return halamanLoading(context);
            case ConnectionState.done:
              if (snapshot.hasData) {
                DocumentSnapshot documents = snapshot.data;
                // List<DocumentSnapshot> docs = documents.docs;

                quizTitle = documents.data()["quizTitle"];
                quizDesc = documents.data()["quizDesc"];
                quizTime = documents.data()["quizTime"];
                quizId = widget.quizIdGan;
                return mainQuizGan(context);
              } else {
                print('data tidak ditemukan');
              }
          }
          return null;
        });

    // FutureBuilder(
    // future: FirebaseFirestore.instance.collection("Users").get(),
    // builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //   switch (snapshot.connectionState) {
    //     case ConnectionState.none:
    //     case ConnectionState.active:
    //     case ConnectionState.waiting:
    //       return halamanLoading(context);

    //     case ConnectionState.done:
    //       if (snapshot.hasData) {
    //         QuerySnapshot documents = snapshot.data;
    //         List<DocumentSnapshot> docs = documents.docs;

    //         docs.forEach((data) {
    //           cekUser = UserRusa(
    //               jenisAkun: data.get('jenisAkun'),
    //               pic: data.get('pic'),
    //               id: data.get('id'),
    //               akunDibuat: data.get('akunDibuat').toDate(),
    //               emailSiswa: data.get('emailSiswa'),
    //               password: data.get('password'),
    //               emailGuru: data.get('emailGuru'),
    //               kelas: data.get('kelas'),
    //               passwordConfirm: data.get('passwordConfirm'),
    //               username: data.get('username'));

    //           listAkunLocal[data.get('id')] = cekUser;
    //           cekUser = null;
    //         });
    //       } else {
    //         print('data tidak ditemukan');
    //       }
    //   }

    //   provider.listAkun = listAkunLocal;

    //   // return Container();
    //   return cekEmailGuru(context);
    // });
  }

  Scaffold mainQuizGan(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMainGan(context),
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 32,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = quizTitle
                  ..selection = TextSelection.fromPosition(
                      TextPosition(offset: quizTitle.length)),
                maxLines: 2,
                validator: (val) =>
                    val.isEmpty ? "Masukkan Judul Uji Pemahaman" : null,
                decoration: InputDecoration(hintText: "Judul Uji Pemahaman"),
                onChanged: (val) {
                  quizTitle = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                maxLines: 8,
                controller: TextEditingController()
                  ..text = quizDesc
                  ..selection = TextSelection.fromPosition(
                      TextPosition(offset: quizDesc.length)),
                validator: (val) => val.isEmpty ? "Masukkan Soal Cerita" : null,
                decoration: InputDecoration(hintText: "Soal Cerita"),
                onChanged: (val) {
                  quizDesc = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                maxLines: 3,
                controller: TextEditingController()
                  ..text = quizTime
                  ..selection = TextSelection.fromPosition(
                      TextPosition(offset: quizTime.length)),
                validator: (val) =>
                    val.isEmpty ? "Masukkan Durasi Soal Cerita" : null,
                decoration:
                    InputDecoration(hintText: "Durasi Soal Cerita dalam detik"),
                onChanged: (val) {
                  quizTime = val;
                },
              ),
              // Spacer(),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  EditQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Ubah Uji Pemahaman",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
