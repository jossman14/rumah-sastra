import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/provider/email_sign_in.dart';

import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/audioGan.dart';
import 'package:rusa4/view/materi/edit_materi.dart';
import 'package:url_launcher/url_launcher.dart';
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
  String link;

  @override
  void initState() {
    super.initState();

    title = widget.materi.title;
    linkVideo = widget.materi.linkVideo;
    description = widget.materi.description;
    imagegan = widget.materi.imagegan;
    link = widget.materi.link;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: user[7] == "Guru"
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    playSound();
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
                    playSound();
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
              padding: EdgeInsets.all(27),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 27,
                      ),
                    ),
                    SizedBox(height: 20),
                    buildYoutube(),
                    SizedBox(height: 15),
                    Visibility(
                        visible: imagegan == "" ? false : true,
                        child: Image.network(imagegan)),
                    SizedBox(height: 20),
                    Text(
                      description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    openLink(link),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget openLink(link) => Linkify(
        onOpen: _onOpen,
        text: link,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      );

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
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
