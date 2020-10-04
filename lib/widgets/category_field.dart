import 'package:flutter/material.dart';

import '../models/category.dart';
import '../widgets/wadm_detail_category_modifing_dialog.dart';

class CategoryFieldWidget extends StatelessWidget {
  final String wadmId;
  final Category category;

  CategoryFieldWidget({this.wadmId, this.category});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.lightGreen,
      textColor: Colors.white,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: CategoryModifingDialogWidget(
              wadmId: wadmId,
              category: category,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            this.category.title,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            this.category.weight.toString(),
            style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}