import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/wadms.dart';
import '../../utils.dart';
import '../../i18n/messages.dart';

final msg = Messages();

class DetailActionDialogWidget extends StatelessWidget {
  final String wadmId;
  final String detailScreenRouteName;

  DetailActionDialogWidget({this.wadmId, this.detailScreenRouteName});

  @override
  Widget build(BuildContext context) {
    final candidateController = TextEditingController();
    final categoryTitleController = TextEditingController();
    final catetoryWeightController = TextEditingController();

    final wadmsProvider = Provider.of<Wadms>(context, listen: false);
    final wadm = wadmsProvider.findById(wadmId);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Text(
            msg.dialogTitleSelectAction,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ActionButton(
              title: msg.dialogButtonAddCategory,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: categoryTitleController,
                          decoration: InputDecoration(
                              labelText: msg.dialogLabelCategoryTitle),
                        ),
                        TextField(
                          controller: catetoryWeightController,
                          decoration: InputDecoration(
                              labelText: msg.dialogLabelCategoryWeight),
                          keyboardType: TextInputType.number,
                          inputFormatters: categoryWeightInputFormatter,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                            child: Text(msg.dialogButtonAdd),
                            color: Colors.lightGreen,
                            onPressed: () {
                              wadm.addCategory(categoryTitleController.text,
                                  int.parse(catetoryWeightController.text));
                              wadmsProvider.updateWadm(wadm);

                              categoryTitleController.clear();
                              catetoryWeightController.clear();
                              Navigator.of(context)
                                  .popUntil(ModalRoute.withName(
                                this.detailScreenRouteName,
                              ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            ActionButton(
              title: msg.dialogButtonAddCandidate,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: candidateController,
                          decoration: InputDecoration(
                              labelText: msg.dialogLabelCandidateTitle),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: RaisedButton(
                            child: Text(msg.dialogButtonAdd),
                            color: Colors.lightGreen,
                            onPressed: () {
                              wadm.addCandidate(candidateController.text);
                              wadmsProvider.updateWadm(wadm);
                              candidateController.clear();
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName(
                                      this.detailScreenRouteName));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const ActionButton({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: RaisedButton(
        child: Padding(
          padding: EdgeInsets.all(0.5),
          child: FittedBox(fit: BoxFit.fitWidth, child: Text(this.title)),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
