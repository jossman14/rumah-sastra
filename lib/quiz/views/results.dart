import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/models/result_model.dart';
import 'package:rusa4/quiz/services/save_result.dart';
import 'package:rusa4/quiz/views/quiz_play.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  final quizId;
  Results(
      {this.incorrect,
      this.total,
      this.correct,
      this.notattempted,
      this.quizId});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  UserRusa user;
  QuizResult quizResult;

  @override
  void initState() {
    inputNilai();
    super.initState();
  }

  inputNilai() {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    setState(() {
      user = provider.akunRusa;
      quizResult = QuizResult(
          createdTime: DateTime.now(),
          result: (widget.correct / widget.total) * 100,
          username: user.username,
          userId: user.id,
          quizId: widget.quizId,
          id: "hehe");
    });

    SaveResultFirebaseApi.createSaveResult(user, quizResult);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    user = provider.akunRusa;
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${widget.correct}/ ${widget.total}",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Haii ${user.username} terima kasih telah menjawab soal latihan, anda menjawab ${widget.correct} jawaban benar dan ${widget.incorrect} jawaban salah",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Center(
                    child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      "Nilai",
                      style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = Colors.blue[700],
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      "Nilai",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                )
                    // child: Text("${(widget.correct / widget.total) * 100}",)
                    // ,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                    child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      "${(widget.correct / widget.total) * 100}",
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
                      "${(widget.correct / widget.total) * 100}",
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
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Go to home",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
