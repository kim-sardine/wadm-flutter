import 'package:flutter/material.dart';

import '../models/candidate.dart';
import 'dialog/wadm_detail_candidate_modifing_dialog.dart';

class CandidateFieldWidget extends StatelessWidget {
  final String wadmId;
  final Candidate candidate;

  CandidateFieldWidget({this.wadmId, this.candidate});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.cyan,
      textColor: Colors.white,
      padding: EdgeInsets.all(4.0),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: CandidateModifingDialogWidget(
              wadmId: wadmId,
              candidate: candidate,
            ),
          ),
        );
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
