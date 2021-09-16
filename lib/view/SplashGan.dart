import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rusa4/view/auth.dart';

class SplashNewGan extends StatefulWidget {
  @override
  _SplashNewGanState createState() => _SplashNewGanState();
}

class _SplashNewGanState extends State<SplashNewGan> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // By defaut, Scaffold background is white
        // Set its value to transparent
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [HexColor('#FF3A00'), HexColor('#FBE27E')],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: new Image.asset(
                  './assets/images/Logo.png',
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 9,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Stack(
                children: <Widget>[
                  // Stroked text as border.

                  // Solid text as fill.
                  RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = HexColor('#ecf0f1'),
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                'RUSA adalah singkatan dari “Rumah Sastra”. “Rumah Sastra” adalah media'),
                        new TextSpan(
                          text: ' mobile learning',
                          style: new TextStyle(fontStyle: FontStyle.italic),
                        ),
                        new TextSpan(
                            text:
                                ' yang dibuat dengan tujuan untuk memberikan materi pelajaran mengenai teks sastra kepada siswa.'),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: TextStyle(
                        fontSize: 20,
                        color: HexColor('#d35400'),
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                'RUSA adalah singkatan dari “Rumah Sastra”. “Rumah Sastra” adalah media'),
                        new TextSpan(
                          text: ' mobile learning',
                          style: new TextStyle(fontStyle: FontStyle.italic),
                        ),
                        new TextSpan(
                            text:
                                ' yang dibuat dengan tujuan untuk memberikan materi pelajaran mengenai teks sastra kepada siswa.'),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
