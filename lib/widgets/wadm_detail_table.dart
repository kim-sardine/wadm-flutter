import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:provider/provider.dart';
import 'package:wadm/models/wadm.dart';

import '../providers/wadms.dart';
import '../models/my_cell_dimensions.dart';
import './candidate_field.dart';
import './category_field.dart';
import './score_field.dart';

final cellDimensions = MyCellDimensions(
  contentCellWidth: 110,
  contentCellHeight: 70,
  stickyLegendWidth: 100,
  stickyLegendHeight: 60,
);

class WadmTable extends StatelessWidget {
  final String wadmId;

  WadmTable({this.wadmId});

  // void addCandidate(String title) {
  //   if (wadm.candidateTitleExists(title)) {
  //     // TODO: Show warning message
  //     print("exists!!");
  //     print(title);
  //     return;
  //   } else {
  //     wadm.addCandidate(title);
  //   }
  // }

  // void addCategory(String title, int weight) {
  //   Category newCategory = Category(title: title, weight: weight);

  //   for (Category registeredCategory in wadm.categories) {
  //     if (registeredCategory.isDuplicated(newCategory)) {
  //       // TODO: Show warning message
  //       print("exists!!");
  //       print(newCategory.title);
  //       return;
  //     }
  //   }

  //   setState(() {
  //     wadm.addCategory(newCategory);
  //   });
  // }

  // void setScore(int rowIdx, int colIdx, int score) {
  //   setState(() {
  //     wadm.candidates[colIdx].scores[rowIdx] = score;
  //   });
  // }

  void t(int a, int b, int c) {

  }

  @override
  Widget build(BuildContext context) {
    final wadm = Provider.of<Wadms>(
      context,
    ).findById(wadmId);
    print('rebuild');

    return StickyHeadersTable(
      cellDimensions: cellDimensions,
      columnsLength: wadm.candidates.length,
      rowsLength: wadm.categories.length + 1, // 항목 + 총합
      columnsTitleBuilder: (i) => Container(
        height: cellDimensions.stickyLegendHeight,
        width: cellDimensions.contentCellWidth,
        child: CandidateFieldWidget(candidate: wadm.candidates[i]),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
      ),
      rowsTitleBuilder: (i) {
        if (i == wadm.categories.length) {
          return Container(
            height: cellDimensions.contentCellHeight,
            width: cellDimensions.stickyLegendWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('총합'),
              ],
            ),
          );
        }
        return Container(
          height: cellDimensions.contentCellHeight,
          width: cellDimensions.stickyLegendWidth,
          child: CategoryFieldWidget(category: wadm.categories[i]),
          margin: EdgeInsets.symmetric(
            vertical: 5,
          ),
        );
      },
      contentCellBuilder: (colIdx, rowIdx) {
        // Row for Total
        if (rowIdx == wadm.categories.length) {
          return Text(wadm.getTotal(colIdx).toString());
        } else {
          return Container(
            height: cellDimensions.contentCellHeight,
            width: cellDimensions.contentCellWidth,
            child: ScoreFieldWidget(
              wadmId: wadmId,
              rowIdx: rowIdx,
              colIdx: colIdx,
            ),
            margin: EdgeInsets.symmetric(horizontal: 5),
          );
        }
      },
      legendCell: Text('항목 \\ 후보'),
    );
  }
}
