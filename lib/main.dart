import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

void main() {
  runApp(
    MyTable(),
  );
}

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
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
    return MaterialApp(
      home: Scaffold(
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
                height: 80,
                width: 80,
                child: CategoryFieldWidget(),
              );
            }
            return Container(
              height: 50,
              width: 50,
              child: CategoryFieldWidget(),
            );
          },
          contentCellBuilder: (i, j) => Container(
            height: 50,
            width: 50,
            child: ScoreFieldWidget(),
          ),
          legendCell: Text('항목 \\ 후보'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addCandidate('wow'),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
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
