import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';

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
            decoration: InputDecoration(labelText: "Title"),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        RaisedButton(
          child: Text('Create'),
          color: Colors.blue,
          onPressed: () {
            wadmsProvider.addNewWadm(wadmTitleController.text);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
