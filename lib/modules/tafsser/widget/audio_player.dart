import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/styles_manager.dart';
import 'package:path/path.dart' as path;

class AudioCard extends StatefulWidget {
  final String audioUrl;

  const AudioCard({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioCardState createState() => _AudioCardState();
}

class _AudioCardState extends State<AudioCard> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed || state == PlayerState.stopped) {
        if (mounted) {
          setState(() {
            _isPlaying = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.play(
        UrlSource(widget.audioUrl),
      );
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleAudio,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(path.basename(widget.audioUrl),
                style: getRegularStyle(
                  color: ColorsManager.primaryDarkPurple,
                )),
            Icon(
              _isPlaying ? Icons.stop : Icons.play_arrow,
              color: ColorsManager.primaryDarkPurple,
            ),
          ],
        ),
      ),
    );
  }
}
