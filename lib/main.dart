import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import './utils.dart';
import './models.dart';
import './widgets.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyTable(),
    );
  }
}

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  WadmTable wadmTable = WadmTable(candidates: [], categories: []);

  void addCandidate(String title) {
    if (this.wadmTable.candidateTitleExists(title)) {
      // TODO: Show warning message
      print("exists!!");
      print(title);
      return;
    } else {
      setState(() {
        this.wadmTable.addCandidate(title);
      });
    }
  }

  void addCategory(String title, int weight) {
    Category newCategory = Category(title: title, weight: weight);

    for (Category registeredCategory in this.wadmTable.categories) {
      if (registeredCategory.isDuplicated(newCategory)) {
        // TODO: Show warning message
        print("exists!!");
        print(newCategory.title);
        return;
      }
    }

    setState(() {
      this.wadmTable.addCategory(newCategory);
    });
  }

  void setScore(int rowIdx, int colIdx, int score) {
    setState(() {
      this.wadmTable.candidates[colIdx].scores[rowIdx] = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go Sardine - WADM'),
        backgroundColor: Colors.amber,
      ),
      body: StickyHeadersTable(
        cellDimensions: this.wadmTable.cellDimensions,
        columnsLength: this.wadmTable.candidates.length,
        rowsLength: this.wadmTable.categories.length + 1, // 항목 + 총합
        columnsTitleBuilder: (i) => Container(
          height: myCellDimensions.stickyLegendHeight,
          width: myCellDimensions.contentCellWidth,
          child: CandidateFieldWidget(candidate: this.wadmTable.candidates[i]),
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
        ),
        rowsTitleBuilder: (i) {
          if (i == this.wadmTable.categories.length) {
            return Container(
              height: myCellDimensions.contentCellHeight,
              width: myCellDimensions.stickyLegendWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('총합'),
                ],
              ),
            );
          }
          return Container(
            height: myCellDimensions.contentCellHeight,
            width: myCellDimensions.stickyLegendWidth,
            child: CategoryFieldWidget(category: this.wadmTable.categories[i]),
            margin: EdgeInsets.symmetric(
              vertical: 5,
            ),
          );
        },
        contentCellBuilder: (colIdx, rowIdx) {
          // Row for Total
          if (rowIdx == this.wadmTable.categories.length) {
            return Text(this.wadmTable.getTotal(colIdx).toString());
          } else {
            return Container(
              height: myCellDimensions.contentCellHeight,
              width: myCellDimensions.contentCellWidth,
              child: ScoreFieldWidget(
                rowIdx: rowIdx,
                colIdx: colIdx,
                parentAction: setScore,
                value: this.wadmTable.candidates[colIdx].scores[rowIdx],
              ),
              margin: EdgeInsets.symmetric(horizontal: 5),
            );
          }
        },
        legendCell: Text('항목 \\ 후보'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: FloatingActionWidget(
                addCategory: addCategory,
                addCandidate: addCandidate,
              ),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
