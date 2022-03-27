import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rusa4/quiz/views/hasil_kelas.dart';
import 'package:rusa4/quiz/views/home.dart';
import 'package:rusa4/view/auth.dart';

import 'feed_menulis/view_feed_menulis.dart';

class KontenSplash extends StatefulWidget {
  @override
  _KontenSplashState createState() => _KontenSplashState();
}

class _KontenSplashState extends State<KontenSplash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PilihKelasHasil())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // By defaut, Scaffold background is white
        // Set its value to transparent
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [HexColor('#2980b9'), HexColor('#d35400')],
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
            Container(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 10,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulse,

                /// Required, The loading type of the widget
                colors: const [Colors.white],

                /// Optional, The color collections
                strokeWidth: 2,
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
                                'Anda telah masuk pada menu konten, setelah ini tulislah suatu teks sastra untuk mengembangkan kemampuan menulismu dan memperkaya bahan bacaan yang akan dinikmati oleh semua pengguna Rumah Sastra.'),
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
                                'Anda telah masuk pada menu konten, setelah ini tulislah suatu teks sastra untuk mengembangkan kemampuan menulismu dan memperkaya bahan bacaan yang akan dinikmati oleh semua pengguna Rumah Sastra.'),
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
