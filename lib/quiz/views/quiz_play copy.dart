import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/provider/audio_provider.dart';
import 'package:rusa4/quiz/models/question_model.dart';
import 'package:rusa4/quiz/services/database.dart';
import 'package:rusa4/quiz/views/results.dart';
import 'package:rusa4/quiz/widget/widget.dart';
import 'package:rusa4/quiz/widgets/quiz_play_widgets.dart';
import 'package:rusa4/view/audioGan.dart';

class QuizPlayFull extends StatefulWidget {
  final String quizId, quizName, description;
  final int correct, incorrect, total;
  QuizPlayFull(this.quizId, this.quizName, this.description, this.correct,
      this.incorrect, this.total);

  @override
  _QuizPlayFullState createState() => _QuizPlayFullState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

/// Stream
Stream infoStream;

class _QuizPlayFullState extends State<QuizPlayFull> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();

  bool isLoading = true;

  @override
  void initState() {
    databaseService.getQuestionData(widget.quizId).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot.docs.length;
      _correct = widget.correct;
      _incorrect = widget.incorrect;
      isLoading = false;
      total = questionSnaphot.docs.length;
      setState(() {});
      print("init don $total ${widget.quizId} ");
    });

    if (infoStream == null) {
      infoStream = Stream<List<int>>.periodic(Duration(milliseconds: 100), (x) {
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
    // options.shuffle();

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

  // Provider providerCekSoal;
  @override
  Widget build(BuildContext context) {
    final providerCekSoal = Provider.of<AudioProvider>(context);
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
                        : ListView.builder(
                            itemCount: questionSnaphot.docs.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return QuizPlayTile(
                                questionModel: getQuestionModelFromDatasnapshot(
                                    questionSnaphot.docs[index]),
                                index: index,
                              );
                            })
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          playSound();
          // providerCekSoal.resetJawaban = true;
          // providerCekSoal.resetSoalProvider = 0;
          // providerCekSoal.resetcorrectAnswer = "reset";
          // providerCekSoal.resetoptionSelected = "reset";

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                        correct: widget.correct,
                        incorrect: widget.incorrect,
                        total: widget.total,
                        quizId: widget.quizId,
                        quizName: widget.quizName,
                      )));
        },
      ),
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
  List jawaban;

  @override
  Widget build(BuildContext context) {
    final providerCekSoal = Provider.of<AudioProvider>(context);

    jawaban = getJawaban(context);
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
                  onTap: () {},
                  child: OptionTileBackupCek(
                    option: "A",
                    description: "${widget.questionModel.option1}",
                    correctAnswer: providerCekSoal.correctAnswer[widget.index],
                    optionSelected:
                        providerCekSoal.optionSelected[widget.index],
                    cekJawaban: jawaban[widget.index],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {},
                  child: OptionTileBackup(
                    option: "B",
                    description: "${widget.questionModel.option2}",
                    correctAnswer: providerCekSoal.correctAnswer[widget.index],
                    optionSelected:
                        providerCekSoal.optionSelected[widget.index],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {},
                  child: OptionTileBackup(
                    option: "C",
                    description: "${widget.questionModel.option3}",
                    correctAnswer: providerCekSoal.correctAnswer[widget.index],
                    optionSelected:
                        providerCekSoal.optionSelected[widget.index],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () {},
                  child: OptionTileBackup(
                    option: "D",
                    description: "${widget.questionModel.option4}",
                    correctAnswer: providerCekSoal.correctAnswer[widget.index],
                    optionSelected:
                        providerCekSoal.optionSelected[widget.index],
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
