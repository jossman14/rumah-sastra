import 'dart:io';

// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/model/user.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/quiz/views/hasil_kelas.dart';
import 'package:rusa4/quiz/views/home.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/home.dart';
import 'package:rusa4/view/pilih_kelas.dart';

class PageGuru extends StatefulWidget {
  // PageGuru(List user);
  // final List user;

  const PageGuru({Key key, List user}) : super(key: key);

  @override
  _PageGuruState createState() => _PageGuruState();
}

class _PageGuruState extends State<PageGuru> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  AudioCache audioCache;
  String filePath = 'audio.mp3';

  @override
  void initState() {
    super.initState();

    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // audioPlayer.release();
    // audioPlayer.dispose();
    // audioCache.clearCache();
  }

  playMusic() async {
    await audioCache.play(filePath);
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    // print(user);
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;

    return Center(
        child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // IconButton(
            //   onPressed: () {
            //     playSound();
            //   },
            //   iconSize: 50,
            //   icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
            //       ? Icons.pause_circle
            //       : Icons.play_circle),
            // ),
            // IconButton(
            //   onPressed: () {
            //     loopSound();
            //   },
            //   iconSize: 50,
            //   icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
            //       ? Icons.pause_circle
            //       : Icons.play_circle),
            // ),
            // Text("Pause"),
            // IconButton(
            //   onPressed: () {
            //     pauseSound();
            //   },
            //   iconSize: 50,
            //   icon: Icon(audioPlayerState == AudioPlayerState.PLAYING
            //       ? Icons.pause_circle
            //       : Icons.play_circle),
            // ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Menu Data Guru",
              style: GoogleFonts.firaSans(
                  fontSize: 30,
                  color: HexColor('#2C3E50'),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
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
                  playSound();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PilihKelas(),
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
                  playSound();
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
                  playSound();
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
            // SizedBox(
            //   width: 300,
            //   height: 118.0,
            //   child: ElevatedButton(
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.resolveWith<Color>(
            //         (Set<MaterialState> states) {
            //           if (states.contains(MaterialState.pressed))
            //             return HexColor('#F55413');
            //           return HexColor(
            //               '#FF7138'); //F69A9A Use the component's default.
            //         },
            //       ),
            //     ),
            //     onPressed: () {
            //       // Navigator.pushNamed(context, LoginSiswa.routeName);
            //     },
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.supervised_user_circle,
            //           size: 36,
            //           color: Colors.white,
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           'Hasil Menulis',
            //           style: GoogleFonts.firaSans(
            //               fontSize: 18,
            //               color: HexColor('#FFFFFF'),
            //               fontWeight: FontWeight.w500),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}
