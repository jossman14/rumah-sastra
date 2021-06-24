import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class AudioProvider extends ChangeNotifier {
  final player = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  playLocal() async {
    int result = await audioPlayer.play('assets/audio/play.wav', isLocal: true);

    return result;
  }

  playBtn() {
    return player.play('assets/audio/play.wav');
  }

  get playGan => playLocal();
}
