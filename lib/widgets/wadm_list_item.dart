import 'package:flutter/material.dart';

import '../models/wadm.dart';

class WadmListItem extends StatelessWidget {
  final Wadm wadm;

  WadmListItem({this.wadm});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Color(0XFFffc13b),
      child: Center(child: Text('${wadm.title}')),
    );
  }
}
