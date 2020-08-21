import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';
import '../sharedPref.dart';
import '../models/wadm_table.dart';

class FloatingActionWidget extends StatelessWidget {
  // final void Function(String) addCandidate;
  // final void Function(String, int) addCategory;
  // final WadmTable wadmTable;

  // FloatingActionWidget({this.addCandidate, this.addCategory, this.wadmTable});

  @override
  Widget build(BuildContext context) {
    final candidateController = TextEditingController();
    final categoryTitleController = TextEditingController();
    final catetoryWeightController = TextEditingController();
    SharedPref sharedPref = SharedPref();

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
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly,
                            FromOneToTenTextInputFormatter(),
                          ],
                        ),
                        RaisedButton(
                          child: Text('항목 추가'),
                          onPressed: () {
                            // addCategory(
                            //   categoryTitleController.text,
                            //   int.parse(
                            //       catetoryWeightController.text),
                            // );
                            // categoryTitleController.clear();
                            // catetoryWeightController.clear();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
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
                            // addCandidate(candidateController.text);
                            // candidateController.clear();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                // print(this.wadmTable.toJson());
                // sharedPref.save("house", this.wadmTable.toJson());
              },
              child: Text('Save', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ],
    );
  }
}
