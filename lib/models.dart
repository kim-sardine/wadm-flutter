import 'package:table_sticky_headers/table_sticky_headers.dart';

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
    // make list with weight and index
    List<Map<String, int>> indexWithWeight = [];
    for (var i = 0; i < this.categories.length; i++) {
      indexWithWeight.add({
        'index': i,
        'weight': this.categories[i].weight
      });
    }

    // sort by weight
    indexWithWeight.sort((a, b) => (b['weight'].compareTo(a['weight'])));

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
      candidate.scores.add(0);
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

}
