import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/auth.dart';

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
        home: AuthPage(),
      ),
    );
  }
}
