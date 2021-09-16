// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:audioplayers/audio_cache.dart';

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

    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  set resetSoalProvider(int value) {
    _cekSoalProvider = value;

    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
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
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  List _optionSelected = [];

  List get optionSelected => _optionSelected;

  set tambahoptionSelected(String value) {
    print("hasil tambah value $value");
    _optionSelected.add(value);
    print("hasil tambah optionSelected $_optionSelected");

    // notifyListeners();
  }

  set resetoptionSelected(String value) {
    print("hasil tambah value $value");
    _optionSelected = [];
    print("hasil tambah optionSelected $_optionSelected");
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  List _correctAnswer = [];

  List get correctAnswer => _correctAnswer;

  set tambahcorrectAnswer(String value) {
    print("hasil tambah value $value");
    _correctAnswer.add(value);
    print("hasil tambah correctAnswer $_correctAnswer");

    // notifyListeners();
  }

  set resetcorrectAnswer(String value) {
    print("hasil tambah value $value");
    _correctAnswer = [];
    print("hasil tambah correctAnswer $_correctAnswer");
    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }
}
