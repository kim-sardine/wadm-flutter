import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';

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
            decoration: InputDecoration(labelText: "Title"),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Text('Wadm 삭제'),
              color: Colors.deepOrange,
              onPressed: () {
                wadmsProvider.removeWadm(wadmId);

                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/wadm-list', (route) => false);
              },
            ),
            RaisedButton(
              child: Text('타이틀 수정'),
              color: Colors.lightGreen,
              onPressed: () {
                wadm.updateTitle(wadmTitleController.text);
                wadmsProvider.updateWadm(wadm);

                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
