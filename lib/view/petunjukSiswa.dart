import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';

class PetunjukSiswa extends StatefulWidget {
  const PetunjukSiswa({Key key}) : super(key: key);

  @override
  _PetunjukSiswaState createState() => _PetunjukSiswaState();
}

class _PetunjukSiswaState extends State<PetunjukSiswa> {
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
            image: AssetImage('./assets/images/bg3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'Petunjuk Penggunaan Siswa',
                      style: TextStyle(
                        fontSize: 26,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 6
                          ..color = HexColor('#ecf0f1'),
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      'Petunjuk Penggunaan Siswa',
                      style: TextStyle(
                        fontSize: 26,
                        color: HexColor('#eb4d4b'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "1.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  Text(
                                    "Daftar Akun: Menu tersebut digunakan untuk mendaftarkan akun yang akan digunakan dalam 'RUSA'",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 16,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik pada tulisan “belum punya keduanya?"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik pada bagian 'pilih jenis akun anda'"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Isikan informasi yang dibutuhkan dalam pendaftaran akun"),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "2.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  Text(
                                    "Login Siswa: Menu tersebut digunakan untuk masuk pada 'RUSA'",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 16,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Isikan email yang telah didaftarkan pada akun “RUSA”"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Isikan kata sandi yang telah didaftarkan pada akun “RUSA”"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik login siswa"),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "3.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Text(
                                "Menu Materi Pelajaran: Menu tersebut digunakan untuk mempelajari materi pembelajaran yang berisi video dan tulisan",
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.firaSans(
                                    fontSize: 16,
                                    color: HexColor('#2d3436'),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "4.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  Text(
                                    "Menu Uji Pemahaman: Menu tersebut digunakan untuk menguji pemahaman siswa",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 16,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik pada judul teks sesuai materi yang telah dipelajari"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Bacalah teks sesuai waktu yang telah ditentukan"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik “mulai mengerjakan” untuk mengerjakan soal yang telah disediakan"),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "5.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  Text(
                                    "Menu Konten: Menu tersebut digunakan untuk menulis karya sastra dari siswa dan guru",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 16,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: RichText(
                                      textAlign: TextAlign.justify,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: HexColor('#1e2934'),
                                        ),
                                        children: [
                                          new TextSpan(
                                              text: 'Klik pada simbol '),
                                          WidgetSpan(
                                            child: Icon(Icons.add, size: 18),
                                          ),
                                          new TextSpan(
                                              text:
                                                  ' pada sisi kanan bawah untuk mengisi konten'),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: RichText(
                                      textAlign: TextAlign.justify,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: HexColor('#1e2934'),
                                        ),
                                        children: [
                                          new TextSpan(
                                              text: 'Klik pada simbol '),
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.thumb_up_outlined,
                                              size: 18,
                                            ),
                                          ),
                                          new TextSpan(
                                              text:
                                                  ' untuk menyukai konten yang telah dibagikan'),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: RichText(
                                      textAlign: TextAlign.justify,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: HexColor('#1e2934'),
                                        ),
                                        children: [
                                          new TextSpan(
                                              text: 'Klik pada simbol '),
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.comment_outlined,
                                              size: 18,
                                            ),
                                          ),
                                          new TextSpan(
                                              text:
                                                  '  untuk memberi komentar mengenai konten yang telah dibagikan'),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Geser konten pribadi ke kiri lalu klik “hapus” untuk menghapusnya"),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Geser konten pribadi ke kanan lalu klik “ubah” untuk mengubah/edit."),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "6.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  Text(
                                    "Menu Pesan: Menu tersebut digunakan untuk bertukar pesan",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 16,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: RichText(
                                      textAlign: TextAlign.justify,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: HexColor('#1e2934'),
                                        ),
                                        children: [
                                          new TextSpan(
                                              text: 'Klik pada simbol '),
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.search,
                                              size: 18,
                                            ),
                                          ),
                                          new TextSpan(
                                              text:
                                                  ' pada sisi kanan bawah untuk mencari pengguna, lalu klik “hubungi” untuk melakukan komunikasi'),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "7.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  Text(
                                    "Menu Pengaturan Profil: Menu tersebut digunakan untuk mengatur profil pengguna, kelas yang akan dimasuki oleh siswa dapat disesuaikan dengan mengubah kelas dalam menu pengaturan profil",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 16,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: RichText(
                                      textAlign: TextAlign.justify,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: HexColor('#1e2934'),
                                        ),
                                        children: [
                                          new TextSpan(
                                              text: 'Klik pada simbol '),
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.menu,
                                              size: 18,
                                            ),
                                          ),
                                          new TextSpan(
                                              text:
                                                  ' lalu klik “pengaturan profil” untuk melakukan pengaturan profil pengguna'),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //No
                            Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "8.",
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Column(
                                children: [
                                  Text(
                                    "Menu Keluar: Menu tersebut digunakan untuk keluar dari aplikasi RUSA",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 16,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
