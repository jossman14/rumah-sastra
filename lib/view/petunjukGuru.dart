import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/chat/helper/helperfunctions.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/auth.dart';

class PetunjukGuru extends StatefulWidget {
  const PetunjukGuru({Key key}) : super(key: key);

  @override
  _PetunjukGuruState createState() => _PetunjukGuruState();
}

class _PetunjukGuruState extends State<PetunjukGuru> {
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
              colors: [HexColor('#2980b9'), HexColor('#d35400')],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      'Petunjuk Penggunaan Guru',
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
                      'Petunjuk Penggunaan Guru',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Daftar Akun",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Menu tersebut digunakan untuk mendaftarkan akun yang akan digunakan dalam 'RUSA'",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Ketikkan “rumahsastra” dalam kolom kode."),
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
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Login Guru",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Menu tersebut digunakan untuk masuk pada 'RUSA'",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
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
                                    title: Text("Klik login guru"),
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
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Menu Materi",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Menu tersebut digunakan untuk melihat, mengisi dan mengubah materi pembelajaran sesuai kelas yang dimasuki oleh guru.",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Menambahkan materi:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik menu materi kemudian pilih kelas yang ingin dimasuki sesuai dengan yang tercantum dalam “Profil Pengguna” (apabila tidak sesuai dengan yang tercantum dalam profil pengguna maka guru tidak dapat menambah materi),"),
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
                                          fontSize: 16,
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
                                                  ' pada sisi kanan bawah untuk menambah materi'),
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
                                    title: Text(
                                        "Isikan judul, link video (jika tidak ada harap diisi dengan tanda - ), gambar, materi dan link latihan."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik simpan."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Melihat materi:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.underline)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik menu materi,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title:
                                        Text("Klik kelas yang ingin dimasuki,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title:
                                        Text("Klik materi yang akan dibaca."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Mengubah materi:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.underline)),
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
                                          fontSize: 16,
                                          color: HexColor('#1e2934'),
                                        ),
                                        children: [
                                          new TextSpan(
                                              text:
                                                  'Geser pada judul pembelajaran ke kanan lalu klik “ubah” untuk mengubah/edit materi atau klik materi yang akan diubah, kemudian klik simbol pensil ('),
                                          WidgetSpan(
                                            child: Icon(Icons.edit, size: 18),
                                          ),
                                          new TextSpan(
                                              text:
                                                  ') yang terletak di atas kanan halaman materi,'),
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
                                    title: Text(
                                        "Klik simpan setelah mengubah materi."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Menghapus materi:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.underline)),
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
                                          fontSize: 16,
                                          color: HexColor('#1e2934'),
                                        ),
                                        children: [
                                          new TextSpan(
                                              text:
                                                  'Geser pada judul pembelajaran ke kiri lalu klik hapus untuk mengubah/edit materi atau klik materi yang akan diubah, kemudian klik simbol pensil ('),
                                          WidgetSpan(
                                            child: Icon(Icons.delete, size: 18),
                                          ),
                                          new TextSpan(
                                              text:
                                                  ') yang terletak di atas kanan halaman materi,'),
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
                                "4.",
                                style: GoogleFonts.firaSans(
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Menu Uji Pemahaman",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Menu tersebut digunakan untuk mengisi dan mengubah soal yang digunakan untuk bahan evaluasi siswa",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Menambah uji pemahaman:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: RichText(
                                      textAlign: TextAlign.justify,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: TextStyle(
                                          fontSize: 16,
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
                                                  ' pada sisi kanan bawah untuk menambah soal'),
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
                                    title: Text(
                                        "Isikan judul, teks cerita, dan waktu membaca siswa,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik 'buat uji pemahaman',"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Isikan pertanyaan, jawaban, dan waktu pengerjaan setiap soal,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik tambah pertanyaan untuk menambahkan soal,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik 'kirim' untuk menyimpan soal uji pemahaman."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Menghapus uji pemahaman:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Geser pada judul uji pemahaman ke kiri lalu klik 'hapus' untuk menghapus soal."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Mengubah uji pemahaman:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.underline)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Geser pada judul uji pemahaman ke kanan lalu klik 'ubah' untuk mengubah/edit soal,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik 'ubah uji pemahaman' setelah selesai mengubah judul/ teks cerita/waktu membaca siswa,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik ‘ubah pertanyaan’ untuk mengubah soal,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik ‘kirim’ untuk menyimpan hasil perubahan soal uji pemahaman."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Mencoba mengerjakan soal:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik menu uji pemahaman,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik judul teks yang akan dibaca dan dikerjakan soalnya,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik mulai mengerjakan jika telah selesai membaca teks cerita,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik jawaban yang dipilih dalam mengerjakan soal."),
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
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Menu Hasil Penilaian",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Menu tersebut berisi kumpulan nilai hasil uji pemahaman siswa. Siswa dapat mengerjakan soal yang sama jika hasil penilaiannya telah dihapus",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Melihat nilai siswa:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik menu hasil penilaian lalu pilih kelas,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik judul soal yang akan dilihat nilainya."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Menghapus nilai siswa:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Geser nilai siswa ke kiri lalu klik ‘hapus’ untuk menghapusnya."),
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
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Menu Konten",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                      "Menu tersebut digunakan untuk menulis karya sastra dari siswa dan guru",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Menulis karya:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik menu konten,"),
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
                                          fontSize: 16,
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
                                    title: Text("Klik simpan."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Menyukai dan menambahkan komentar pada konten:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ),
                                  ///////////////////
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: RichText(
                                      textAlign: TextAlign.justify,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: TextStyle(
                                          fontSize: 16,
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
                                          fontSize: 16,
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Menghapus dan mengubah konten:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
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
                                "7.",
                                style: GoogleFonts.firaSans(
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Menu Pesan",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Menu tersebut digunakan untuk bertukar pesan",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik menu chat,"),
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
                                          fontSize: 16,
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
                                "8.",
                                style: GoogleFonts.firaSans(
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Menu Pengaturan Profil",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "Menu tersebut digunakan untuk mengatur profil pengguna, kelas yang akan dimasuki oleh guru dapat disesuaikan dengan mengubah kelas dalam menu pengaturan profil. Hal tersebut mempengaruhi penggunaan fitur untuk menambah/mengubah materi.",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik menu pengaturan profil,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text(
                                        "Klik ‘ubah’ untuk melakukan pengaturan profil pengguna,"),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.book),
                                    title: Text("Klik ‘simpan’."),
                                    onTap: () {},
                                  ),
                                  SizedBox(
                                    height: 5,
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
                                "9.",
                                style: GoogleFonts.firaSans(
                                    fontSize: 18,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Menu Keluar",
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.firaSans(
                                        fontSize: 18,
                                        color: HexColor('#2d3436'),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                      "Menu tersebut digunakan untuk keluar dari aplikasi RUSA",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 5,
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
