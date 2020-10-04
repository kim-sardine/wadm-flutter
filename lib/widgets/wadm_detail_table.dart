import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final wadm = Provider.of<Wadms>(
      context,
    ).findById(wadmId);

    return StickyHeadersTable(
      cellDimensions: cellDimensions,
      columnsLength: wadm.candidates.length,
      rowsLength: wadm.categories.length + 1, // with Total
      columnsTitleBuilder: (i) => Container(
        height: cellDimensions.stickyLegendHeight,
        width: cellDimensions.contentCellWidth,
        child: CandidateFieldWidget(
          wadmId: wadmId,
          candidate: wadm.candidates[i],
        ),
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
                Text('Total'),
              ],
            ),
          );
        }
        return Container(
          height: cellDimensions.contentCellHeight,
          width: cellDimensions.stickyLegendWidth,
          child: CategoryFieldWidget(
            wadmId: wadmId,
            category: wadm.categories[i],
          ),
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
