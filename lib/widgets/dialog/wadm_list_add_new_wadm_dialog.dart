import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/wadms.dart';
import '../../i18n/messages.dart';

final msg = Messages();

class AddNewWadmDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wadmsProvider = Provider.of<Wadms>(context, listen: false);
    final wadmTitleController = TextEditingController();

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
        RaisedButton(
          child: Text(msg.dialogButtonCreate),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: () {
            wadmsProvider.addNewWadm(wadmTitleController.text);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
