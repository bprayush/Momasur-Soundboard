import 'package:flutter/widgets.dart';
import 'package:momasur/data/models/audio/AudioStates.dart';

class AudioModel {
  AudioState state;
  final String audioFile;
  final String name;
  final Color color;
  double volume;

  AudioModel(this.name, this.audioFile, this.color, {this.volume = 0.3}) {
    this.state = AudioState.stopped;
  }
}
