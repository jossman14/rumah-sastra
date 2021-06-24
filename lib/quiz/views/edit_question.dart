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

  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";

  QuerySnapshot questionSnaphot;

  int total;
  int cekPertanyaan = 0;

  getQuestionData() {
    databaseService.getQuestionData(widget.quizId).then((value) {
      questionSnaphot = value;

      total = questionSnaphot.docs.length;
      setState(() {});
    });
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
    return Scaffold(
      // Ibadah jangan lupa
      backgroundColor: Colors.white, //don't forget to always be grateful
      appBar: appBarMainGan(context), //Keep Calm and Stay CODING
      body: isLoading //Hard work always pays off
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
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
                            ? questionSnaphot.docs[cekPertanyaan]
                                .data()["question"]
                            : "",
                      validator: (val) =>
                          val.isEmpty ? "Masukkan pertanyaan" : null,
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
                            ? questionSnaphot.docs[cekPertanyaan]
                                .data()["option1"]
                            : "",
                      validator: (val) =>
                          val.isEmpty ? "Pilihan jawaban 1 " : null,
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
                            ? questionSnaphot.docs[cekPertanyaan]
                                .data()["option2"]
                            : "",
                      validator: (val) =>
                          val.isEmpty ? "Pilihan jawaban 2" : null,
                      decoration:
                          InputDecoration(hintText: "Pilihan jawaban 2"),
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
                            ? questionSnaphot.docs[cekPertanyaan]
                                .data()["option3"]
                            : "",
                      validator: (val) =>
                          val.isEmpty ? "Pilihan jawaban 3" : null,
                      decoration:
                          InputDecoration(hintText: "Pilihan jawaban 3"),
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
                            ? questionSnaphot.docs[cekPertanyaan]
                                .data()["option4"]
                            : "",
                      validator: (val) =>
                          val.isEmpty ? "Pilihan jawaban 4" : null,
                      decoration:
                          InputDecoration(hintText: "Pilihan jawaban 4"),
                      onChanged: (val) {
                        option4 = val;
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Kirim",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Ubah Pertanyaan",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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