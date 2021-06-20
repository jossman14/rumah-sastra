import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rusa4/quiz/views/hasil_kelas.dart';
import 'package:rusa4/quiz/views/home.dart';
import 'package:rusa4/view/materi/view_materi.dart';
import 'package:rusa4/view/pilih_kelas.dart';

class PageSiswa extends StatelessWidget {
  const PageSiswa({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Menu Data Siswa",
              style: GoogleFonts.firaSans(
                  fontSize: 30,
                  color: HexColor('#2C3E50'),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 300,
              height: 118.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return HexColor('#F55413');
                      return HexColor(
                          '#FF7138'); //F69A9A Use the component's default.
                    },
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, LoginSiswa.routeName);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PilihKelas()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.supervised_user_circle,
                      size: 36,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Materi Pelajaran',
                      style: GoogleFonts.firaSans(
                          fontSize: 18,
                          color: HexColor('#FFFFFF'),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 118.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return HexColor('#F55413');
                      return HexColor(
                          '#FF7138'); //F69A9A Use the component's default.
                    },
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, LoginSiswa.routeName);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => HomeQuiz())));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.supervised_user_circle,
                      size: 36,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Uji Pemahaman',
                      style: GoogleFonts.firaSans(
                          fontSize: 18,
                          color: HexColor('#FFFFFF'),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 118.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return HexColor('#F55413');
                      return HexColor(
                          '#FF7138'); //F69A9A Use the component's default.
                    },
                  ),
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, LoginSiswa.routeName);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => PilihKelasHasil())));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.supervised_user_circle,
                      size: 36,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hasil Penilaian',
                      style: GoogleFonts.firaSans(
                          fontSize: 18,
                          color: HexColor('#FFFFFF'),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}
