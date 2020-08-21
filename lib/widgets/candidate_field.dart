import 'package:flutter/material.dart';

import '../models/candidate.dart';

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
