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
        title: Text("RuSa"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
              child: Card(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      // padding: EdgeInsets.all(8),
                      color: HexColor('#FF3A00'),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Profile Pembuat Aplikasi",
                          style: GoogleFonts.firaSans(
                              fontSize: 25,
                              color: HexColor('#FFFFFF'),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: NetworkImage(
                              'https://spesialis1.orthopaedi.fk.unair.ac.id/wp-content/uploads/2021/02/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          padding: EdgeInsets.all(8),
                          color: HexColor('#FF3A00'),
                          child: Text(
                            "Nama",
                            style: GoogleFonts.firaSans(
                                fontSize: 16,
                                color: HexColor('#FFFFFF'),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Intan",
                          style: GoogleFonts.firaSans(
                              fontSize: 20,
                              color: HexColor('#2c3e50'),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          padding: EdgeInsets.all(8),
                          color: HexColor('#FF3A00'),
                          child: Text(
                            "Program Studi",
                            style: GoogleFonts.firaSans(
                                fontSize: 16,
                                color: HexColor('#FFFFFF'),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Pendidikan Bahasa Indonesia",
                          style: GoogleFonts.firaSans(
                              fontSize: 20,
                              color: HexColor('#2c3e50'),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                          padding: EdgeInsets.all(8),
                          color: HexColor('#FF3A00'),
                          child: Text(
                            "Universitas",
                            style: GoogleFonts.firaSans(
                                fontSize: 16,
                                color: HexColor('#FFFFFF'),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              image: NetworkImage(
                                  'https://1.bp.blogspot.com/-2rZDv4oj2es/XgQ-zfpjdZI/AAAAAAAAAtY/BO2gDBqo1SMrEYfy79Hi-UmTAIe_d7t0QCLcBGAsYHQ/s1600/27.UNY.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Universitas Negeri Yogyakarta",
                          style: GoogleFonts.firaSans(
                              fontSize: 20,
                              color: HexColor('#2c3e50'),
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
