import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusa4/model/feed_menulis.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/feed_materi.dart';
import 'package:rusa4/view/feed_menulis/feed_menulis_form.dart';

class AddFeedMenulisDialogWidget extends StatefulWidget {
  @override
  _AddFeedMenulisDialogWidgetState createState() =>
      _AddFeedMenulisDialogWidgetState();
}

class _AddFeedMenulisDialogWidgetState
    extends State<AddFeedMenulisDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah FeedMenulis'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.delete),
        //     onPressed: () {
        //       final provider =
        //           Provider.of<FeedMenulisProvider>(context, listen: false);
        //       provider.removeFeedMenulis(widget.feedMenulis);

        //       Navigator.of(context).pop();
        //     },
        //   )
        // ],
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
                onSavedFeedMenulis: addFeedMenulis,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addFeedMenulis() {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;

    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final feedMenulis = FeedMenulis(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
        modifTime: DateTime.now(),
        writer: user[2],
        kelas: user[2],
        guru: user[3],
        isComment: false,
        isLike: false,
        comment: [],
        like: [],
      );

      final provider = Provider.of<FeedMenulisProvider>(context, listen: false);
      provider.addFeedMenulis(feedMenulis);

      Navigator.of(context).pop();
    }
  }
}
