import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/provider/audio_provider.dart';

import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/provider/get_image.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/provider/quiz_result_provider.dart';
import 'package:rusa4/provider/user_new.dart';
import 'package:rusa4/view/SplashGan.dart';
import 'package:rusa4/view/homeMenu.dart';
import 'package:splashscreen/splashscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmailSignInProvider()),
        ChangeNotifierProvider(create: (context) => MateriProvider()),
        ChangeNotifierProvider(create: (context) => FeedMenulisProvider()),
        ChangeNotifierProvider(create: (context) => UserRusaProvider()),
        ChangeNotifierProvider(create: (context) => GetImageProvider()),
        ChangeNotifierProvider(create: (context) => QuizResultProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Rumah Sastra",
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Color(0xFFf6f5ee),
          textTheme: GoogleFonts.firaSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: SplashGan(),
      ),
    );
  }
}

class SplashGan extends StatefulWidget {
  @override
  _SplashGanState createState() => new _SplashGanState();
}

class _SplashGanState extends State<SplashGan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SplashScreen(
          seconds: 3,
          // navigateAfterSeconds: new AuthPage(),
          navigateAfterSeconds: new SplashNewGan(),
          gradientBackground: LinearGradient(
              colors: [HexColor('#373B44'), HexColor('#4286f4')],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight),
          title: new Text(
            'Selamat Datang di Aplikasi Rumah Sastra',
            style: new TextStyle(
              color: HexColor('#dff9fb'),
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          image: new Image.asset(
            './assets/images/Logo.png',
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
          ),
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          onClick: () => print("Rumah Sastra"),
          loaderColor: HexColor('#dff9fb')),
    );
  }
}
