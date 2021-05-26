import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/provider/email_sign_in.dart';

import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/materi/edit_materi.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SeeMateriPage extends StatefulWidget {
  final Materi materi;

  const SeeMateriPage({Key key, @required this.materi}) : super(key: key);
  @override
  _SeeMateriPageState createState() => _SeeMateriPageState();
}

class _SeeMateriPageState extends State<SeeMateriPage> {
  String title;
  String linkVideo;
  String description;
  String imagegan;

  @override
  void initState() {
    super.initState();

    title = widget.materi.title;
    linkVideo = widget.materi.linkVideo;
    description = widget.materi.description;
    imagegan = widget.materi.imagegan;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    return Scaffold(
      appBar: AppBar(
        title: Text('See Materi'),
        actions: user[7] == "Guru"
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            EditMateriPage(materi: widget.materi),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    final provider =
                        Provider.of<MateriProvider>(context, listen: false);
                    provider.removeMateri(widget.materi);

                    Navigator.of(context).pop();
                  },
                )
              ]
            : null,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 15),
                  buildYoutube(),
                  SizedBox(height: 15),
                  Image.network(imagegan),
                  SizedBox(height: 15),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildYoutube() {
    String videoID = cekIdYT();
    bool cekVideoID = videoID != null ? true : false;
    return Visibility(
      visible: cekVideoID,
      child: YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoID == null ? 'OqP2eWmOsw0' : videoID,
          flags: YoutubePlayerFlags(
            hideControls: false,
            controlsVisibleAtStart: true,
            autoPlay: false,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: HexColor('#d35400'),
      ),
    );
  }

  cekIdYT() {
    try {
      String videoID = YoutubePlayer.convertUrlToId(linkVideo);
      return videoID;
    } on Exception catch (exception) {
      print(exception);
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
