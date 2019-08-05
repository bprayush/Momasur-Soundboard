import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:momasur/assets/assets.dart';
import 'package:momasur/data/models/audio/audio_model_export.dart';
import 'package:momasur/widgets/pad_widget/PadWidget.dart';

class AudioFX extends StatefulWidget {
  @override
  _AudioFXState createState() => _AudioFXState();
}

class _AudioFXState extends State<AudioFX> {
  AudioCache cachePlayer = AudioCache();

  List<AudioPlayer> audioPlayers = List<AudioPlayer>();

  List<StreamSubscription> streamSubs = List<StreamSubscription>();

  static List<String> audioModelKeys = [
    'village',
    'momasur',
    'cow-herd',
    'cow',
    'crow',
    'farm',
    'market',
    'thunder',
    'birds',
    'fire',
    'fun-flute',
    'fun-music',
    'fun-music-2',
    'happy-flute',
    'city',
    'sad-flute',
    'sad-flute-2',
    'ropai',
  ];

  Map<String, AudioModel> audioModels = {
    audioModelKeys[0]: AudioModel(
      'Village',
      AppAudio.VILLAGE,
      AppColors.DARK_BLUE,
    ),
    audioModelKeys[1]: AudioModel(
      'Momasur',
      AppAudio.BOSS,
      AppColors.DARK_GREEN,
    ),
    audioModelKeys[2]: AudioModel(
      'Cowherd',
      AppAudio.COWHERD,
      AppColors.DARK_PURPLE,
    ),
    audioModelKeys[3]: AudioModel(
      'Cow',
      AppAudio.COW,
      AppColors.LIGHT_BLUE,
    ),
    audioModelKeys[4]: AudioModel(
      'Crow',
      AppAudio.CROW,
      AppColors.randomColor,
    ),
    audioModelKeys[5]: AudioModel(
      'Farm',
      AppAudio.FARM,
      AppColors.randomColor,
    ),
    audioModelKeys[6]: AudioModel(
      'Market',
      AppAudio.MARKET,
      AppColors.randomColor,
    ),
    audioModelKeys[7]: AudioModel(
      'Thunder',
      AppAudio.THUNDER,
      AppColors.randomColor,
    ),
    audioModelKeys[8]: AudioModel(
      'Birds',
      AppAudio.BIRDS,
      AppColors.randomColor,
    ),
    audioModelKeys[9]: AudioModel(
      'Fire',
      AppAudio.FIRE,
      AppColors.randomColor,
    ),
    audioModelKeys[10]: AudioModel(
      'Fun Flute',
      AppAudio.FUN_FLUTE,
      AppColors.randomColor,
    ),
    audioModelKeys[11]: AudioModel(
      'Fun Music',
      AppAudio.FUN_MUSIC,
      AppColors.randomColor,
    ),
    audioModelKeys[12]: AudioModel(
      'Fun Music 2',
      AppAudio.FUN_MUSIC_2,
      AppColors.randomColor,
    ),
    audioModelKeys[13]: AudioModel(
      'Happy Flute',
      AppAudio.HAPPY_FLUTE,
      AppColors.randomColor,
    ),
    audioModelKeys[14]: AudioModel(
      'City',
      AppAudio.CITY,
      AppColors.randomColor,
    ),
    audioModelKeys[15]: AudioModel(
      'Sad Flute',
      AppAudio.SAD_FLUTE,
      AppColors.randomColor,
    ),
    audioModelKeys[16]: AudioModel(
      'Sad Flute 2',
      AppAudio.SAD_FLUTE_2,
      AppColors.randomColor,
    ),
    audioModelKeys[17]: AudioModel(
      'Ropai',
      AppAudio.ROPAI,
      AppColors.randomColor,
    ),
  };

  @override
  void initState() {
    super.initState();
    audioModelKeys.sort();
    cachePlayer.loadAll([
      AppAudio.BOSS,
      AppAudio.VILLAGE,
      AppAudio.COWHERD,
      AppAudio.COW,
      AppAudio.CROW,
      AppAudio.FARM,
      AppAudio.MARKET,
      AppAudio.THUNDER,
      AppAudio.BIRDS,
      AppAudio.CITY,
      AppAudio.FIRE,
      AppAudio.FUN_FLUTE,
      AppAudio.FUN_MUSIC,
      AppAudio.FUN_MUSIC_2,
      AppAudio.HAPPY_FLUTE,
      AppAudio.SAD_FLUTE,
      AppAudio.SAD_FLUTE_2,
      AppAudio.ROPAI,
    ]);
    for (int i = 0; i < audioModelKeys.length; i++) {
      audioPlayers.add(AudioPlayer());
      streamSubs.add(
        audioPlayers[i].onPlayerStateChanged.listen(
          (AudioPlayerState s) {
            print('CurrentPlayer State $i: ');
            print(s);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < streamSubs.length; i++) {
      streamSubs[i].cancel();
      audioPlayers[i].dispose();
      cachePlayer.clearCache();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: GridView.builder(
          itemCount: audioModelKeys.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                AudioModel audioModel = audioModels[audioModelKeys[index]];
                switch (audioModels[audioModelKeys[index]].state) {
                  case AudioState.looping:
                    break;
                  case AudioState.paused:
                    loop(audioModel, index);
                    break;
                  case AudioState.stopped:
                    loop(audioModel, index);
                    break;
                  case AudioState.playing:
                    break;
                  default:
                }
              },
              onTap: () async {
                AudioModel audioModel = audioModels[audioModelKeys[index]];
                switch (audioModels[audioModelKeys[index]].state) {
                  case AudioState.looping:
                    stop(audioModel, index);
                    break;
                  case AudioState.paused:
                    play(audioModel, index);
                    break;
                  case AudioState.stopped:
                    play(audioModel, index);
                    break;
                  case AudioState.playing:
                    stop(audioModel, index);
                    break;
                  default:
                }
              },
              child: AudioPad(
                audioModel: audioModels[audioModelKeys[index]],
                onChanged: (volume) {
                  setState(() {
                    audioModels[audioModelKeys[index]].volume = volume;
                    changeVolume(index, volume);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void play(AudioModel audioModel, int index) async {
    audioPlayers[index] = await cachePlayer.play(
      audioModel.audioFile,
      volume: audioModel.volume,
    );
    audioPlayers[index].onPlayerStateChanged.listen(
      (AudioPlayerState s) {
        print('CurrentPlayer State $index: ');
        print(s);
        if (s == AudioPlayerState.COMPLETED || s == AudioPlayerState.PAUSED)
          stop(audioModel, index);
      },
    );
    setState(() {
      audioModel.state = AudioState.playing;
    });
  }

  void stop(AudioModel audioModel, int index) async {
    await audioPlayers[index].stop();
    setState(() {
      audioModel.state = AudioState.stopped;
    });
  }

  void loop(AudioModel audioModel, int index) async {
    audioPlayers[index] = await cachePlayer.loop(
      audioModel.audioFile,
      volume: audioModel.volume,
    );
    setState(() {
      audioModel.state = AudioState.looping;
    });
  }

  void changeVolume(int index, double volume) {
    audioPlayers[index]?.setVolume(volume);
  }
}
