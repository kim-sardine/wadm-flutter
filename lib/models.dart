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
    // TODO: Implement Sorting
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
    // candidate's score * category's weight
    int total = 0;
    Candidate candidate = this.candidates[colIdx];

    for (var i = 0; i < this.categories.length; i++) {
      total += (this.categories[i].weight * candidate.scores[i]);
    }

    return total;
  }
}
