import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:rusa4/Utils/upload_file.dart';
import 'package:rusa4/provider/get_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zefyr/zefyr.dart';

class MateriFormWidget extends StatefulWidget {
  final String title;
  final String linkVideo;
  final String description;
  final String imagegan;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedlinkVideo;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedimagegan;
  final VoidCallback onSavedMateri;

  const MateriFormWidget({
    Key key,
    this.title = '',
    this.linkVideo = '',
    this.description = '',
    this.imagegan = '',
    @required this.onChangedTitle,
    @required this.onChangedlinkVideo,
    @required this.onChangedDescription,
    @required this.onChangedimagegan,
    @required this.onSavedMateri,
  }) : super(key: key);

  @override
  _MateriFormWidgetState createState() => _MateriFormWidgetState();
}

class _MateriFormWidgetState extends State<MateriFormWidget> {
  ZefyrController _zcontroller;

  FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final zdocument = _loadDocument();
    _zcontroller = ZefyrController(zdocument);
    _focusNode = FocusNode();
  }

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert("Rumah Sastra\n");
    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
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
            buildZDescription(),
            SizedBox(height: 16),
            buildButton(),
          ],
        ),
      );

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

  Widget buildZDescription() => ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16),
          controller: _zcontroller,
          focusNode: _focusNode,
        ),
        // maxLines: 20,
        // initialValue: widget.description,
        // onChanged: widget.onChangedDescription,
        // decoration: InputDecoration(
        //   border: UnderlineInputBorder(),
        //   labelText: 'Deskripsi',
        // ),
      );

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
    TextEditingController _imageganController = TextEditingController();
    final provider = Provider.of<GetImageProvider>(context, listen: false);

    // provider.getImage = urlDownload;
    _imageganController.text = provider.getImage;
    // imagegan = provider.getImage;

    return Visibility(
      visible: false,
      child: TextFormField(
        maxLines: 1,
        onChanged: widget.onChangedimagegan,
        controller: _imageganController,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Image',
        ),
      ),
    );
  }

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: widget.onSavedMateri,
          child: Text('Simpan'),
        ),
      );
}
