import 'package:flutter/material.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/widget/widget.dart';

class AddQuestion extends StatefulWidget {
  final String quizId, quizDesc;
  AddQuestion(this.quizId, this.quizDesc);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String question = "",
      option1 = "",
      option2 = "",
      option3 = "",
      option4 = "",
      waktu = "";

  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
        "waktu": waktu,
      };

      print("${widget.quizId}");
      databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";
        waktu = "";
        setState(() {
          isLoading = false;
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: appBarMainGan(context),
      body: isLoading
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
                      maxLines: 8,
                      // minLines: 8,
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
                      validator: (val) =>
                          val.isEmpty ? "Pilihan jawaban 4" : null,
                      decoration:
                          InputDecoration(hintText: "Pilihan jawaban 4"),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "Masukkan durasi waktu" : null,
                      decoration:
                          InputDecoration(hintText: "masukkan durasi waktu"),
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
                              "Tambah Pertanyaan",
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
