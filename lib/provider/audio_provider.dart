import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class AudioProvider extends ChangeNotifier {
  // final player = AudioCache();
  // AudioPlayer audioPlayer = AudioPlayer();

  // playLocal() async {
  //   int result = await audioPlayer.play('assets/audio/play.wav', isLocal: true);

  //   return result;
  // }

  // playBtn() {
  //   return player.play('assets/audio/play.wav');
  // }

  // get playGan => playLocal();

  int _cekSoalProvider = 0;

  int get cekSoalProvider => _cekSoalProvider;

  set cekSoalProvider(int value) {
    _cekSoalProvider = _cekSoalProvider + value;
    print("hasil tambah ceksoal $_cekSoalProvider");

    notifyListeners();
  }

  set resetSoalProvider(int value) {
    _cekSoalProvider = value;
    notifyListeners();
  }

  List _jawaban = [];

  List get jawaban => _jawaban;

  set tambahJawaban(bool value) {
    print("hasil tambah value $value");
    _jawaban.add(value);
    print("hasil tambah jawaban $_jawaban");
    // notifyListeners();
  }

  set resetJawaban(bool value) {
    print("hasil tambah value $value");
    _jawaban = [];
    print("hasil tambah jawaban $_jawaban");
    // notifyListeners();
  }
}
