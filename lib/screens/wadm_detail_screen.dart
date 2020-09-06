import 'package:flutter/material.dart';

import '../widgets/wadm_detail_table.dart';
import '../widgets/wadm_detail_action_dialog.dart';

class WadmDetailScreen extends StatelessWidget {

  static const routeName = '/wadm-detail';

  @override
  Widget build(BuildContext context) {
    final String wadmId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Wadm Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'wadm action',
            onPressed: () => {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: DetailActionDialogWidget(wadmId: wadmId, detailScreenRouteName: routeName,),
                ),
              )
            },
          )
        ],
      ),
      body: WadmTable(wadmId: wadmId)
    );
  }
}
