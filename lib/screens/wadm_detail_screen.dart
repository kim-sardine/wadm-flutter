import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';
import '../widgets/wadm_detail_table.dart';
import '../widgets/wadm_detail_alert_modal.dart';

class WadmDetailScreen extends StatelessWidget {

  static const routeName = '/wadm-detail';

  @override
  Widget build(BuildContext context) {
    final String wadmId = ModalRoute.of(context).settings.arguments;
    // final wadm = Provider.of<Wadms>(
    //   context,
    //   listen: false,
    // ).findById(wadmId);

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
      body: WadmTable(wadmId: wadmId),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        tooltip: 'Save',
        onPressed: () => {},
      ),
    );
  }
}
