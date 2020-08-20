import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';

class WadmDetailScreen extends StatelessWidget {

  static const routeName = '/wadm-detail';

  @override
  Widget build(BuildContext context) {
    final String wadmId = ModalRoute.of(context).settings.arguments;
    final wadm = Provider.of<Wadms>(
      context,
      listen: false,
    ).findById(wadmId);

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
      body: Container(
        height: 100,
        color: Colors.amber[100],
        child: Center(child: Text('${wadm.title}')),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        tooltip: 'Save',
        onPressed: () => {},
      ),
    );
  }
}
