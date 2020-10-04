import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';
import '../models/candidate.dart';

class CandidateModifingWidget extends StatelessWidget {
  final String wadmId;
  final Candidate candidate;

  CandidateModifingWidget({this.wadmId, this.candidate});

  @override
  Widget build(BuildContext context) {
    final candidateController = TextEditingController(text: candidate.title);

    final wadmsProvider = Provider.of<Wadms>(context, listen: false);
    final wadm = wadmsProvider.findById(wadmId);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: candidateController,
          decoration: InputDecoration(labelText: "후보명"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RaisedButton(
              child: Text('삭제'),
              color: Colors.deepOrange,
              onPressed: () {
                wadm.removeCandidate(this.candidate.id);
                wadmsProvider.updateWadm(wadm);

                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text('수정'),
              color: Colors.lightGreen,
              onPressed: () {
                // Validation
                wadm.updateCandidate(
                    this.candidate.id, candidateController.text);
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
