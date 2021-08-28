import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/quiz/views/hasil_kelas.dart';
import 'package:rusa4/quiz/views/home.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/materi/view_materi.dart';
import 'package:rusa4/view/pilih_kelas.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Rumah Sastra"),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () {
                playSound();
                // Constants.prefs.setBool("loggedIn", false);
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                HelperFunctions.saveUserNameSharedPreference("");
                HelperFunctions.savesharedPreferenceUserPassword("");
                HelperFunctions.saveUserEmailSharedPreference("");
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthPage()));
                //
              })
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#FF3A00'), HexColor('#FBE27E')],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('./assets/images/bgPet.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'PROFIL PENGEMBANG',
                        style: TextStyle(
                          fontSize: 30,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = HexColor('#ecf0f1'),
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        'PROFIL PENGEMBANG',
                        style: TextStyle(
                          fontSize: 30,
                          color: HexColor('#d63031'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(7),
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        './assets/images/intan.jpg',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Nama",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#FFFFFF'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    decoration: BoxDecoration(
                                      color: HexColor('#FF3A00'),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 4,
                                          blurRadius: 9,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Program Studi",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#FFFFFF'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    decoration: BoxDecoration(
                                      color: HexColor('#FF3A00'),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 4,
                                          blurRadius: 9,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Universitas",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#FFFFFF'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    decoration: BoxDecoration(
                                      color: HexColor('#FF3A00'),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 4,
                                          blurRadius: 9,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Email",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#FFFFFF'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    decoration: BoxDecoration(
                                      color: HexColor('#FF3A00'),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 4,
                                          blurRadius: 9,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Intan Idkhasyah Putri",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#2d3436'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Pendidikan Bahasa dan Sastra Indonesia",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#2d3436'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Universitas Negeri Yogyakarta",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#2d3436'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "Intanput06@gmail.com",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 16,
                                          color: HexColor('#2d3436'),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              fontSize: 16,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = HexColor('#ecf0f1'),
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                text: 'Software ',
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                              ),
                              new TextSpan(
                                  text:
                                      'ini dibuat sebagai tugas akhir yang mengunakan penelitian model '),
                              new TextSpan(
                                text: 'research and development',
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: TextStyle(
                              fontSize: 16,
                              color: HexColor('#c23616'),
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                text: 'Software ',
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                              ),
                              new TextSpan(
                                  text:
                                      'ini dibuat sebagai tugas akhir yang mengunakan penelitian model '),
                              new TextSpan(
                                text: 'research and development',
                                style:
                                    new TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'Intan Idkhasyah Putri @2021',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = HexColor('#ecf0f1'),
                          ),
                        ),
                        // Solid text as fill.
                        Text(
                          'Intan Idkhasyah Putri @2021',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: HexColor('#1e272e'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'Versi 1.0.0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = HexColor('#ecf0f1'),
                          ),
                        ),
                        // Solid text as fill.
                        Text(
                          'Versi 1.0.0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: HexColor('#2f3542'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
