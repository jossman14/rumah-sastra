import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/widget/widget.dart';

class EditQuestion extends StatefulWidget {
  final String quizId, quizDesc;
  EditQuestion(this.quizId, this.quizDesc);

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  List pertanyaanGan = [];

  String question = "",
      option1 = "",
      option2 = "",
      option3 = "",
      option4 = "",
      waktu = "";

  QuerySnapshot questionSnaphot;

  int total;
  int cekPertanyaan = 0;

  getQuestionData() {
    databaseService.getQuestionData(widget.quizId).then((value) {
      questionSnaphot = value;

      total = questionSnaphot.docs.length;
      isLoading = false;
      pertanyaanGan = questionSnaphot.docs;
      setState(() {});
    });

    // print("Hasil hehe ${pertanyaanGan[0].data}");
    // return mainEditQuiz(context);
  }

  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question == ""
            ? questionSnaphot.docs[cekPertanyaan].data()["question"]
            : question,
        "option1": option1 == ""
            ? questionSnaphot.docs[cekPertanyaan].data()["option1"]
            : option1,
        "option2": option2 == ""
            ? questionSnaphot.docs[cekPertanyaan].data()["option2"]
            : option2,
        "option3": option3 == ""
            ? questionSnaphot.docs[cekPertanyaan].data()["option3"]
            : option3,
        "option4": option4 == ""
            ? questionSnaphot.docs[cekPertanyaan].data()["option4"]
            : option4,
        "waktu": waktu == ""
            ? questionSnaphot.docs[cekPertanyaan].data()["waktu"]
            : waktu,
      };

      String questionId = questionSnaphot.docs[cekPertanyaan].id;
      print("${widget.quizId}");
      databaseService
          .updateQuestionData(questionMap, widget.quizId, questionId)
          .then((value) {
        setState(() {
          isLoading = false;
          cekPertanyaan++;
        });

        if (cekPertanyaan >= total) {
          Navigator.pop(context);
        }
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
    }
  }

  @override
  void initState() {
    getQuestionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return mainEditQuiz(context);
  }

  Scaffold mainEditQuiz(BuildContext context) {
    return Scaffold(
      // Ibadah jangan lupa
      backgroundColor: Colors.white, //don't forget to always be grateful
      appBar: appBarMainGan(context), //Keep Calm and Stay CODING
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                widget.quizDesc,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = cekPertanyaan < total
                      ? pertanyaanGan[cekPertanyaan].data()["question"]
                      : ""
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: pertanyaanGan[cekPertanyaan]
                          .data()["question"]
                          .length)),
                maxLines: 8,
                validator: (val) => val.isEmpty ? "Masukkan pertanyaan" : null,
                decoration: InputDecoration(hintText: "Pertanyaan"),
                onChanged: (val) {
                  question = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = cekPertanyaan < total
                      ? questionSnaphot.docs[cekPertanyaan].data()["option1"]
                      : ""
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: questionSnaphot.docs[cekPertanyaan]
                          .data()["option1"]
                          .length)),
                validator: (val) => val.isEmpty ? "Pilihan jawaban 1 " : null,
                decoration: InputDecoration(
                    hintText: "Pilihan jawaban 1 (jawaban yang benar)"),
                onChanged: (val) {
                  option1 = val;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = cekPertanyaan < total
                      ? questionSnaphot.docs[cekPertanyaan].data()["option2"]
                      : ""
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: questionSnaphot.docs[cekPertanyaan]
                          .data()["option2"]
                          .length)),
                validator: (val) => val.isEmpty ? "Pilihan jawaban 2" : null,
                decoration: InputDecoration(hintText: "Pilihan jawaban 2"),
                onChanged: (val) {
                  option2 = val;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = cekPertanyaan < total
                      ? questionSnaphot.docs[cekPertanyaan].data()["option3"]
                      : ""
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: questionSnaphot.docs[cekPertanyaan]
                          .data()["option3"]
                          .length)),
                validator: (val) => val.isEmpty ? "Pilihan jawaban 3" : null,
                decoration: InputDecoration(hintText: "Pilihan jawaban 3"),
                onChanged: (val) {
                  option3 = val;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = cekPertanyaan < total
                      ? questionSnaphot.docs[cekPertanyaan].data()["option4"]
                      : ""
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: questionSnaphot.docs[cekPertanyaan]
                          .data()["option4"]
                          .length)),
                validator: (val) => val.isEmpty ? "Pilihan jawaban 4" : null,
                decoration: InputDecoration(hintText: "Pilihan jawaban 4"),
                onChanged: (val) {
                  option4 = val;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: TextEditingController()
                  ..text = cekPertanyaan < total
                      ? questionSnaphot.docs[cekPertanyaan].data()["waktu"]
                      : 0,
                validator: (val) =>
                    val.isEmpty ? "Masukkan durasi waktu" : null,
                decoration: InputDecoration(hintText: "Masukkan durasi waktu"),
                onChanged: (val) {
                  waktu = val;
                },
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      uploadQuizData();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Kirim",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadQuizData();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Ubah Pertanyaan",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
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
