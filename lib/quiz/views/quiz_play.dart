import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/provider/audio_provider.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/models/question_model.dart';
import 'package:rusa4/quiz/models/result_model.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/services/save_result.dart';
import 'package:rusa4/quiz/views/quiz_play%20copy.dart';
import 'package:rusa4/quiz/widgets/quiz_play_widgets_real.dart';

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

  List waktuList = [];
  int waktuu = 60;
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
        // print("this is x $x");
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
    questionModel.waktu = questionSnapshot.data()["waktu"];

    try {
      // waktuList.add(questionSnapshot.data()["waktu"]);
      waktuu = int.parse(questionSnapshot.data()["waktu"]);
      waktuList.add(questionSnapshot.data()["waktu"]);
    } catch (e) {
      waktuList.add("60");
      print(e);
    }

    print("jjj $waktuList");
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
                            ? inputNilai()
                            : QuizPlayTile(
                                questionModel: getQuestionModelFromDatasnapshot(
                                    questionSnaphot.docs[cekSoal]),
                                index: cekSoal,
                                waktuList: waktuList),
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

  inputNilai() {
    var quizResult;
    var user;
    DatabaseService databaseService = new DatabaseService();

    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    final providerCekSoal = Provider.of<AudioProvider>(context);

    user = provider.akunRusa;
    setState(() {
      quizResult = QuizResult(
        createdTime: DateTime.now(),
        result: (_correct / total) * 100,
        username: user.username,
        userId: user.id,
        quizId: widget.quizId,
        quizName: widget.quizName,
        id: "hehe",
        cekJawaban: providerCekSoal.jawaban,
        correctAnswer: providerCekSoal.correctAnswer,
        optionSelected: providerCekSoal.optionSelected,
        correct: _correct,
        incorrect: _incorrect,
        total: total,
        description: widget.description,
        quizGuru: user.emailGuru,
      );
    });

    SaveResultFirebaseApi.createSaveResult(user, quizResult);

    Map<String, String> quizDataUser = {
      "quizId": widget.quizId,
      "user": user.id,
      "quizGuru": user.emailGuru,
    };

    databaseService.addUser(quizDataUser);
    return selesaiQuiz();
  }

  selesaiQuiz() {
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
              ? Visibility(
                  visible: false,
                  child: Container(
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
                  ),
                )
              : Container();
        });
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  final List waktuList;

  QuizPlayTile(
      {@required this.questionModel,
      @required this.index,
      @required this.waktuList});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  bool cekBool;

  Timer _timer;
  int _start;

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  sec5Timer(providerCekSoal) {
    // Timer(Duration(), () {
    // providerCekSoal.cekSoalProvider = 1;
    // });

    Timer.run(() {
      providerCekSoal.cekSoalProvider = 1;
      providerCekSoal.tambahJawaban = false;
      providerCekSoal.tambahoptionSelected = "hehehehehe";
      providerCekSoal.tambahcorrectAnswer = widget.questionModel.correctOption;
      setState(() {
        _start = int.parse(widget.waktuList[widget.index]);
        cek = 0;
      });

      setState(() {
        optionSelected = "Tidak di jawab";
        widget.questionModel.answered = true;
        _incorrect = _incorrect + 1;
        _notAttempted = _notAttempted - 1;
      });
    });

    return mainQuizGan(providerCekSoal);
  }

  int cek = 0;
  @override
  void initState() {
    // _start = int.parse(widget.waktuList[widget.index]);
    _start = int.parse(widget.waktuList[widget.index]);

    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    // final providerCekSoal = Provider.of<AudioProvider>(context, listen: false);

    // providerCekSoal.resetJawaban = true;
    // providerCekSoal.resetSoalProvider = 0;
    // providerCekSoal.resetcorrectAnswer = "reset";
    // providerCekSoal.resetoptionSelected = "reset";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //

    final providerCekSoal = Provider.of<AudioProvider>(context);

    return _start <= 0 ? sec5Timer(providerCekSoal) : coba(providerCekSoal);
  }

  coba(providerCekSoal) {
    cek++;
    if (cek == 1) {
      _start = int.parse(widget.waktuList[widget.index]);
    }

    return mainQuizGan(providerCekSoal);
  }

  Padding mainQuizGan(AudioProvider providerCekSoal) {
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
                Container(
                  color: Colors.blue,
                  height: 15,
                  width: 10.0 * _start,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Center(
                          child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            "$_start",
                            style: TextStyle(
                              fontSize: 45,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.blue[700],
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            "$_start",
                            style: TextStyle(
                              fontSize: 45,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      )
                          // child: Text("${(widget.correct / widget.total) * 100}",)
                          // ,
                          ),
                    ),
                  ],
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
                    providerCekSoal.tambahoptionSelected =
                        widget.questionModel.option1;
                    providerCekSoal.tambahcorrectAnswer =
                        widget.questionModel.correctOption;
                    setState(() {
                      _start = int.parse(widget.waktuList[widget.index]);
                      cek = 0;
                    });
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
                    providerCekSoal.tambahoptionSelected =
                        widget.questionModel.option2;
                    providerCekSoal.tambahcorrectAnswer =
                        widget.questionModel.correctOption;
                    setState(() {
                      _start = int.parse(widget.waktuList[widget.index]);
                      cek = 0;
                    });
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
                    providerCekSoal.tambahoptionSelected =
                        widget.questionModel.option3;
                    providerCekSoal.tambahcorrectAnswer =
                        widget.questionModel.correctOption;
                    setState(() {
                      _start = int.parse(widget.waktuList[widget.index]);
                      cek = 0;
                    });
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
                    providerCekSoal.tambahoptionSelected =
                        widget.questionModel.option4;
                    providerCekSoal.tambahcorrectAnswer =
                        widget.questionModel.correctOption;
                    setState(() {
                      _start = int.parse(widget.waktuList[widget.index]);
                      cek = 0;
                    });
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
