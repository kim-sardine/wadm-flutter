import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/wadms.dart';
import '../../i18n/messages.dart';

final msg = Messages();

class EditDialogWidget extends StatelessWidget {
  final String wadmId;

  EditDialogWidget({this.wadmId});

  @override
  Widget build(BuildContext context) {
    final wadmsProvider = Provider.of<Wadms>(context, listen: false);
    final wadm = wadmsProvider.findById(wadmId);

    final wadmTitleController = TextEditingController(text: wadm.title);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: TextField(
            controller: wadmTitleController,
            decoration: InputDecoration(labelText: msg.dialogLabelWadmTitle),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: RaisedButton(
                child: Text(msg.dialogButtonDeleteWadm),
                color: Colors.deepOrange,
                onPressed: () {
                  wadmsProvider.removeWadm(wadmId);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/wadm-list', (route) => false);
                },
              ),
            ),
            Spacer(),
            Expanded(
              flex: 4,
              child: RaisedButton(
                child: Text(msg.dialogButtonUpdateWadmTitle),
                color: Colors.lightGreen,
                onPressed: () {
                  wadm.updateTitle(wadmTitleController.text);
                  wadmsProvider.updateWadm(wadm);

                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
