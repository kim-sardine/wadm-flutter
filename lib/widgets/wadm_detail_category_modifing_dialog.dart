import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';
import '../models/category.dart';
import '../utils.dart';

class CategoryModifingDialogWidget extends StatelessWidget {
  final String wadmId;
  final Category category;

  CategoryModifingDialogWidget({this.wadmId, this.category});

  @override
  Widget build(BuildContext context) {
    final categoryTitleController = TextEditingController(text: category.title);
    final catetoryWeightController =
        TextEditingController(text: category.weight.toString());

    final wadmsProvider = Provider.of<Wadms>(context, listen: false);
    final wadm = wadmsProvider.findById(wadmId);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Column(
            children: [
              TextField(
                controller: categoryTitleController,
                decoration: InputDecoration(labelText: "항목명"),
              ),
              TextField(
                controller: catetoryWeightController,
                decoration: InputDecoration(labelText: "가중치 (1~10)"),
                keyboardType: TextInputType.number,
                inputFormatters: categoryWeightInputFormatter,
              ),
            ],
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Text('삭제'),
              color: Colors.deepOrange,
              onPressed: () {
                wadm.removeCategory(category.id);
                wadmsProvider.updateWadm(wadm);

                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text('수정'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                wadm.updateCategory(
                  category.id,
                  categoryTitleController.text,
                  int.parse(catetoryWeightController.text),
                );
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
