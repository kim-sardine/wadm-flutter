import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './utils.dart';
import './models.dart';

class ScoreFieldWidget extends StatelessWidget {
  final void Function(int, int, int) parentAction;
  final int rowIdx;
  final int colIdx;
  final int value;

  ScoreFieldWidget({this.rowIdx, this.colIdx, this.parentAction, this.value});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        print('rowIdx : ' + this.rowIdx.toString());
        print('colIdx : ' + this.colIdx.toString());
        parentAction(this.rowIdx, this.colIdx, int.parse(value));
        print('changed ' + value);
      },
      controller: TextEditingController(text: this.value.toString()),
      decoration: InputDecoration(labelText: "점수 (1~10)"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        FromOneToTenTextInputFormatter(),
      ],
    );
  }
}

class CandidateFieldWidget extends StatelessWidget {
  final Candidate candidate;

  CandidateFieldWidget({this.candidate});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.cyan,
      textColor: Colors.white,
      padding: EdgeInsets.all(4.0),
      onPressed: () {
        /* 내용 수정 기능 추가 */
      },
      child: Text(
        this.candidate.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

class CategoryFieldWidget extends StatelessWidget {
  final Category category;

  CategoryFieldWidget({this.category});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.lightGreen,
      textColor: Colors.white,
      onPressed: () {
        /* 내용 수정 기능 추가 */
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

class FloatingActionWidget extends StatelessWidget {
  final void Function(String) addCandidate;
  final void Function(String, int) addCategory;

  FloatingActionWidget({this.addCandidate, this.addCategory});

  @override
  Widget build(BuildContext context) {
    final candidateController = TextEditingController();
    final categoryTitleController = TextEditingController();
    final catetoryWeightController = TextEditingController();

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
                            addCategory(
                              categoryTitleController.text,
                              int.parse(
                                  catetoryWeightController.text),
                            );
                            categoryTitleController.clear();
                            catetoryWeightController.clear();
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
                            addCandidate(candidateController.text);
                            candidateController.clear();
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
      ],
    );
  }
}
