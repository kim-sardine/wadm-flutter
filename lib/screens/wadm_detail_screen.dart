import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';
import '../widgets/wadm_detail_table.dart';
import '../widgets/dialog/wadm_detail_action_dialog.dart';
import '../widgets/dialog/wadm_detail_edit_dialog.dart';

class WadmDetailScreen extends StatelessWidget {
  static const routeName = '/wadm-detail';

  @override
  Widget build(BuildContext context) {
    final String wadmId = ModalRoute.of(context).settings.arguments;
    final wadm = Provider.of<Wadms>(context).findById(wadmId);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            wadm.title,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).accentColor,
              tooltip: 'Edit Wadm',
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: EditDialogWidget(wadmId: wadmId),
                  ),
                )
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Theme.of(context).accentColor,
              tooltip: 'Add element',
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: DetailActionDialogWidget(
                      wadmId: wadmId,
                      detailScreenRouteName: routeName,
                    ),
                  ),
                )
              },
            ),
          ],
        ),
        body: WadmTable(wadmId: wadmId),
      ),
      onWillPop: () async {
        Navigator.pop(context);
        wadm.sortCandidate();
        return false;
      },
    );
  }
}
