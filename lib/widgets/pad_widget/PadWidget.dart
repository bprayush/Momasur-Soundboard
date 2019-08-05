import 'package:flutter/material.dart';
import 'package:momasur/assets/assets.dart';
import 'package:momasur/data/models/audio/audio_model_export.dart';

class AudioPad extends StatefulWidget {
  final AudioModel audioModel;
  final Function onChanged;

  AudioPad({
    Key key,
    @required this.audioModel,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _AudioPadState createState() => _AudioPadState();
}

class _AudioPadState extends State<AudioPad> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 500,
      ),
      margin: EdgeInsets.only(
        bottom: 5,
      ),
      curve: Curves.ease,
      decoration: BoxDecoration(
        color: widget.audioModel.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.black12,
            offset: Offset(0, 1),
            spreadRadius: 1,
          )
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${widget.audioModel.name}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (widget.audioModel.state == AudioState.stopped ||
                    widget.audioModel.state == AudioState.paused)
                  Expanded(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                if (widget.audioModel.state == AudioState.playing)
                  Expanded(
                    child: Icon(
                      Icons.stop,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                if (widget.audioModel.state == AudioState.looping)
                  Container(
                    width: 120,
                    height: 100,
                    alignment: Alignment.center,
                    child: Theme(
                      data: ThemeData(
                        accentColor: AppColors.WHITISH_GREY,
                      ),
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                RotatedBox(
                  quarterTurns: 3,
                  child: Slider(
                    onChanged: widget.onChanged,
                    value: widget.audioModel.volume,
                    min: 0,
                    max: 1.0,
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
