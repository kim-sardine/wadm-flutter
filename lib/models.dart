import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'dart:convert';

import 'package:wadm/main.dart';

class Category {
  String title;
  int weight;

  Category({this.title, this.weight});

  Category.fromJson(Map<String, dynamic> data)
    : title = data['title'],
      weight = data['weight'];

  Map<String, dynamic> toJson() => {
    'title': this.title,
    'weight': this.weight,
  };

  bool isDuplicated(Category category) {
    return this.title == category.title;
  }
}

class Candidate {
  String title;
  List<int> scores;

  Candidate({this.title, this.scores});

  Candidate.fromJson(Map<String, dynamic> data) 
    : title = data['title'],
      scores = data['scores'].cast<int>();

  Map<String, dynamic> toJson() => {
    'title': this.title,
    'scores': this.scores,
  };
}

class MyCellDimensions extends CellDimensions {
  final double contentCellWidth;
  final double contentCellHeight;
  final double stickyLegendWidth;
  final double stickyLegendHeight;

  const MyCellDimensions({
    this.contentCellWidth,
    this.contentCellHeight,
    this.stickyLegendWidth,
    this.stickyLegendHeight,
  });

  MyCellDimensions.fromJson(Map<String, dynamic> data)
  : contentCellWidth = data['contentCellWidth'],
    contentCellHeight = data['contentCellHeight'],
    stickyLegendWidth = data['stickyLegendWidth'],
    stickyLegendHeight = data['stickyLegendHeight'];

  Map<String, dynamic> toJson() => {
    'contentCellWidth': this.contentCellWidth,
    'contentCellHeight': this.contentCellHeight,
    'stickyLegendWidth': this.stickyLegendWidth,
    'stickyLegendHeight': this.stickyLegendHeight,
  };
}

const MyCellDimensions myCellDimensions = MyCellDimensions(
  contentCellWidth: 110,
  contentCellHeight: 70,
  stickyLegendWidth: 100,
  stickyLegendHeight: 60,
);

class WadmTable {
  List<Candidate> candidates;
  List<Category> categories;
  MyCellDimensions cellDimensions;

  WadmTable({
    this.candidates,
    this.categories,
    this.cellDimensions = myCellDimensions,
  });

  factory WadmTable.fromJson(Map<String, dynamic> data) {
    List<dynamic> decodedCandidates = json.decode(data['candidates']);
    List<Candidate> candidates = decodedCandidates.map((each) => Candidate.fromJson(each)).toList();

    List<dynamic> decodedCategory = json.decode(data['categories']);
    List<Category> categories = decodedCategory.map((each) => Category.fromJson(each)).toList();

    return WadmTable(
      candidates: candidates,
      categories: categories,
      cellDimensions: MyCellDimensions.fromJson(json.decode(data['cellDimensions']))
    );
  }

  Map<String, dynamic> toJson() => {
    'candidates': json.encode(this.candidates),
    'categories': json.encode(this.categories),
    'cellDimensions': json.encode(this.cellDimensions),
  };

  void sort() {
    // make list with weight and index
    List<Map<String, dynamic>> indexWithWeight = [];
    for (var i = 0; i < this.categories.length; i++) {
      indexWithWeight.add({
        'index': i,
        'weight': this.categories[i].weight,
        'title': this.categories[i].title,
      });
    }

    // sort by 1.weight, 2.title
    indexWithWeight.sort((a, b) {
      var compare = b["weight"].compareTo(a["weight"]);
      if (compare != 0) {
        return compare;
      }
      return a["title"].compareTo(b["title"]);
    });

    // update category
    List<Category> newCategory = [];
    for (var i = 0; i < this.categories.length; i++) {
      int targetIndex = indexWithWeight[i]['index'];
      newCategory.add(this.categories[targetIndex]);
    }
    this.categories = newCategory;

    // update candidate's score
    for (var i = 0; i < this.candidates.length; i++) {
      List<int> newScores = [];
      for (var j = 0; j < indexWithWeight.length; j++) {
        int targetIndex = indexWithWeight[j]['index'];
        newScores.add(this.candidates[i].scores[targetIndex]);
      }
      this.candidates[i].scores = newScores;
    }

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
      candidate.scores.add(1);
    }
    this.sort();
  }

  int getTotal(int colIdx) {
    // total = candidate's score * category's weight
    int total = 0;
    Candidate candidate = this.candidates[colIdx];

    for (var i = 0; i < this.categories.length; i++) {
      total += (this.categories[i].weight * candidate.scores[i]);
    }
    return total;
  }

  bool isEmptyTable() {
    return this.candidates.length == 0 && this.categories.length == 0;
  }
}
