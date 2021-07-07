import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SoundManager {
  AudioPlayer audioPlayer = new AudioPlayer();
  AudioPlayer instance = new AudioPlayer();
  AudioCache musicCache;
  // AudioPlayer instance;

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

  playLoopedMusic() async {
    musicCache = AudioCache();
    instance = await musicCache.loop("audio.mp3");
    // await instance.setVolume(0.5); you can even set the volume
  }

  pauseLoopedMusic() async {
    if (instance == null) {
      instance.pause();
    }
    // await instance.setVolume(0.5); you can even set the volume
  }
}

SoundManager soundManager = new SoundManager();

playSound() {
  soundManager.playLocal().then((onValue) {
    //do something?
  });
}

loopSound() {
  soundManager.playLoopedMusic().then((onValue) {
    //do something?
  });
}
pauseSound() {
  soundManager.pauseLoopedMusic().then((onValue) {
    //do something?
  });
}
