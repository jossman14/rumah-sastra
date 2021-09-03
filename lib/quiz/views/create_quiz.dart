import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/views/add_question.dart';
import 'package:rusa4/quiz/widget/widget.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String quizImgUrl, quizTitle, quizDesc, quizTime;

  bool isLoading = false;
  String quizId;

  UserRusa user;

  createQuiz() {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    user = provider.akunRusa;
    quizId = getRandString(16);
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
        // "quizUser" : [],
      };

      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddQuestion(quizId, quizDesc)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarMainGan(context),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              // TextFormField(
              //   validator: (val) => val.isEmpty ? "Enter Quiz Image Url" : null,
              //   decoration: InputDecoration(
              //     hintText: "Quiz Image Url (Optional)"
              //   ),
              //   onChanged: (val){
              //     quizImgUrl = val;
              //   },
              // ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                maxLines: 8,
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
                validator: (val) =>
                    val.isEmpty ? "Masukkan Durasi Soal Cerita" : null,
                decoration:
                    InputDecoration(hintText: "Durasi Soal Cerita dalam detik"),
                onChanged: (val) {
                  quizTime = val;
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Buat Uji Pemahaman",
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
