import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';
import '../widgets/wadm_list_item.dart';
import './wadm_detail_screen.dart';

class WadmListScreen extends StatelessWidget {

  static const routeName = '/wadm-list';

  @override
  Widget build(BuildContext context) {
    final wadms = context.watch<Wadms>().wadms;

    return Scaffold(
      appBar: AppBar(
        title: Text('Wadm List'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: wadms.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                WadmDetailScreen.routeName,
                arguments: wadms[index].id,
              );
            },
            child: WadmListItem(wadm: wadms[index])
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
