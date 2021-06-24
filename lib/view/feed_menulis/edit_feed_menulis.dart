import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/view/feed_menulis/feed_menulis_form.dart';
import 'package:rusa4/view/feed_menulis/see_feed_menulis.dart';

class EditFeedMenulisPage extends StatefulWidget {
  final FeedMenulis feedMenulis;

  const EditFeedMenulisPage({Key key, @required this.feedMenulis})
      : super(key: key);
  @override
  _EditFeedMenulisPageState createState() => _EditFeedMenulisPageState();
}

class _EditFeedMenulisPageState extends State<EditFeedMenulisPage> {
  final _formKey = GlobalKey<FormState>();

  String title;
  String description;

  FeedMenulis hasil;

  @override
  void initState() {
    super.initState();

    title = widget.feedMenulis.title;
    description = widget.feedMenulis.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Feed Menulis'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<FeedMenulisProvider>(context, listen: false);
                provider.removeFeedMenulis(widget.feedMenulis);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: FeedMenulisFormWidget(
                  title: title,
                  description: description,
                  onChangedTitle: (title) => setState(() => this.title = title),
                  onChangedDescription: (description) =>
                      setState(() => this.description = description),
                  onSavedFeedMenulis: saveFeedMenulis,
                ),
              ),
            ),
          ),
        ),
      );

  void saveFeedMenulis() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<FeedMenulisProvider>(context, listen: false);
      provider.updateFeedMenulis(widget.feedMenulis, title, description);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  SeeFeedMenulisPage(feedMenulis: widget.feedMenulis)));
    }
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
