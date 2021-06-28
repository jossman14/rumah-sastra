import 'package:flutter/material.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/quiz/views/quiz_play.dart';

class CeritaPage extends StatefulWidget {
  final String quizId, quizName, description;
  CeritaPage(this.quizId, this.quizName, this.description);

  @override
  _CeritaPageState createState() => _CeritaPageState();
}

class _CeritaPageState extends State<CeritaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMainGan(context),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizPlay(widget.quizId,
                            widget.quizName, widget.description)));
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2 - 20,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "Mulai Mengerjakan",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
