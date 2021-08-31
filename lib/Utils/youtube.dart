import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerContainer extends StatefulWidget {
  const YoutubePlayerContainer({Key key, @required this.youtubeController})
      : super(key: key);

  final YoutubePlayerController youtubeController;

  @override
  _YoutubePlayerContainerState createState() => _YoutubePlayerContainerState();
}

class _YoutubePlayerContainerState extends State<YoutubePlayerContainer> {
  int _rotation;
  @override
  void initState() {
    _rotation = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotatedBox(
        quarterTurns: _rotation,
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: YoutubePlayer(
                bottomActions: <Widget>[
                  IconButton(
                    icon: Icon(
                      _rotation == 0 ? Icons.fullscreen : Icons.fullscreen_exit,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      widget.youtubeController.pause();
                      if (_rotation == 0) {
                        setState(() {
                          _rotation = 1;
                        });
                      } else {
                        setState(() {
                          _rotation = 0;
                        });
                      }
                    },
                  ),
                  RemainingDuration(),
                  ProgressBar(isExpanded: true),
                  CurrentPosition(),
                ],
                controller: widget.youtubeController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Theme.of(context).primaryColor,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.youtubeController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
