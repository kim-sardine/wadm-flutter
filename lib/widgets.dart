import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './utils.dart';
import './models.dart';

class ScoreFieldWidget extends StatelessWidget {
  final void Function(int, int, int) parentAction;
  final int rowIdx;
  final int colIdx;

  ScoreFieldWidget({this.rowIdx, this.colIdx, this.parentAction});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        print('rowIdx : ' + this.rowIdx.toString());
        print('colIdx : ' + this.colIdx.toString());
        parentAction(this.rowIdx, this.colIdx, int.parse(value));
        print('changed ' + value);
      },
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

