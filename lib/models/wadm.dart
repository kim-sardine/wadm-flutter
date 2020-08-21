
import 'dart:convert';
import 'package:uuid/uuid.dart';

import './candidate.dart';
import './category.dart';


class Wadm {
  String id;
  String title;
  List<Candidate> candidates;
  List<Category> categories;

  Wadm({String id, String title, List<Candidate> candidates, List<Category> categories}) {
    if (id == null) { // TODO: Need to check if it work
      this.id = Uuid().v1();  
    }
    this.title = title;
    this.candidates = candidates;
    this.categories = categories;
  }

  factory Wadm.fromJson(Map<String, dynamic> wadm) {
    List<dynamic> decodedCandidates = json.decode(wadm['candidates']);
    List<Candidate> candidates = decodedCandidates.map<Candidate>((each) => Candidate.fromJson(each)).toList();

    List<dynamic> decodedCategory = json.decode(wadm['categories']);
    List<Category> categories = decodedCategory.map<Category>((each) => Category.fromJson(each)).toList();

    return Wadm(
      id: wadm['id'],
      title: wadm['title'],
      candidates: candidates,
      categories: categories,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'title': this.title,
    'candidates': json.encode(this.candidates),
    'categories': json.encode(this.categories),
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
