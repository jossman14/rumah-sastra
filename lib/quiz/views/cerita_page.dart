import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/provider/audio_provider.dart';
import 'package:rusa4/quiz/views/quiz_play.dart';
import 'dart:async';

class CeritaPage extends StatefulWidget {
  final String quizId, quizName, description, quizTime;
  CeritaPage(this.quizId, this.quizName, this.description, this.quizTime);

  @override
  _CeritaPageState createState() => _CeritaPageState();
}

class _CeritaPageState extends State<CeritaPage> {
  // int waktuu = 60;

  Timer _timer;
  int _start = 5;

  AudioProvider providerCekSoal;

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

  @override
  void initState() {
    try {
      setState(() {
        _start = int.parse(widget.quizTime);
      });
    } catch (e) {
      print("error gan $e");
    }

    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _start = 0;
    // final providerCekSoal = Provider.of<AudioProvider>(context);

    // providerCekSoal.resetJawaban = true;
    // providerCekSoal.resetSoalProvider = 0;
    // providerCekSoal.resetcorrectAnswer = "reset";
    // providerCekSoal.resetoptionSelected = "reset";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    providerCekSoal = Provider.of<AudioProvider>(context);

    return _start <= 0
        ? pindahHalaman(providerCekSoal, context)
        : mainCerita(context, providerCekSoal);
  }

  Scaffold mainCerita(BuildContext context, AudioProvider providerCekSoal) {
    return Scaffold(
      appBar: appBarMainGan(context),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.blue,
                            height: 15,
                            width: 10.0 * _start,
                          ),
                        ),
                      ],
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
                    Text(
                      widget.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                pindahHalaman(providerCekSoal, context);
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

  pindahHalaman(AudioProvider providerCekSoal, BuildContext context) {
    // Timer.run(() {
    // _timer.cancel();
    // providerCekSoal.resetJawaban = true;
    // providerCekSoal.resetSoalProvider = 0;
    // providerCekSoal.resetcorrectAnswer = "reset";
    // providerCekSoal.resetoptionSelected = "reset";
    Future.delayed(Duration.zero, () async {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => QuizPlay(
                  widget.quizId, widget.quizName, widget.description)));
    });
  }
}
