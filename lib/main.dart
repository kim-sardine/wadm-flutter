import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import './utils.dart';

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

class Category {
  String title;
  int weight;

  Category({this.title, this.weight});

  bool isDuplicated(Category category) {
    return this.title == category.title;
  }
}

class Candidate {
  String title;
  List<int> scores;

  Candidate({this.title, this.scores});
}

const CellDimensions myCellDimensions = CellDimensions(
  contentCellWidth: 110,
  contentCellHeight: 70,
  stickyLegendWidth: 100,
  stickyLegendHeight: 60,
);

class WadmTable {
  List<Candidate> candidates;
  List<Category> categories;
  CellDimensions cellDimensions;

  WadmTable({
    this.candidates,
    this.categories,
    this.cellDimensions = myCellDimensions,
  });

  void sort() {
    print('sorted!!');
  }

  bool candidateTitleExists(String title) {
    for (var candidate in this.candidates) {
      if (candidate.title == title) {
        return true;
      }
    }
    return false;
  }

  void addCandidate(String title) {
    Candidate newCandidate = Candidate(
        title: title,
        scores: List<int>.filled(this.categories.length, 0, growable: true));
    this.candidates.add(newCandidate);
  }

  void addCategory(Category category) {
    this.categories.add(category);
    for (var candidate in this.candidates) {
      candidate.scores.add(0);
    }
    this.sort();
  }
}

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  WadmTable wadmTable = WadmTable(candidates: [], categories: []);

  final candidateController = TextEditingController();
  final categoryTitleController = TextEditingController();
  final catetoryWeightController = TextEditingController();

  void addCandidate(String title) {
    if (wadmTable.candidateTitleExists(title)) {
      print("exists!!");
      print(title);
      return;
    } else {
      setState(() {
        wadmTable.addCandidate(title);
      });
    }
  }

  void addCategory({String title, int weight}) {
    Category newCategory = Category(title: title, weight: weight);

    for (Category registeredCategory in wadmTable.categories) {
      if (registeredCategory.isDuplicated(newCategory)) {
        print("exists!!");
        print(newCategory.title);
        return;
      }
    }

    setState(() {
      wadmTable.addCategory(newCategory);
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
        cellDimensions: wadmTable.cellDimensions,
        columnsLength: wadmTable.candidates.length,
        rowsLength: wadmTable.categories.length + 1, // 항목 + 총합
        columnsTitleBuilder: (i) => Container(
          height: myCellDimensions.stickyLegendHeight,
          width: myCellDimensions.contentCellWidth,
          child: CandidateFieldWidget(candidate: this.wadmTable.candidates[i]),
          margin: EdgeInsets.symmetric(
            horizontal: 5,
          ),
        ),
        rowsTitleBuilder: (i) {
          if (i == wadmTable.categories.length) {
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
        contentCellBuilder: (i, j) {
          // Row for Total
          if (j == wadmTable.categories.length) {
            return Text(i.toString());
          } else {
            return Container(
              height: myCellDimensions.contentCellHeight,
              width: myCellDimensions.contentCellWidth / 2,
              child: ScoreFieldWidget(),
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
              content: Column(
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
                                    decoration:
                                        InputDecoration(labelText: "가중치"),
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
                                        title: categoryTitleController.text,
                                        weight: int.parse(
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

class ScoreFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (q) {
        print('changed ' + q);
      },
      decoration: InputDecoration(labelText: "점수"),
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
        /*...*/
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
        /*...*/
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
