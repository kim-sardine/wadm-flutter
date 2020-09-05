import 'package:flutter/material.dart';

import '../widgets/wadm_detail_table.dart';

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
            onPressed: () => {},
          )
        ],
      ),
      body: WadmTable(wadmId: wadmId)
    );
  }
}
