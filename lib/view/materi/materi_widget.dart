import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:rusa4/Utils/utils.dart';
import 'package:rusa4/model/materi.dart';
import 'package:rusa4/provider/email_sign_in.dart';
import 'package:rusa4/provider/materi_provider.dart';
import 'package:rusa4/view/materi/edit_materi.dart';
import 'package:rusa4/view/materi/see_materi.dart';

class MateriWidget extends StatelessWidget {
  final Materi materi;

  const MateriWidget({
    @required this.materi,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    Map allAkun;

    final user = provider.akun;
    allAkun = provider.listAkun;

    return user[9] == allAkun[materi.userID].id && user[7] == "Guru" ||
            user[9] == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3'
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              key: Key(materi.id),
              actions: [
                IconSlideAction(
                  color: Colors.green,
                  onTap: () => editMateri(context, materi),
                  caption: 'Ubah',
                  icon: Icons.edit,
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  color: Colors.red,
                  caption: 'Hapus',
                  onTap: () => deleteMateri(context, materi),
                  icon: Icons.delete,
                )
              ],
              child: buildMateri(context),
            ),
          )
        : buildMateri(context);
  }

  Widget buildMateri(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final user = provider.akun;

    final userRusa = provider.akunRusa;

    Map allAkun;

    allAkun = provider.listAkun;
    return Visibility(
      visible: cekGuru(userRusa, materi, allAkun),
      child: GestureDetector(
        onTap: () => seeMateri(context, materi),
        child: Card(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                const SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          DateFormat("EEEE, d MMMM yyyy", "id_ID")
                              .add_jm()
                              .format(materi.createdTime),
                          // Text(widget.feedMenulis.createdTime.day.toString(),
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500)),
                      ListTile(
                        title: Text(
                          materi.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 22,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              padding: allAkun[materi.userID].pic[8] != "f"
                                  ? EdgeInsets.all(12)
                                  : EdgeInsets.all(4),
                              child: allAkun[materi.userID].pic[8] != "f"
                                  ? Container(
                                      width: 30,
                                      height: 30,
                                      child: SvgPicture.network(
                                        allAkun[materi.userID].pic,
                                        semanticsLabel: 'Profil Pic',
                                        placeholderBuilder:
                                            (BuildContext context) => Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child:
                                                    const CircularProgressIndicator()),
                                      ),
                                    )
                                  : Container(
                                      width: 30,
                                      height: 30,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: NetworkImage(
                                              allAkun[materi.userID].pic),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(allAkun[materi.userID].username,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteMateri(BuildContext context, Materi materi) {
    final provider = Provider.of<MateriProvider>(context, listen: false);
    provider.removeMateri(materi);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Materi dihapus')),
    );
  }

  void editMateri(BuildContext context, Materi materi) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditMateriPage(materi: materi),
        ),
      );
  void seeMateri(BuildContext context, Materi materi) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SeeMateriPage(materi: materi),
        ),
      );

  cekGuru(userRusa, materi, allAkun) {
    if (userRusa.id == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3') {
      return true;
    } else {
      if (userRusa.emailGuru == allAkun[materi.userID].emailGuru ||
          materi.userID == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3') {
        return true;
      } else {
        return false;
      }
    }

    // userRusa.emailGuru == allAkun[materi.userID].emailGuru ||
    //           materi.userID == 'k1zCQTqC9KO2HMcH53b9j2HTc9E3'
  }
}
