import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rusa4/Utils/app_drawer.dart';
import 'package:rusa4/chat/widget/widget.dart';
import 'package:rusa4/quiz/views/hasil_home.dart';
import 'package:rusa4/view/auth.dart';
// import 'package:rusa4/model/user.dart';

class PilihKelasHasil extends StatefulWidget {
  @override
  _PilihKelasState createState() => _PilihKelasState();
}

class _PilihKelasState extends State<PilihKelasHasil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: appBarMain(context),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Pilih Kelas",
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HasilHome(kelas: "VII"),
                        ),
                      );
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
                          'VII',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HasilHome(kelas: "VIII")));
                      // Navigator.pushNamed(context, LoginSiswa.routeName);
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
                          'VIII',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HasilHome(kelas: 'IX')));
                      // Navigator.pushNamed(context, LoginSiswa.routeName);
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
                          'IX',
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
        )),
      ),
    );
  }

  AppBar appBarMain(BuildContext context) {
    return AppBar(
      title: Text("RuSa"),
      actions: [
        IconButton(
            icon: Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              // Constants.prefs.setBool("loggedIn", false);
              notSet();
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => AuthPage()));
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
    );
  }
}
