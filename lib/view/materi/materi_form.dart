import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/Utils/upload_file.dart';
import 'package:rusa4/provider/get_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MateriFormWidget extends StatefulWidget {
  final String title;
  final String linkVideo;
  final String description;
  final String imagegan;
  final String link;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedlinkVideo;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedimagegan;
  final ValueChanged<String> onChangedlink;
  final VoidCallback onSavedMateri;

  const MateriFormWidget({
    Key key,
    this.title = '',
    this.linkVideo = '',
    this.description = '',
    this.imagegan = '',
    this.link = '',
    @required this.onChangedTitle,
    @required this.onChangedlinkVideo,
    @required this.onChangedDescription,
    @required this.onChangedimagegan,
    @required this.onChangedlink,
    @required this.onSavedMateri,
  }) : super(key: key);

  @override
  _MateriFormWidgetState createState() => _MateriFormWidgetState();
}

class _MateriFormWidgetState extends State<MateriFormWidget> {
  @override
  Widget build(BuildContext context) {
    print("hasil widget.link ${widget.title}");

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(height: 8),
          buildYoutube(),
          SizedBox(height: 8),
          UploadPage(),
          buildImage(context),
          SizedBox(height: 8),
          widget.imagegan.length > 2 && widget.imagegan[8] == "f"
              ? showImage(context, widget.imagegan)
              : Container(),
          SizedBox(height: 16),
          buildDescription(),
          SizedBox(height: 16),
          buildLink(),
          SizedBox(height: 16),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
        onChanged: widget.onChangedTitle,
        validator: (title) {
          if (title.isEmpty) {
            return 'Judul tidak boleh kosong';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Judul',
        ),
      );

  Widget buildYoutube() {
    String videoID = cekIdYT();
    bool cekVideoID = videoID != null ? true : false;
    return Column(
      children: [
        TextFormField(
          maxLines: 1,
          initialValue: widget.linkVideo,
          onChanged: widget.onChangedlinkVideo,
          validator: (title) {
            if (title.isEmpty) {
              return 'Link video tidak boleh kosong';
            }
            return null;
          },
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Link Video Youtube',
          ),
        ),
        SizedBox(height: 8),
        Visibility(
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
        ),
      ],
    );
  }

  cekIdYT() {
    try {
      String videoID = YoutubePlayer.convertUrlToId(widget.linkVideo);
      return videoID;
    } on Exception catch (exception) {
      print(exception);
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Widget buildDescription() => TextFormField(
        maxLines: 20,
        initialValue: widget.description,
        onChanged: widget.onChangedDescription,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Deskripsi',
        ),
      );
  Widget buildLink() => TextFormField(
        maxLines: 8,
        initialValue: widget.link,
        onChanged: widget.onChangedlink,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText:
              'Link latihan (bisa lebih dari satu, beri koma untuk memisahkan)',
        ),
      );
  Widget buildzDescription() => Linkify(
        onOpen: _onOpen,
        text:
            "Made by https://cretezy.com \n\nMail: example@gmail.com \n\n  this is test http://pub.dev/ ",
      );

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  showImage(BuildContext context, file) {
    Text(
      'Gambar Asli',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
    return Image.network(
      file,
      fit: BoxFit.cover,
    );
  }

  Widget buildImage(BuildContext context) {
    // TextEditingController _imageganController = TextEditingController();

    // provider.getImage = urlDownload;
    // _imageganController.text = provider.getImage;
    // imagegan = provider.getImage;

    return Visibility(
      visible: false,
      // child: TextFormField(
      //   maxLines: 1,
      //   initialValue: widget.imagegan,
      //   onChanged: widget.onChangedimagegan,
      //   decoration: InputDecoration(
      //     border: UnderlineInputBorder(),
      //     labelText: 'Image',
      //   ),
      // ),
      child: TextFormField(
        maxLines: 1,
        initialValue: widget.imagegan,
        onChanged: widget.onChangedimagegan,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Gambar',
        ),
      ),
    );
  }

  Widget buildButton() {
    final provider = Provider.of<GetImageProvider>(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              provider.selesai == true ? Colors.black : Colors.grey),
        ),
        // onPressed: provider.selesai == true ? widget.onSavedMateri : null,
        onPressed: cekUpload(provider.selesai),
        // onPressed: widget.onSavedMateri,
        child: Text('Simpan'),
      ),
    );
  }

  cekUpload(bool sudah) {
    final provider = Provider.of<GetImageProvider>(context);

    if (widget.title != null) {
      provider.selesai = false;
      return widget.onSavedMateri;
    }

    if (sudah) {
      provider.selesai = false;
      return widget.onSavedMateri;
    } else {
      return null;
    }
  }
}
