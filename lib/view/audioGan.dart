import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SoundManager {
  AudioPlayer audioPlayer = new AudioPlayer();

  Future playLocal({localFileName = 'audio.mp3'}) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = new File("${dir.path}/$localFileName");
    if (!(await file.exists())) {
      final soundData = await rootBundle.load("assets/$localFileName");
      final bytes = soundData.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
    }
    await audioPlayer.play(file.path, isLocal: true);
  }
}

SoundManager soundManager = new SoundManager();

playSound() {
  soundManager.playLocal().then((onValue) {
    //do something?
  });
}

