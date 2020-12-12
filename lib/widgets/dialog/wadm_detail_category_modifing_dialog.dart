import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/wadms.dart';
import '../../models/category.dart';
import '../../utils.dart';
import '../../i18n/messages.dart';

final msg = Messages();

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
                decoration: InputDecoration(labelText: msg.dialogLabelCategoryTitle),
              ),
              TextField(
                controller: catetoryWeightController,
                decoration: InputDecoration(labelText: msg.dialogLabelCategoryWeight),
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
              child: Text(msg.dialogButtonDelete),
              color: Colors.deepOrange,
              onPressed: () {
                wadm.removeCategory(category.id);
                wadmsProvider.updateWadm(wadm);

                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text(msg.dialogButtonUpdate),
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
