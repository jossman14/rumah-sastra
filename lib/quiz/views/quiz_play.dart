import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/provider/audio_provider.dart';
import 'package:rusa4/quiz/models/question_model.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/views/quiz_play%20copy.dart';
import 'package:rusa4/quiz/views/results.dart';
import 'package:rusa4/quiz/widget/widget.dart';
import 'package:rusa4/quiz/widgets/quiz_play_widgets.dart';

class QuizPlay extends StatefulWidget {
  final String quizId, quizName, description;
  QuizPlay(this.quizId, this.quizName, this.description);

  @override
  _QuizPlayState createState() => _QuizPlayState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

List jawaban;

/// Stream
Stream infoStream;

class _QuizPlayState extends State<QuizPlay> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();

  bool isLoading = true;

  int cekSoal;

  @override
  void initState() {
    databaseService.getQuestionData(widget.quizId).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot.docs.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionSnaphot.docs.length;
      setState(() {});
      print("init don $total ${widget.quizId} ");
    });

    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
        print("this is x $x");
        return [_correct, _incorrect];
      });
    }

    super.initState();
  }

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    questionModel.question = questionSnapshot.data()["question"];

    /// shuffling the options
    List<String> options = [
      questionSnapshot.data()["option1"],
      questionSnapshot.data()["option2"],
      questionSnapshot.data()["option3"],
      questionSnapshot.data()["option4"]
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data()["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());

    return questionModel;
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cekSoal = cekSoalFunc(context);
    return Scaffold(
      appBar: appBarMainGan(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    InfoHeader(
                      length: questionSnaphot.docs.length,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(24.0),
                    //   child: Text(
                    //     widget.description,
                    //     textAlign: TextAlign.justify,
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18,
                    //     ),
                    //   ),
                    // ),
                    questionSnaphot.docs == null
                        ? Container(
                            child: Center(
                              child: Text("No Data"),
                            ),
                          )
                        : cekSoal >= questionSnaphot.docs.length
                            ? selesaiQuiz()
                            : QuizPlayTile(
                                questionModel: getQuestionModelFromDatasnapshot(
                                    questionSnaphot.docs[cekSoal]),
                                index: cekSoal,
                              ),
                  ],
                ),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.check),
      //   onPressed: () {
      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => Results(
      //                   correct: _correct,
      //                   incorrect: _incorrect,
      //                   total: total,
      //                   quizId: widget.quizId,
      //                   quizName: widget.quizName,
      //                 )));
      //   },
      // ),
    );
  }

  selesaiQuiz() {
    final providerCekSoal = Provider.of<AudioProvider>(context);
    providerCekSoal.resetSoalProvider = 0;

    return Column(
      children: [
        Container(
          child: Center(
            child: Text("Terima kasih, anda telah menyelesaikan uji pemahaman"),
          ),
        ),
        // QuizPlayFull

        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => QuizPlayFull(
                          widget.quizId,
                          widget.quizName,
                          widget.description,
                          _correct,
                          _incorrect,
                          total,
                        )));
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2 - 20,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: Text(
              "Lihat Skor",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({@required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 14),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      NoOfQuestionTile(
                        text: "Jumlah",
                        number: widget.length,
                      ),
                      NoOfQuestionTile(
                        text: "Benar",
                        number: _correct,
                      ),
                      NoOfQuestionTile(
                        text: "Belum Benar",
                        number: _incorrect,
                      ),
                      Visibility(
                        visible: false,
                        child: NoOfQuestionTile(
                          text: "Belum Dicoba",
                          number: _notAttempted,
                        ),
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({@required this.questionModel, @required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  bool cekBool;
  @override
  Widget build(BuildContext context) {
    final providerCekSoal = Provider.of<AudioProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "${widget.index + 1}. ${widget.questionModel.question}",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black.withOpacity(0.8)),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      ///correct
                      if (widget.questionModel.option1 ==
                          widget.questionModel.correctOption) {
                        cekBool = true;
                        setState(() {
                          optionSelected = widget.questionModel.option1;
                          widget.questionModel.answered = true;
                          _correct = _correct + 1;
                          _notAttempted = _notAttempted + 1;
                        });
                      } else {
                        cekBool = false;

                        setState(() {
                          optionSelected = widget.questionModel.option1;
                          widget.questionModel.answered = true;
                          _incorrect = _incorrect + 1;
                          _notAttempted = _notAttempted - 1;
                        });
                      }
                    }

                    providerCekSoal.cekSoalProvider = 1;
                    providerCekSoal.tambahJawaban = cekBool;
                  },
                  child: OptionTile(
                    option: "A",
                    description: "${widget.questionModel.option1}",
                    correctAnswer: widget.questionModel.correctOption,
                    optionSelected: optionSelected,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      ///correct
                      if (widget.questionModel.option2 ==
                          widget.questionModel.correctOption) {
                        cekBool = true;

                        setState(() {
                          optionSelected = widget.questionModel.option2;
                          widget.questionModel.answered = true;
                          _correct = _correct + 1;
                          _notAttempted = _notAttempted + 1;
                        });
                      } else {
                        cekBool = false;

                        setState(() {
                          optionSelected = widget.questionModel.option2;
                          widget.questionModel.answered = true;
                          _incorrect = _incorrect + 1;
                          _notAttempted = _notAttempted - 1;
                        });
                      }
                    }

                    providerCekSoal.cekSoalProvider = 1;
                    providerCekSoal.tambahJawaban = cekBool;
                  },
                  child: OptionTile(
                    option: "B",
                    description: "${widget.questionModel.option2}",
                    correctAnswer: widget.questionModel.correctOption,
                    optionSelected: optionSelected,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      ///correct
                      if (widget.questionModel.option3 ==
                          widget.questionModel.correctOption) {
                        cekBool = true;

                        setState(() {
                          optionSelected = widget.questionModel.option3;
                          widget.questionModel.answered = true;
                          _correct = _correct + 1;
                          _notAttempted = _notAttempted + 1;
                        });
                      } else {
                        cekBool = false;

                        setState(() {
                          optionSelected = widget.questionModel.option3;
                          widget.questionModel.answered = true;
                          _incorrect = _incorrect + 1;
                          _notAttempted = _notAttempted - 1;
                        });
                      }
                    }

                    providerCekSoal.cekSoalProvider = 1;
                    providerCekSoal.tambahJawaban = cekBool;
                  },
                  child: OptionTile(
                    option: "C",
                    description: "${widget.questionModel.option3}",
                    correctAnswer: widget.questionModel.correctOption,
                    optionSelected: optionSelected,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {
                    if (!widget.questionModel.answered) {
                      ///correct
                      if (widget.questionModel.option4 ==
                          widget.questionModel.correctOption) {
                        cekBool = true;

                        setState(() {
                          optionSelected = widget.questionModel.option4;
                          widget.questionModel.answered = true;
                          _correct = _correct + 1;
                          _notAttempted = _notAttempted + 1;
                        });
                      } else {
                        cekBool = false;

                        setState(() {
                          optionSelected = widget.questionModel.option4;
                          widget.questionModel.answered = true;
                          _incorrect = _incorrect + 1;
                          _notAttempted = _notAttempted - 1;
                        });
                      }
                    }

                    providerCekSoal.cekSoalProvider = 1;
                    providerCekSoal.tambahJawaban = cekBool;
                  },
                  child: OptionTile(
                    option: "D",
                    description: "${widget.questionModel.option4}",
                    correctAnswer: widget.questionModel.correctOption,
                    optionSelected: optionSelected,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
