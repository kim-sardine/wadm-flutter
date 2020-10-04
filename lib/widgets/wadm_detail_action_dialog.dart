import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';
import '../utils.dart';

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
            "원하는 동작을 선택해주세요",
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
            RaisedButton(
              child: Text('항목 추가'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: categoryTitleController,
                          decoration:
                              InputDecoration(labelText: "항목명"),
                        ),
                        TextField(
                          controller: catetoryWeightController,
                          decoration: InputDecoration(
                              labelText: "가중치 (1~10)"),
                          keyboardType: TextInputType.number,
                          inputFormatters: categoryWeightInputFormatter,
                        ),
                        RaisedButton(
                          child: Text('항목 추가'),
                          onPressed: () {
                            wadm.addCategory(categoryTitleController.text, int.parse(catetoryWeightController.text));
                            wadmsProvider.updateWadm(wadm);

                            categoryTitleController.clear();
                            catetoryWeightController.clear();
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName(this.detailScreenRouteName));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text('후보 추가'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: candidateController,
                          decoration:
                              InputDecoration(labelText: "후보명"),
                        ),
                        RaisedButton(
                          child: Text('항목 추가'),
                          onPressed: () {
                            wadm.addCandidate(candidateController.text);
                            wadmsProvider.updateWadm(wadm);
                            candidateController.clear();
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName(this.detailScreenRouteName));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
