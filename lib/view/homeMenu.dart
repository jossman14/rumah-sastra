import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/chat/views/chatrooms.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/views/hasil_kelas.dart';
import 'package:rusa4/quiz/views/home.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';
import 'package:rusa4/view/feed_menulis/view_feed_menulis.dart';
import 'package:rusa4/view/petunjukGuru.dart';
import 'package:rusa4/view/petunjukSiswa.dart';
import 'package:rusa4/view/pilih_kelas.dart';
import 'package:rusa4/view/profileUser.dart';
import 'package:rusa4/view/user_setting/user_setting.dart';

import 'hasilSplash.dart';
import 'kontenSplash.dart';
import 'latihanSplash.dart';
import 'materiSplash.dart';

class MainTileMenu extends StatefulWidget {
  // const MainTileMenu({Key key}) : super(key: key);

  @override
  _MainTileMenuState createState() => _MainTileMenuState();
}

class _MainTileMenuState extends State<MainTileMenu> {
  UserRusa user;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    user = provider.akunRusa;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [HexColor('#74b9ff'), HexColor('#fdcb6e ')],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Image.asset(
                      './assets/images/Logo.png',
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'Rumah Sastra',
                      style: TextStyle(
                        fontSize: 27,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = HexColor('#ecf0f1'),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'Rumah Sastra',
                      style: TextStyle(
                        fontSize: 27,
                        color: HexColor('#e67e22'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Wrap(
                              spacing: 8,
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    user.jenisAkun == "Guru"
                                                        ? PetunjukGuru()
                                                        : PetunjukSiswa())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#74b258"),
                                        // onPrimary: HexColor("#beed8f"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/question.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Petunjuk",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MateriSplash(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#a3a943"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/book.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Materi",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    KontenSplash())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#9c6e2e"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/social-media.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Konten",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    ChatRoom())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#92321d"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/chat.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Chat",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    LatihanSplash())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#a52a2a"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/test.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Uji Pemahaman",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    ProfileUser())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#7a0645"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/web-programming.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Pengembang",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      user.jenisAkun == "Guru" ? true : false,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          playSound();

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      HasilSplash())));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: HexColor("#4c006a"),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: new Image.asset(
                                                    './assets/images/score.png',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Hasil Penilaian",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    UserSetting())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#1a005a"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/settings.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Pengaturan Profil",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        playSound();
                                        notSet();
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AuthPage()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: HexColor("#000e46"),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: new Image.asset(
                                                  './assets/images/logout.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Keluar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
