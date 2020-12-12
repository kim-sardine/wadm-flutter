import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/wadms.dart';
import '../utils.dart';
import '../i18n/messages.dart';

final msg = Messages();

class ScoreFieldWidget extends StatelessWidget {
  final String wadmId;
  final int rowIdx;
  final int colIdx;

  ScoreFieldWidget({this.wadmId, this.rowIdx, this.colIdx});

  @override
  Widget build(BuildContext context) {
    final wadmsProvider = Provider.of<Wadms>(context, listen: false);
    final wadm = wadmsProvider.findById(wadmId);
    final cellValue = wadm.candidates[colIdx].scores[rowIdx];

    return Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        onChanged: (value) {
          final inputValue = int.parse(value);
          if (wadm.candidates[colIdx].scores[rowIdx] != inputValue) {
            wadm.candidates[colIdx].scores[rowIdx] = inputValue;
            wadmsProvider.updateWadm(wadm);
          }
        },
        controller: TextEditingController(text: cellValue.toString()),
        decoration: InputDecoration(
          hintText: msg.textInputLabelScore,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: categoryWeightInputFormatter,
      ),
    );
  }
}
