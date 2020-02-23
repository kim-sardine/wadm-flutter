import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

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
}

class Candidate {
  String title;
  List<int> score;

  Candidate({this.title, this.score});
}

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  List<Candidate> _candidates = [];
  List<Category> _categories = [Category(title: '위치', weight: 3)];

  void addCandidate(String title) {
    Candidate newCandidate = Candidate(
      title: title,
      score: List<int>.filled(_categories.length, 0, growable: true),
    );

    setState(() {
      _candidates.add(newCandidate);
    });
  }

  void addCategory(Category category) {
    setState(() {
      _categories.add(category);

      for (Candidate candidate in _candidates) {
        candidate.score.add(0);
      }
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
        columnsLength: _candidates.length,
        rowsLength: _categories.length + 1, // 항목 + 총합
        columnsTitleBuilder: (i) => Container(
          height: 50,
          width: 50,
          child: CandidateFieldWidget(),
        ),
        rowsTitleBuilder: (i) {
          if (i == _categories.length) {
            return Container(
              height: 50,
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('총합'),
                ],
              ),
            );
          }
          return Container(
            height: 50,
            width: 50,
            child: CategoryFieldWidget(),
          );
        },
        contentCellBuilder: (i, j) {
          // Row for Total
          if (j == _categories.length) {
            return Text(i.toString());
          } else {
            return Container(
              height: 50,
              width: 50,
              child: ScoreFieldWidget(),
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('후보 추가'),
                        onPressed: () {
                          addCandidate('추가');
                          Navigator.pop(context);
                        },
                      ),
                      RaisedButton(
                        child: Text('카테고리 추가'),
                        onPressed: () {
                          addCategory(Category(title: 'wow', weight: 5));
                          Navigator.pop(context);
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
      decoration: InputDecoration(labelText: "점수"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1),
      ],
    );
  }
}

class CandidateFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: "후보"),
    );
  }
}

class CategoryFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: "항목"),
    );
  }
}
